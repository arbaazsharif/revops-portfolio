"""
Project 6 - Step 1: Prove the Apollo API connection works.

We call the Organization Enrichment endpoint for one known company
(apollo.io itself), print a summary, and also save the FULL raw
response to a file so we can inspect exactly what fields Apollo
gives us (funding stage, technologies, headcount, etc.) before we
design the scoring logic around them.
"""

import os
import json
import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("APOLLO_API_KEY")
ENDPOINT = "https://api.apollo.io/api/v1/organizations/enrich"

def enrich_company(domain: str) -> dict:
    headers = {
        "accept": "application/json",
        "x-api-key": API_KEY,
    }
    params = {"domain": domain}

    response = requests.get(ENDPOINT, headers=headers, params=params)
    response.raise_for_status()
    return response.json()

if __name__ == "__main__":
    if not API_KEY:
        raise SystemExit("APOLLO_API_KEY not found. Add it to your .env file.")

    data = enrich_company("apollo.io")
    org = data.get("organization", {})

    print("Connection successful.\n")
    print(f"Name:      {org.get('name')}")
    print(f"Domain:    {org.get('domain')}")
    print(f"Industry:  {org.get('industry')}")
    print(f"Employees: {org.get('estimated_num_employees')}")

    with open("apollo_response_sample.json", "w") as f:
        json.dump(data, f, indent=2)
    print("\nFull raw response saved to apollo_response_sample.json")
