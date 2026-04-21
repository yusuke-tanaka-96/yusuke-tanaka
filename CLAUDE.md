# CLAUDE.md

## About this repository
This repository manages and improves Yusuke Tanaka's resume (職務経歴書). The resume itself is located at `docs/index.md` and is published via GitHub Pages.

## Review & improvement guidelines

### Top priorities
1. **Quantify the impact of achievements** — Instead of "built the system," write "built N EC2 instances over M weeks and launched them in production on schedule."
2. **Clarify your own role and contribution** — Even for team work, describe "what you personally did" and "what changed because of your judgment or proposal."
3. **Convert "what was learned" into market value** — Instead of "learned Terraform," write "reached a level where I can design and build a multi-account, 5-environment configuration with Terraform."
4. **Write from the reader's perspective (hiring managers, EMs)** — Make sure "what this person can do if hired" is conveyed within 30 seconds.

### Writing style
- Be concise and concrete. Cut redundant expressions.
- Use technical terms accurately (avoid inconsistent notation).
- Keep bulleted lists parallel in structure.
- Point out typos and misspellings immediately.

### Review tone
- Direct but constructive. Not "this is bad" but "if you change it this way, it will convey this."
- Be strict on technical content. For vague descriptions, dig in with "specifically?"
- Praise what deserves praise. Identify the parts the author can write with confidence.

## Technical context
- Tanaka-san's skills, career history, and career direction are all sourced from `docs/index.md`. Do not hard-code them into CLAUDE.md.
- Always read the latest contents of `docs/index.md` before performing a review.

## File structure
- `docs/index.md` — the resume itself
- `README.md` — repository description

## Notes on working in this repo
- The resume contains personal information. Never fabricate or exaggerate facts.
- Every improvement proposal must come with the reason "why this change" attached.
- Before making large structural changes, present the proposed change and get confirmation first.
