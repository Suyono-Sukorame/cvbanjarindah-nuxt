import { createClient } from '@supabase/supabase-js';

export default defineNuxtPlugin(() => {
  const config = useRuntimeConfig();
  const url = config.public.supabaseEndpoint as string | undefined;
  const anonKey = config.public.supabasePublishableKey as string | undefined;

  const supabase = url && anonKey
    ? createClient(url, anonKey, {
        auth: {
          autoRefreshToken: true,
          persistSession: true,
          detectSessionInUrl: true,
        },
      })
    : null;

  return { provide: { supabase } };
});