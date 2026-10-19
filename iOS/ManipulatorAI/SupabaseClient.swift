import Foundation
import Supabase

// TODO: Replace these with your actual Supabase project credentials.
// 1. Go to https://supabase.com and create a project (or use an existing one).
// 2. Copy the project URL and anon key from Settings → API.
// 3. In the Supabase dashboard, enable Apple provider under Authentication → Providers.
let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://tvgpukzgmcmlrjlsdang.supabase.co")!,
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR2Z3B1a3pnbWNtbHJqbHNkYW5nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk0NzY4NjksImV4cCI6MjA4NTA1Mjg2OX0.FGGhqTnXYuOTM8vcp7-uYsqihi8k_gbCo2pIVyEQwVk"
)
