import type { User } from '@supabase/supabase-js';

export const useAuth = () => {
  const { $supabase } = useNuxtApp();
  const user = useState<User | null>('admin-user', () => null);
  const loading = useState('admin-auth-loading', () => false);

  const checkAuth = async () => {
    if (!$supabase) return null;

    const { data, error } = await $supabase.auth.getSession();
    if (error) throw error;
    if (!data.session?.user) {
      user.value = null;
      return null;
    }

    const { data: adminProfile, error: profileError } = await $supabase
      .from('admin_users')
      .select('id')
      .eq('id', data.session.user.id)
      .eq('is_active', true)
      .maybeSingle();
    if (profileError) throw profileError;

    user.value = adminProfile ? data.session.user : null;
    return user.value;
  };

  const login = async (email: string, password: string) => {
    if (!$supabase) throw new Error('Konfigurasi Supabase belum tersedia.');

    loading.value = true;
    try {
      const { data, error } = await $supabase.auth.signInWithPassword({ email, password });
      if (error) throw error;
      const adminUser = await checkAuth();
      if (!adminUser) {
        await $supabase.auth.signOut();
        throw new Error('Akun ini belum terdaftar sebagai admin aktif.');
      }
      return adminUser;
    } finally {
      loading.value = false;
    }
  };

  const logout = async () => {
    if (!$supabase) return;

    loading.value = true;
    try {
      const { error } = await $supabase.auth.signOut();
      if (error) throw error;
      user.value = null;
      await navigateTo('/admin/login');
    } finally {
      loading.value = false;
    }
  };

  return { user, loading, login, logout, checkAuth };
};