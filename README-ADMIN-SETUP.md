# Sineera — Admin Panel Setup

Your database is already live (Supabase project **sineera**), seeded with your
current content, and locked down with Row Level Security. There's one manual
step left before you can log in: creating your admin account. Supabase handles
the password — it's never typed into any file or chat.

## 1. Upload these files

Keep this exact folder structure on your host:

```
/index.html                 ← your site (updated)
/supabase-config.js         ← connection info (safe to be public)
/admin/index.html           ← the admin panel → yoursite.com/admin/
```

Any static host (Netlify, Vercel, Cloudflare Pages, GitHub Pages, cPanel,
etc.) will serve `/admin/` automatically from the `admin` folder's
`index.html`.

## 2. Create your admin login

1. Go to your [Supabase dashboard](https://supabase.com/dashboard/project/nricbtngrocrlovrbyow) → **Authentication → Users → Add user**.
2. Enter your email and a password (check "Auto Confirm User").
3. Come back and tell me the email you used — I'll run one line of SQL to
   grant that account admin access (adds it to the `admin_users` table).
   Nobody gets write access to your site just by having a login; only
   accounts explicitly added there can change anything.

Until an account is added to `admin_users`, it can sign in but the panel will
immediately sign it back out with "This account isn't authorized for admin
access" — that's expected and by design.

## 3. Log in

Visit `yoursite.com/admin/`, sign in, and you're in. From there you can manage:

- **Homepage** — hero image and headline
- **Categories** — the genre tiles (add/edit/delete/reorder/publish)
- **Gallery** — every photo; adding a URL already used elsewhere is blocked
  automatically, so nothing gets duplicated across categories
- **Stories** — the new "Field Notes" section on the homepage
- **Services** — the offerings list and the contact form's dropdown
- **About** — bio and stat counters
- **Settings** — phone, email, social links, footer text
- **Inquiries** — everything submitted through the contact form

Every change saves straight to the database and appears on the live site the
next time a visitor loads the page — no redeploy needed.

## How the security works

- Visitors can only ever *read* published content and *submit* an inquiry —
  enforced by the database itself (Row Level Security), not just hidden in
  the interface.
- Only Supabase accounts listed in `admin_users` can create, edit, delete, or
  publish anything.
- The key in `supabase-config.js` is a public "anon" key — it's designed to be
  visible in client-side code and can't bypass the rules above. Never add a
  `service_role` key or any password to a front-end file.
- If you ever need to remove someone's admin access, tell me their email and
  I'll remove them from `admin_users` — their login stops being able to write
  anything immediately, without changing their password.

## If Supabase is ever unreachable

`index.html` keeps the original hardcoded content as a silent fallback, so a
network hiccup or misconfiguration never takes the live site down — it just
temporarily stops reflecting your latest admin edits until the connection is
back.
