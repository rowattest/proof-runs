# Kit 1: Next.js Subscription Payments

Schema: schema.sql from supabase-community/nextjs-subscription-payments at commit [3aa0d956](https://github.com/supabase-community/nextjs-subscription-payments/blob/3aa0d956fb46dda45a6676f74ffa77eb0fe10a11/schema.sql), applied unchanged. Five tables: users, customers, products, prices, subscriptions. One product and two prices were seeded so that subscription rows could be created during the run; the seed SQL is [seed.sql](seed.sql) in this folder.

Run: October 17, 2026. Engine rowattest-engine 0.1.2. Report RA-01M55DE8NXN0282HMA9QKMT9JY. Verify: https://rowattest.com/verify/RA-01M55DE8NXN0282HMA9QKMT9JY

| Result | Cells |
| --- | --- |
| PASS | 19 |
| ALLOWED-BY-MODEL | 4 |
| In all | 23 |

Tables: 3 covered, 2 not evaluated, 0 declared public, 5 in all. 23 of 29 boundary checks were executable; 6 were not evaluated. Basis: 5 detected by RowAttest, 0 confirmed by the customer, 0 declared by the customer. Access model fingerprint (SHA-256): 33dcdaa8327dfc4296b745867bbd7ec14e8306c9664616a6dc11ab270ad96a8f

## What the report says, table by table

products and prices. The kit's policy "Allow public read-only access." lets anyone read every row, so the reads by an anonymous visitor and by another user are recorded as ALLOWED-BY-MODEL, not as leaks. Inserts by an anonymous visitor and by another user were denied: PASS.

subscriptions. Owned by one user through user_id. All 13 cells PASS: reads, updates and deletes by an anonymous visitor and by another user were denied, inserts that tried to attribute a row to someone else were denied, and an attempt by the owner to reassign a row to another user was denied.

users and customers. Not evaluated. Both tables are keyed by an id that references auth.users, and their policies compare auth.uid() with that id. RowAttest does not yet detect ownership through a primary key, so its access model marks both tables as Not sure; the report lists them with that reason and gives them no verdict.

## Catalog hygiene

4 checks run; 0 high, 1 medium, 0 to review. The medium item is the kit's handle_new_user function, which runs as SECURITY DEFINER without a fixed search_path. Supabase's own project linter lists the same condition as a WARN level item, [Function Search Path Mutable](https://supabase.github.io/splinter/0011_function_search_path_mutable).

## Cleanup

The kit's trigger on_auth_user_created inserts a public.users row for every new auth user, and public.users.id references auth.users without ON DELETE CASCADE. The run page records "Removed 2 rows from public.users that referenced the test users through id." followed by "Cleanup verified clean". A direct count on the project after the run showed 0 rows in users, customers and subscriptions, 0 auth users, 0 storage objects, and the seeded 1 product and 2 prices.

## Earlier runs on this kit

Two earlier runs on October 17, 2026 used engine 0.1.1: reports [RA-01M54ZKQPPY93HJQ24CA5GY2NN](https://rowattest.com/verify/RA-01M54ZKQPPY93HJQ24CA5GY2NN) and [RA-01M54ZY6VJWWSVY7KQWPSDAXG3](https://rowattest.com/verify/RA-01M54ZY6VJWWSVY7KQWPSDAXG3). That version rated handle_new_user high for being executable through the API, although a trigger function cannot be called that way, and its cleanup left 4 items behind because of the foreign key described above. Both engine faults were fixed in 0.1.2 before the run shown here. The earlier reports remain valid records of what that engine version observed.

## Reproduce it

Create a Supabase project, apply schema.sql from the commit above, run the seed SQL from the proof-runs repository, connect the project in RowAttest, run a Fit Check, then Run test. The repository holds the seed SQL, the public summary JSON of the report and the numbers on this page: https://github.com/rowattest/proof-runs

## Public fingerprints

From [the public summary](summary-RA-01M55DE8NXN0282HMA9QKMT9JY.json), fetched from https://app.rowattest.com/api/reports/RA-01M55DE8NXN0282HMA9QKMT9JY/summary on October 17, 2026:

- full_report_sha256: d556d7471366d603fd5d19808f1490d2a7a0159674164f412e49fdd8d516e782
- signature.report_sha256: d210b4426dca6d84b36fab09a02d578bf25dac8ba7d0e425cda126ab6fd776b3 (Ed25519, key 27499e4b)

A PASS applies only to the checks listed in the report, at the time of the run, against the schema as it existed then. It does not certify that the kit, or any application built on it, is secure.
