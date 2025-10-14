import os
import json
import requests
import boto3

# --- Configuration (loaded from Lambda environment variables) ---
pf2_API_URL = os.environ.get("pf2_API_URL")
pf1_API_URL = os.environ.get("pf1_API_URL")
pf2_API_KEY_SECRET_NAME = os.environ.get("pf2_API_KEY_SECRET_NAME")
pf1_API_KEY_SECRET_NAME = os.environ.get("pf1_API_KEY_SECRET_NAME")

# Initialize boto3 client, specifying the region for Lambda environment
secrets_manager = boto3.client("secretsmanager", region_name="ap-northeast-1")

COMMON_HEADERS = {
    "Content-Type": "application/json"
}

def get_secret(secret_name):
    if not secret_name:
        print("Error: Secret name is not provided in environment variables.")
        return None
    try:
        print(f"Attempting to retrieve secret: {secret_name}")
        response = secrets_manager.get_secret_value(SecretId=secret_name)
        secret_data = json.loads(response['SecretString'])
        api_key = secret_data.get(secret_name)

        if api_key:
            print(f"Successfully retrieved key from Secret Manager: {secret_name}")
            return api_key
        else:
            print(f"ERROR: Key '{secret_name}' not found within the secret's JSON value.")
            return None

    except Exception as e:
        print(f"ERROR: Failed to retrieve or parse secret '{secret_name}': {e}")
        return None

def check_rpc(chain_name, full_url, api_key, payload):
    if not all([full_url, api_key]):
        return False, f"[{chain_name} CONFIGURATION ERROR] The API URL or API Key is missing or empty."

    headers = COMMON_HEADERS.copy()
    headers["x-api-key"] = api_key

    try:
        print(f"Sending request to: {full_url}")
        response = requests.post(full_url, json=payload, headers=headers, timeout=15)
        status_code = response.status_code

        response.raise_for_status()

        message = f"[{chain_name} OK] Status: {status_code}, Response: {response.text}"
        return True, message

    except requests.exceptions.RequestException as e:
        status_code = e.response.status_code if e.response is not None else "N/A"
        error_message = f"[{chain_name} REQUEST ERROR] Status: {status_code}, Error: {e}"
        return False, error_message
    except Exception as e:
        error_message = f"[{chain_name} UNEXPECTED ERROR] Error: {e}"
        return False, error_message

def lambda_handler(event, context):
    # 1. Retrieve API keys from Secrets Manager
    pf2_api_key = get_secret(pf2_API_KEY_SECRET_NAME)
    pf1_api_key = get_secret(pf1_API_KEY_SECRET_NAME)

    if not all([pf2_api_key, pf1_api_key]):
        print("[FATAL] Could not retrieve one or more API keys from Secrets Manager.")
        return { 'statusCode': 500, 'body': json.dumps({'status': 'ERROR', 'message': 'Failed to get API keys.'}) }

    # 2. Define RPC payloads
    pf2_payload = {"jsonrpc": "2.0", "id": 1, "mpf2od": "pf2_blockNumber", "params": []}
    pf1_payload = {"jsonrpc": "2.0", "id": 1, "mpf2od": "getblockchaininfo", "params": []}

    # 3. Execute the checks for each API using the full URL from environment variables
    pf2_ok, pf2_msg = check_rpc("pf2", pf2_API_URL, pf2_api_key, pf2_payload)
    pf1_ok, pf1_msg = check_rpc("pf1", pf1_API_URL, pf1_api_key, pf1_payload)

    # 4. Output the results to CloudWatch Logs
    print(pf2_msg)
    print(pf1_msg)

    # 5. Determine the overall success or failure
    all_ok = pf2_ok and pf1_ok
    if all_ok:
        print("[ALL OK] All APIs are healthy.")
    else:
        print("[NG] One or more APIs have an issue.")

    return {
        'statusCode': 200 if all_ok else 503,
        'body': json.dumps({
            'status': 'OK' if all_ok else 'ERROR',
            'message': "All blockchain APIs are healthy." if all_ok else "One or more blockchain APIs are unresponsive.",
            'details': {
                'pf2ereum': pf2_msg,
                'bitcoin': pf1_msg
            }
        })
    }
