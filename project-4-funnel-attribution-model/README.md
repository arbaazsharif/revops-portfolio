# Project 4: Full Funnel Attribution Model

## Project Overview
Novu Software needed visibility into where deals were dying in their 
sales pipeline. As the RevOps Analyst, I built a full funnel attribution 
model to track how deals move through each stage — from Lead to Closed Won 
— and identify where the biggest conversion bottlenecks exist.

The project includes a Claude API integration that automatically generates 
a plain-English executive summary from the SQL output, giving leadership 
instant narrative context alongside the raw numbers.

**Tools used:** PostgreSQL (Beekeeper Studio), Google Sheets, Looker Studio, 
Python, Claude API

## Data Model
Built a new `funnel_events` table inside the existing `novu` PostgreSQL 
schema. Each row represents one deal passing through one pipeline stage, 
capturing entry date, exit date, days in stage, and outcome. With 65 deals 
across 5 stages, the table contains 309 rows of funnel journey data.

The `funnel_events` table connects to the existing `deals` table via 
`deal_id` as a foreign key, and through `deals` to the `reps` table via 
`rep_id`, enabling stage-level analysis by rep and deal source.

## Key Findings
- Novu's funnel is healthy in early stages — Lead and Discovery Call both 
convert at 100%, meaning qualification and initial outreach are working well.
- The critical bottleneck is Proposal Sent, where conversion drops to 78.1% 
and 14 deals are lost. This is where pricing misalignment and competitive 
comparisons kill deals.
- Outbound deals collapse at Negotiation with only 20% conversion, compared 
to 100% for both Inbound and Referral at the same stage. Outbound volume is 
not translating to revenue.
- Jordan Cole converts only 53.8% of his proposals — the lowest on the team 
and 25 points below the next worst performer — confirming a competitive 
positioning problem at the proposal stage specifically.
- Deals spend an average of 17.1 days in Negotiation, the longest of any 
stage, meaning the most expensive part of the sales cycle is also where 
deals are most likely to die.

## Claude API Insight Layer
After completing the SQL analysis, I built a Python script that sends the 
funnel summary data to the Claude API and receives an AI-generated 
executive narrative automatically. This gives leadership both the numbers 
and the story in one workflow — no manual write-up required.

The generated insight summary is included in this repo as 
`funnel_insight_summary.txt`.

## Dashboard
The live dashboard provides an interactive view of funnel conversion rates, 
drop-off by stage, average days per stage, and rep-level conversion 
breakdown.

🔗 [View Live Dashboard](https://datastudio.google.com/reporting/0658d1b6-ee38-4dbb-922e-fd8198c19c48)
