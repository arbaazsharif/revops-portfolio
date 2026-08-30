# Apollo API-Enriched Dead Deal Revival System

A Python pipeline that takes closed-lost deals, enriches each company with live external data via the Apollo.io API, scores every deal for revival potential, and generates a personalized re-engagement email for the strongest candidates using the Claude API.

## The problem this solves

Closed-lost deals aren't dead, they're just data sitting in a CRM. A deal lost to "bad timing" a year ago might be a live opportunity today if the company has grown, raised funding, or changed its tech stack since. Most sales teams never revisit lost deals systematically because doing it manually by researching every company, judging which ones are worth a second look, writing a personalized note for each, doesn't scale. This project automates that entire judgment call with live data instead of guesswork.

## How it works

1. **Pull the deals.** A 27-record closed-lost deal dataset (company, deal size, close date, loss reason, sales cycle length) is pulled from PostgreSQL.
2. **Resolve to a domain.** Each company is resolved to a real, verified web domain — the identifier Apollo's API needs to look a company up.
3. **Enrich via the Apollo API.** For every company, a live call to Apollo's Organization Enrichment endpoint pulls current firmographic data: industry, employee count, 12-month headcount growth, and technology stack.
4. **Score for revival potential.** A weighted model combines three independent signals — the original loss reason, recent headcount growth, and company size fit — into a 0-90 score, then buckets each deal into Hot / Warm / Cold.
5. **Generate outreach via the Claude API.** For every Hot and Warm deal, a call to Claude's Messages API generates a short, specific re-engagement email that references the real reason the deal was lost and the concrete signal that makes now a better time to reconnect, not a generic template.

## Why the API calls are the point

This isn't a scoring spreadsheet with static inputs. Steps 3 and 5 are live, authenticated calls to two different third-party APIs, each returning real data that directly shapes the output: Apollo's response changes the score, and the score changes what Claude is told to write. Every email in `generated_emails.md` was generated from that specific company's actual enriched data — nothing here is hand-written or templated.

## Results from this run

- 27 deals scored: **5 Hot**, 15 Warm, 7 Cold
- 20 personalized re-engagement emails generated (Hot + Warm tiers — Cold deals are deliberately excluded, since a real revival campaign wouldn't spend outreach effort there)
- Top revival candidate scored 70/90, driven by strong headcount growth combined with a non-product loss reason (timing, not fit)

## Tech stack

Python · PostgreSQL · Apollo.io API · Claude API (Anthropic) · Beekeeper Studio

## Files

| File | Purpose |
|---|---|
| `test_connection.py` | First proof-of-concept Apollo API call |
| `closed_lost_deals.csv` | Source deal records |
| `company_domain_map.csv` | Company-to-domain resolution layer |
| `enrich_deals.py` | Batch Apollo enrichment for all 27 deals |
| `enriched_deals.csv` | Deals + live Apollo firmographic data |
| `score_deals.py` | Revival scoring model |
| `scored_deals.csv` | Final scored + tiered output |
| `generate_emails.py` | Claude API email generation |
| `generated_emails.md` | 20 personalized re-engagement emails |

## What I'd build next in production

Point-level contact resolution (Apollo People Search) to find a real contact at each company, and a send integration (Gmail API or HubSpot) to push generated emails directly into a sequence — the same pattern used in Project 2 (Dead Deal Resurrection System), extended with live enrichment and AI-generated copy instead of static templates.

