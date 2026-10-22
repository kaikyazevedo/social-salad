-- SOCIAL SALAD MVP v1 — standalone PERSONAL Supabase project only.
-- Apply only in newly created Social Salad project, NEVER on THAC.
create extension if not exists pgcrypto;

create table public.brands (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null check (char_length(trim(name)) between 1 and 120),
  description text not null default '',
  accent text not null default '#EF2EC4',
  created_at timestamptz not null default now()
);
create table public.work_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  brand_id uuid references public.brands(id) on delete cascade,
  kind text not null check(kind in ('conteudo','tarefa','campanha')),
  title text not null check (char_length(trim(title)) between 1 and 200),
  description text not null default '',
  status text not null default 'ideia' check(status in ('ideia','producao','revisao','agendado','concluido')),
  channel text not null default '',
  due_date date,
  created_at timestamptz not null default now(),
  constraint brand_user_link unique (id,user_id)
);
create index brands_user_idx on public.brands(user_id);
create index work_items_user_due_idx on public.work_items(user_id,due_date);
create index work_items_brand_idx on public.work_items(brand_id);

-- Prevent associating an item with somebody else's brand, including on update.
create or replace function public.check_work_item_brand_owner() returns trigger
language plpgsql set search_path = '' as $$
begin
  if new.brand_id is not null and not exists (
    select 1 from public.brands b
    where b.id = new.brand_id and b.user_id = new.user_id
  ) then raise exception 'Marca indisponível para este usuário';
  end if;
  return new;
end $$;
create trigger ensure_item_brand_owner before insert or update on public.work_items
for each row execute function public.check_work_item_brand_owner();


-- This is a single-owner system. Public clients cannot see the allowlist.
create schema if not exists private;
revoke all on schema private from public, anon;
create table private.authorized_emails (
  email text primary key check (email = lower(email))
);
revoke all on private.authorized_emails from public, anon, authenticated;
alter table private.authorized_emails enable row level security;

-- Explicit allowlist + verified email: other Supabase Auth accounts cannot read/write even their own rows.
-- Kept in the unexposed private schema; never accept user-supplied email as authority.
create or replace function private.is_authorized() returns boolean
language sql stable security definer set search_path = ''
as $auth$
  select exists (
    select 1 from auth.users u
    join private.authorized_emails allowlist on allowlist.email = lower(u.email)
    where u.id = (select auth.uid())
      and u.email_confirmed_at is not null
  );
$auth$;
revoke all on function private.is_authorized() from public, anon;
grant usage on schema private to authenticated;
grant execute on function private.is_authorized() to authenticated;

alter table public.brands enable row level security;
alter table public.work_items enable row level security;
create policy "brands_select_own" on public.brands for select to authenticated using ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "brands_insert_own" on public.brands for insert to authenticated with check ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "brands_update_own" on public.brands for update to authenticated using ((select auth.uid())=user_id and (select private.is_authorized())) with check ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "brands_delete_own" on public.brands for delete to authenticated using ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "items_select_own" on public.work_items for select to authenticated using ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "items_insert_own" on public.work_items for insert to authenticated with check ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "items_update_own" on public.work_items for update to authenticated using ((select auth.uid())=user_id and (select private.is_authorized())) with check ((select auth.uid())=user_id and (select private.is_authorized()));
create policy "items_delete_own" on public.work_items for delete to authenticated using ((select auth.uid())=user_id and (select private.is_authorized()));
grant usage on schema public to authenticated;
grant select,insert,update,delete on public.brands, public.work_items to authenticated;
revoke all on public.brands,public.work_items from anon;
