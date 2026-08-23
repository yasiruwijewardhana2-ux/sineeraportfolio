-- ============================================================
-- SINEERA — Supabase schema
-- Run this once in your Supabase project's SQL editor
-- (Dashboard → SQL Editor → New query → paste → Run)
-- ============================================================

create extension if not exists "pgcrypto";

-- ---------- HERO BANNER SLIDES ----------
create table if not exists hero_slides (
  id uuid primary key default gen_random_uuid(),
  category text not null,          -- e.g. "Weddings"
  title text not null,             -- e.g. "A Monsoon Vow"
  image_url text not null,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

-- ---------- PORTFOLIO / GALLERY PHOTOS ----------
create table if not exists gallery_items (
  id uuid primary key default gen_random_uuid(),
  category text not null check (category in ('weddings','events','portraits','birthdays','preshoots','commercial')),
  title text not null,
  alt_text text not null default '',
  image_url text not null,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

-- ---------- TESTIMONIALS ----------
create table if not exists testimonials (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text not null default '',
  quote text not null,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

-- ---------- SERVICES ----------
create table if not exists services (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text not null default '',
  price text not null default '',
  image_url text,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

-- ============================================================
-- Row Level Security
-- Public (anon key) can READ everything — needed for the live
-- website to display content to visitors.
-- Public (anon key) can also WRITE — needed because the admin
-- panel only gates access with a password typed into the page,
-- not real Supabase Auth. See README-SETUP.md for the security
-- trade-off and how to lock this down further later.
-- ============================================================
alter table hero_slides enable row level security;
alter table gallery_items enable row level security;
alter table testimonials enable row level security;
alter table services enable row level security;

create policy "Public read hero_slides"   on hero_slides   for select using (true);
create policy "Public read gallery_items" on gallery_items for select using (true);
create policy "Public read testimonials"  on testimonials  for select using (true);
create policy "Public read services"      on services      for select using (true);

create policy "Public write hero_slides"   on hero_slides   for all using (true) with check (true);
create policy "Public write gallery_items" on gallery_items for all using (true) with check (true);
create policy "Public write testimonials"  on testimonials  for all using (true) with check (true);
create policy "Public write services"      on services      for all using (true) with check (true);

-- ============================================================
-- Storage bucket for uploaded photos
-- ============================================================
insert into storage.buckets (id, name, public)
values ('sineera-media', 'sineera-media', true)
on conflict (id) do nothing;

create policy "Public read sineera-media"
  on storage.objects for select
  using (bucket_id = 'sineera-media');

create policy "Public upload sineera-media"
  on storage.objects for insert
  with check (bucket_id = 'sineera-media');

create policy "Public update sineera-media"
  on storage.objects for update
  using (bucket_id = 'sineera-media');

create policy "Public delete sineera-media"
  on storage.objects for delete
  using (bucket_id = 'sineera-media');

-- ============================================================
-- Seed data — mirrors what's already hand-written in index.html,
-- so the site looks identical the moment you switch it live.
-- Delete/edit any of this from admin.html afterwards.
-- ============================================================

insert into hero_slides (category, title, image_url, sort_order) values
  ('Weddings',   'A Monsoon Vow',    'https://picsum.photos/seed/sineera-wed-01/1800/2200', 0),
  ('Portraits',  'Still Light',      'https://picsum.photos/seed/sineera-por-01/1800/2200', 1),
  ('Events',     'The After Hours',  'https://picsum.photos/seed/sineera-evt-01/1800/2200', 2),
  ('Pre-Shoots', 'Before the Vows',  'https://picsum.photos/seed/sineera-pre-01/1800/2200', 3),
  ('Commercial', 'Object Study 04',  'https://picsum.photos/seed/sineera-com-01/1800/2200', 4),
  ('Birthdays',  'Turning Seven',    'https://picsum.photos/seed/sineera-bday-01/1800/2200', 5);

insert into gallery_items (category, title, alt_text, image_url, sort_order) values
  ('weddings',  'A Monsoon Vow',            'Bride laughing during a monsoon wedding ceremony',        'https://picsum.photos/seed/sineera-wed-01/800/1050', 0),
  ('portraits', 'Still Light',              'Editorial portrait of a woman lit by window light',       'https://picsum.photos/seed/sineera-por-01/800/1000', 1),
  ('events',    'The After Hours',          'Guests dancing at a candle-lit evening event',             'https://picsum.photos/seed/sineera-evt-01/800/1100', 2),
  ('weddings',  'Two Families, One Table',  'Wedding families gathered around a decorated table',       'https://picsum.photos/seed/sineera-wed-02/800/650',  3),
  ('preshoots', 'Before the Vows',          'Couple walking through a field during a pre-wedding shoot','https://picsum.photos/seed/sineera-pre-01/800/1050', 4),
  ('commercial','Object Study 04',          'Minimal product photography of a leather bag',             'https://picsum.photos/seed/sineera-com-01/800/800',  5),
  ('birthdays', 'Turning Seven',            'Child blowing out birthday candles surrounded by family',  'https://picsum.photos/seed/sineera-bday-01/800/620', 6),
  ('portraits', 'The Long Look',            'Close-up editorial portrait with dramatic shadow',         'https://picsum.photos/seed/sineera-por-02/800/1120', 7),
  ('events',    'Corner Office',            'Corporate event guests in conversation',                   'https://picsum.photos/seed/sineera-evt-02/800/980',  8),
  ('weddings',  'First Look',               'Groom''s reaction seeing the bride for the first time',    'https://picsum.photos/seed/sineera-wed-03/800/1150', 9),
  ('preshoots', 'Coastline',                'Couple silhouetted on a coastal cliff at sunset',           'https://picsum.photos/seed/sineera-pre-02/800/700', 10),
  ('commercial','Campaign 02',              'Fashion campaign photograph on a plain backdrop',           'https://picsum.photos/seed/sineera-com-02/800/1020',11),
  ('birthdays', 'Balloons at Dusk',         'Birthday celebration with balloons at dusk',                'https://picsum.photos/seed/sineera-bday-02/800/920',12),
  ('portraits', 'In Character',             'Character portrait with theatrical lighting',               'https://picsum.photos/seed/sineera-por-03/800/1100',13),
  ('events',    'Toast',                    'Guests raising a toast at an evening celebration',          'https://picsum.photos/seed/sineera-evt-03/800/610', 14),
  ('weddings',  'The Long Way Home',        'Bride and groom walking away down a long aisle at dusk',    'https://picsum.photos/seed/sineera-wed-04/800/1180',15);

insert into testimonials (name, role, quote, sort_order) values
  ('Ananya Kapoor', 'Bride, Udaipur Wedding',       'SINEERA didn''t just document our wedding, they directed it like a film we''re still watching back. Every frame felt intentional.', 0),
  ('Studio Loom',   'Creative Director',            'We''ve hired a lot of photographers for campaign work. Nobody else treats a product shoot with the same patience as a portrait.', 1),
  ('Ravi Mendis',   'Founder, Ari & Co.',           'Our launch event needed someone who could move through a room without disrupting it. That''s exactly what we got.', 2);

insert into services (name, description, price, image_url, sort_order) values
  ('Weddings',                'Full-day documentary coverage, cinematic edits, and albums built to be reopened for decades.',        '', 'https://picsum.photos/seed/sineera-svc-wed/300/380', 0),
  ('Pre-Wedding & Couples',   'Story-led shoots across locations that actually mean something to the two of you.',                    '', 'https://picsum.photos/seed/sineera-svc-pre/300/380', 1),
  ('Events & Celebrations',   'Corporate gatherings, birthdays, and milestones — captured as they unfold, not staged after.',         '', 'https://picsum.photos/seed/sineera-svc-evt/300/380', 2),
  ('Portraits',               'Editorial portraiture for individuals, families, and founders who want to be seen clearly.',            '', 'https://picsum.photos/seed/sineera-svc-por/300/380', 3),
  ('Commercial',              'Product, campaign, and brand photography shot with the same intent as any other frame.',                '', 'https://picsum.photos/seed/sineera-svc-com/300/380', 4);
