# Project 3: Rep Performance Scorecard Dashboard

## Project Overview
Novu Software is a B2B SaaS company selling a project management platform to small and mid-market businesses. With a team of 5 quota-carrying Account Executives, leadership needed visibility into rep-level performance to make informed coaching and resource allocation decisions.

As the RevOps Analyst on this project, I built a Rep Performance Scorecard Dashboard to answer the questions the VP of Sales couldn't answer from raw CRM data alone — who is winning, who is losing and why, which deal sources drive the best outcomes, and how revenue is trending month over month.

**Tools used:** PostgreSQL (Beekeeper Studio), Google Sheets, Looker Studio, Claude AI (used for dataset design guidance and query debugging)

## Data Model
The database consists of two tables built in PostgreSQL.

The **reps** table stores information on each Account Executive — their name, region, hire date, and annual quota. Each rep is assigned a unique `rep_id` as the primary key.

The **deals** table stores all closed deals — including company name, deal stage, close date, amount, deal source, loss reason, sales cycle days, and segment (SMB or Mid-Market). Each deal is linked back to its rep via `rep_id` as a foreign key, allowing the two tables to be joined for analysis.

## Key Findings
- Marcus Allen leads the team with a 69.2% win rate and $236,000 in closed revenue, making him the top performer by both metrics.
- Jordan Cole lost 5 of his 7 deals to competitors, indicating a competitive positioning problem rather than a pipeline or pricing issue. Battlecard training is recommended.
- Sofia Reyes wins SMB deals consistently but struggles in mid-market, reflected in the team's lowest average deal size of $12,714. Mid-market coaching is the priority.
- Referral leads close at 100%, inbound at 88.5%, and outbound at just 11.1% — suggesting the outbound motion needs to be re-evaluated as a resource allocation decision.
- No rep exceeded 57% quota attainment, indicating a team-wide performance gap that warrants a quota or pipeline review at the leadership level.

## Dashboard
The live dashboard provides an interactive view of rep performance across win rate, revenue, quota attainment, loss reasons, and monthly revenue trend.

🔗 [View Live Dashboard](https://datastudio.google.com/s/sxQBQMfpCz0)
