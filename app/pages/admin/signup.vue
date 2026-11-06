<template>
  <main class="grid min-h-screen bg-slate-50 lg:grid-cols-[1fr_1fr]">
    <section class="hidden flex-col justify-between bg-slate-900 p-12 text-white lg:flex">
      <NuxtLink to="/" class="flex items-center gap-3 font-bold"><span class="material-symbols-outlined text-3xl text-orange-400">storefront</span>CV Banjar Indah</NuxtLink>
      <div class="max-w-lg"><p class="mb-3 text-sm font-semibold uppercase text-orange-300">Setup admin pertama</p><h1 class="text-4xl font-bold leading-tight">Buat akses super admin untuk mengelola dashboard.</h1></div>
      <p class="text-sm text-slate-400">Pendaftaran terkunci otomatis setelah super admin pertama aktif.</p>
    </section>
    <section class="flex items-center justify-center p-5 sm:p-10">
      <div class="w-full max-w-md space-y-6">
        <NuxtLink to="/" class="inline-flex items-center gap-2 text-sm font-semibold text-slate-600 lg:hidden"><span class="material-symbols-outlined text-primary">storefront</span>CV Banjar Indah</NuxtLink>
        <div>
          <p class="text-sm font-semibold text-primary">Bootstrap super admin</p>
          <h2 class="mt-1 text-3xl font-bold text-slate-900">{{ mode === 'signup' ? 'Daftar admin pertama' : 'Klaim akun Auth' }}</h2>
          <p class="mt-2 text-sm text-slate-500">{{ mode === 'signup' ? 'Buat akun baru. Hanya pendaftar pertama yang akan mendapat role super admin.' : 'Gunakan akun Auth yang sudah ada untuk mengklaim role super admin pertama.' }}</p>
        </div>

        <div v-if="loadingAvailability" class="flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-3 text-sm text-slate-600"><span class="material-symbols-outlined animate-spin text-lg">progress_activity</span>Memeriksa status pendaftaran...</div>
        <div v-else-if="!available" role="status" class="space-y-3 rounded-lg border border-amber-200 bg-amber-50 px-4 py-4 text-sm text-amber-900">
          <p>{{ availabilityError || 'Super admin sudah aktif. Pendaftaran super admin pertama telah ditutup.' }}</p>
          <NuxtLink to="/admin/login" class="inline-block font-bold text-primary hover:text-orange-700">Kembali ke login</NuxtLink>
        </div>

        <template v-else>
          <div v-if="successMessage" role="status" class="rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-800">{{ successMessage }}</div>
          <div v-if="errorMessage" role="alert" class="rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">{{ errorMessage }}</div>

          <form v-if="mode === 'signup'" class="space-y-4" @submit.prevent="signUp">
            <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Nama lengkap</span><input v-model.trim="fullName" type="text" autocomplete="name" required class="h-11 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"></label>
            <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Email</span><input v-model.trim="email" type="email" autocomplete="email" required class="h-11 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"></label>
            <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Kata sandi</span><span class="flex h-11 overflow-hidden rounded-lg border border-slate-300 bg-white focus-within:border-primary focus-within:ring-2 focus-within:ring-primary/20"><input v-model="password" :type="showPassword ? 'text' : 'password'" autocomplete="new-password" minlength="8" required class="min-w-0 flex-1 bg-transparent px-3 text-sm outline-none"><button type="button" class="grid w-11 shrink-0 place-items-center text-slate-500 hover:bg-slate-50" :aria-label="showPassword ? 'Sembunyikan kata sandi' : 'Lihat kata sandi'" @click="showPassword = !showPassword"><span class="material-symbols-outlined text-xl">{{ showPassword ? 'visibility_off' : 'visibility' }}</span></button></span><span class="block text-xs text-slate-500">Minimal 8 karakter.</span></label>
            <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Ulangi kata sandi</span><span class="flex h-11 overflow-hidden rounded-lg border bg-white focus-within:ring-2" :class="passwordMismatch ? 'border-red-400 focus-within:border-red-500 focus-within:ring-red-100' : 'border-slate-300 focus-within:border-primary focus-within:ring-primary/20'"><input v-model="confirmPassword" :type="showConfirmPassword ? 'text' : 'password'" autocomplete="new-password" minlength="8" required class="min-w-0 flex-1 bg-transparent px-3 text-sm outline-none"><button type="button" class="grid w-11 shrink-0 place-items-center text-slate-500 hover:bg-slate-50" :aria-label="showConfirmPassword ? 'Sembunyikan konfirmasi kata sandi' : 'Lihat konfirmasi kata sandi'" @click="showConfirmPassword = !showConfirmPassword"><span class="material-symbols-outlined text-xl">{{ showConfirmPassword ? 'visibility_off' : 'visibility' }}</span></button></span><span v-if="passwordMismatch" class="block text-xs font-medium text-red-600">Konfirmasi harus sama persis dengan kata sandi.</span></label>
            <button type="submit" :disabled="loading || passwordMismatch" class="flex h-11 w-full items-center justify-center gap-2 rounded-lg bg-primary px-4 text-sm font-bold text-white hover:bg-orange-600 disabled:opacity-60"><span v-if="loading" class="material-symbols-outlined animate-spin text-lg">progress_activity</span>{{ loading ? 'Mendaftarkan...' : 'Buat akun super admin' }}</button>
          </form>

          <form v-else class="space-y-4" @submit.prevent="claimExistingAccount">
            <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Email akun Auth</span><input v-model.trim="email" type="email" autocomplete="username" required class="h-11 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"></label>
            <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Kata sandi</span><input v-model="password" type="password" autocomplete="current-password" required class="h-11 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"></label>
            <button type="submit" :disabled="loading" class="flex h-11 w-full items-center justify-center gap-2 rounded-lg bg-primary px-4 text-sm font-bold text-white hover:bg-orange-600 disabled:opacity-60"><span v-if="loading" class="material-symbols-outlined animate-spin text-lg">progress_activity</span>{{ loading ? 'Memeriksa akun...' : 'Klaim super admin pertama' }}</button>
          </form>

          <button v-if="available" type="button" class="w-full text-center text-sm font-semibold text-primary hover:text-orange-700" @click="switchMode">
            {{ mode === 'signup' ? 'Sudah membuat akun Auth? Klaim akun tersebut' : 'Belum punya akun? Daftar di sini' }}
          </button>
        </template>

        <p class="text-center text-sm text-slate-600">Sudah punya akses admin? <NuxtLink to="/admin/login" class="font-bold text-primary hover:text-orange-700">Masuk</NuxtLink></p>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
definePageMeta({ layout: false });
useHead({ title: 'Daftar Super Admin | CV Banjar Indah' });

const { $supabase } = useNuxtApp();
const mode = ref<'signup' | 'claim'>('signup');
const fullName = ref('');
const email = ref('');
const password = ref('');
const confirmPassword = ref('');
const showPassword = ref(false);
const showConfirmPassword = ref(false);
const passwordMismatch = computed(() => Boolean(confirmPassword.value) && password.value !== confirmPassword.value);
const available = ref(false);
const loading = ref(false);
const loadingAvailability = ref(true);
const errorMessage = ref('');
const availabilityError = ref('');
const successMessage = ref('');

const checkAvailability = async () => {
  loadingAvailability.value = true;
  availabilityError.value = '';
  if (!$supabase) {
    availabilityError.value = 'Konfigurasi Supabase belum tersedia.';
    loadingAvailability.value = false;
    return;
  }
  const { data, error } = await $supabase.rpc('is_initial_super_admin_available');
  if (error) {
    availabilityError.value = 'Bootstrap belum disiapkan di database. Jalankan SQL setup admin terbaru dari folder supabase.';
    available.value = false;
  } else {
    available.value = data === true;
  }
  loadingAvailability.value = false;
};

const finishClaim = async () => {
  if (!$supabase) throw new Error('Konfigurasi Supabase belum tersedia.');
  const { data, error } = await $supabase.rpc('claim_initial_super_admin');
  if (error) throw error;
  if (!data) {
    await $supabase.auth.signOut();
    available.value = false;
    throw new Error('Super admin pertama sudah dibuat oleh akun lain. Pendaftaran telah ditutup.');
  }
  await navigateTo('/admin');
};

const signUp = async () => {
  errorMessage.value = '';
  successMessage.value = '';
  if (password.value !== confirmPassword.value) {
    errorMessage.value = 'Konfirmasi kata sandi tidak cocok.';
    return;
  }
  if (!$supabase) {
    errorMessage.value = 'Konfigurasi Supabase belum tersedia.';
    return;
  }

  loading.value = true;
  try {
    const { data, error } = await $supabase.auth.signUp({
      email: email.value,
      password: password.value,
      options: { data: { full_name: fullName.value } },
    });
    if (error) throw error;
    if (data.session) {
      await finishClaim();
    } else {
      mode.value = 'claim';
      successMessage.value = 'Akun dibuat. Verifikasi email Anda, lalu gunakan form klaim dengan email dan kata sandi yang sama untuk mengaktifkan super admin.';
    }
  } catch (error) {
    errorMessage.value = error instanceof Error ? error.message : 'Pendaftaran gagal. Periksa konfigurasi Supabase Auth.';
  } finally {
    loading.value = false;
  }
};

const claimExistingAccount = async () => {
  errorMessage.value = '';
  successMessage.value = '';
  if (!$supabase) {
    errorMessage.value = 'Konfigurasi Supabase belum tersedia.';
    return;
  }

  loading.value = true;
  try {
    const { error } = await $supabase.auth.signInWithPassword({ email: email.value, password: password.value });
    if (error) throw error;
    await finishClaim();
  } catch (error) {
    errorMessage.value = error instanceof Error ? error.message : 'Tidak dapat mengklaim akun ini.';
  } finally {
    loading.value = false;
  }
};

const switchMode = () => {
  errorMessage.value = '';
  successMessage.value = '';
  mode.value = mode.value === 'signup' ? 'claim' : 'signup';
};

onMounted(() => { void checkAvailability(); });
</script>