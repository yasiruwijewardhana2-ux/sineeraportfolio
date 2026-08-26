/* ============================================================
   SINEERA — Supabase connection config
   ------------------------------------------------------------
   This is the ONE place that points the site and the admin
   panel at your Supabase project. Both index.html and
   admin/index.html load this file before anything else.

   The anon key below is safe to expose in client-side code —
   it is a public, restricted key. All real protection comes
   from the Row Level Security policies on the database
   (public visitors can only read published content and submit
   inquiries; only accounts listed in the admin_users table can
   write). Never put a service_role key or a password in this
   file or anywhere in the front end.
   ============================================================ */
window.SUPABASE_URL = "https://nricbtngrocrlovrbyow.supabase.co";
window.SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5yaWNidG5ncm9jcmxvdnJieW93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc0NDg4MTEsImV4cCI6MjEwMzAyNDgxMX0.YWCX1JiIn2w9ugHdQdqseSiAIIw77wlCvPjwlpJhAPs";
