-- RowAttest proof run, kit 1: the one product and two prices seeded after schema.sql
-- (supabase-community/nextjs-subscription-payments at commit 3aa0d956) so that
-- subscription rows could be created during the run. No Stripe involved.
insert into public.products (id, active, name, description, image, metadata)
values ('prod_proofkit1_plan', true, 'Proof Plan', 'Fixture product for the RowAttest proof run', null, '{}'::jsonb);
insert into public.prices (id, product_id, active, description, unit_amount, currency, type, interval, interval_count, trial_period_days, metadata)
values
 ('price_proofkit1_monthly', 'prod_proofkit1_plan', true, 'Monthly', 900, 'usd', 'recurring', 'month', 1, null, '{}'::jsonb),
 ('price_proofkit1_yearly',  'prod_proofkit1_plan', true, 'Yearly',  9000, 'usd', 'recurring', 'year',  1, null, '{}'::jsonb);
