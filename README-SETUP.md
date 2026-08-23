# SINEERA Admin Panel — Setup

You now have 3 files:
- `index.html` — the live site (loads its content from Supabase, falls back to built-in defaults)
- `admin.html` — the password-protected control panel (password: `keshan@2006yasiru`)
- `supabase-schema.sql` — the database setup script

## 1. Create a Supabase project
1. Go to https://supabase.com → New Project (free tier is enough).
2. Wait for it to finish provisioning (~2 min).

## 2. Run the schema
1. In your project, open **SQL Editor → New query**.
2. Paste the entire contents of `supabase-schema.sql` and click **Run**.
3. This creates 4 tables (`hero_slides`, `gallery_items`, `testimonials`, `services`), a public storage bucket called `sineera-media` for your photos, and seeds them with the content already on your site so nothing looks empty on day one.

## 3. Get your API keys
1. In your project: **Settings → API**.
2. Copy the **Project URL** and the **anon public** key (not the `service_role` key — never put that one in a browser-facing file).

## 4. Connect both files
Open `index.html` and `admin.html` in a text editor. In **both** files find:

```js
var SUPABASE_URL = "YOUR_SUPABASE_URL";
var SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
```

and paste in your real values. Save both files.

## 5. Use it
- Open `admin.html`, log in with `keshan@2006yasiru`.
- Four tabs: **Hero Banner**, **Gallery Photos**, **Testimonials**, **Services**.
- "Add New" opens a form — upload a photo where relevant, fill in the text, click **Save**.
- Use the ↑ / ↓ buttons on each row to reorder (hero rotation order, gallery order, etc).
- Changes are live immediately — refresh `index.html` and they're there.

## Changing the password
Open `admin.html`, find:
```js
var ADMIN_PASSWORD = "keshan@2006yasiru";
```
and change it to whatever you like. That's the only place it lives.

## A note on security
This admin panel is gated by a password typed into the page itself — simple and fast to set up, but it's not the same as real user authentication. Anyone who has your Supabase anon key and knows the table names could technically write to the database directly, bypassing the password screen entirely. For a personal portfolio site this is a reasonable trade-off, but if this ever needs to be locked down harder (e.g. someone else hosts/forks the site), the next step up is switching to **Supabase Auth** with a real login and Row Level Security policies scoped to a specific user — worth asking for if you get there.

## If something doesn't load
- Double-check the schema ran without errors (Supabase SQL Editor shows a green success message).
- Confirm `sineera-media` shows up under **Storage** in your Supabase dashboard, marked **Public**.
- Open the browser console (F12) on `admin.html` or `index.html` — errors from Supabase show up there with the actual reason.
