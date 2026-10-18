# RowAttest proof runs

Signed RowAttest runs against public Supabase starter kits. Each kit's schema was deployed as published to a Supabase project owned by RW Digital Ventures LLC and tested through the normal RowAttest flow: connect with Supabase OAuth, read the schema and policies, run. The numbers below are quoted from the signed reports. The verify link opens the signed summary of that run in your browser.

| Kit | Schema | Run date | Engine | PASS | ALLOWED-BY-MODEL | Cells | Tables covered | Report |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [Next.js Subscription Payments](kit1-nextjs-subscription-payments/README.md) | supabase-community/nextjs-subscription-payments, schema.sql at 3aa0d956 | 2026-10-17 | 0.1.2 | 19 | 4 | 23 | 3 of 5 | [RA-01M55DE8NXN0282HMA9QKMT9JY](https://rowattest.com/verify/RA-01M55DE8NXN0282HMA9QKMT9JY) |

A PASS applies only to the checks listed in the report, at the time of the run, against the schema as it existed then. It does not certify that a kit, or any application built on it, is secure.

Page: https://rowattest.com/proof

Each kit folder holds the seed SQL used after the kit's schema, the public summary JSON of the signed report, and the numbers shown on the page. The kits' own schema files are not copied here; they are linked at the commit that was deployed.
