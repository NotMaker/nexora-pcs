-- NEXORA PC database schema (Supabase SQL Editor)
create extension if not exists pgcrypto;

create table if not exists public.admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text not null,
  price numeric(12,2) not null default 0 check (price >= 0),
  description text not null default '',
  image_url text not null default '',
  featured boolean not null default false,
  stock integer not null default 0 check (stock >= 0),
  created_at timestamptz not null default now()
);

alter table public.admins enable row level security;
alter table public.products enable row level security;

-- A visitor can see products, but only a user listed in admins can change them.
create policy "Anyone can read products" on public.products
  for select using (true);

create policy "Only admins can insert products" on public.products
  for insert to authenticated
  with check (exists (select 1 from public.admins where user_id = auth.uid()));

create policy "Only admins can update products" on public.products
  for update to authenticated
  using (exists (select 1 from public.admins where user_id = auth.uid()))
  with check (exists (select 1 from public.admins where user_id = auth.uid()));

create policy "Only admins can delete products" on public.products
  for delete to authenticated
  using (exists (select 1 from public.admins where user_id = auth.uid()));

create policy "Users can read their own admin membership" on public.admins
  for select to authenticated
  using (user_id = auth.uid());

-- SETUP OWNER:
-- 1) Create your owner account in Supabase Authentication > Users.
-- 2) Copy its User UID.
-- 3) Run this SQL after replacing YOUR_AUTH_USER_UUID:
-- insert into public.admins (user_id) values ('YOUR_AUTH_USER_UUID');
--
-- Optional sample products can be added from the owner dashboard after login.
