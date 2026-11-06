<template>
  <main class="grid min-h-screen bg-slate-50 lg:grid-cols-[1fr_1fr]">
    <section class="hidden flex-col justify-between bg-slate-900 p-12 text-white lg:flex">
      <NuxtLink to="/" class="flex items-center gap-3 font-bold"><span class="material-symbols-outlined text-3xl text-orange-400">storefront</span>CV Banjar Indah</NuxtLink>
      <div class="max-w-lg"><p class="mb-3 text-sm font-semibold uppercase text-orange-300">Portal administrasi</p><h1 class="text-4xl font-bold leading-tight">Kelola operasional dan konten bisnis Anda.</h1></div>
      <p class="text-sm text-slate-400">Akses terbatas untuk pengguna admin.</p>
    </section>
    <section class="flex items-center justify-center p-5 sm:p-10">
      <form class="w-full max-w-md space-y-6" @submit.prevent="submit">
        <NuxtLink to="/" class="inline-flex items-center gap-2 text-sm font-semibold text-slate-600 lg:hidden"><span class="material-symbols-outlined text-primary">storefront</span>CV Banjar Indah</NuxtLink>
        <div><p class="text-sm font-semibold text-primary">Selamat datang</p><h2 class="mt-1 text-3xl font-bold text-slate-900">Masuk ke admin</h2><p class="mt-2 text-sm text-slate-500">Gunakan akun admin Supabase Anda.</p></div>
        <div v-if="errorMessage" role="alert" class="rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">{{ errorMessage }}</div>
        <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Email</span><input v-model.trim="email" type="email" autocomplete="username" required class="h-11 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"></label>
          <label class="block space-y-2"><span class="text-sm font-semibold text-slate-700">Kata sandi</span><input v-model="password" type="password" autocomplete="current-password" required class="h-11 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"></label>
        <button type="submit" :disabled="loading" class="flex h-11 w-full items-center justify-center gap-2 rounded-lg bg-primary px-4 text-sm font-bold text-white hover:bg-orange-600 disabled:opacity-60"><span v-if="loading" class="material-symbols-outlined animate-spin text-lg">progress_activity</span>{{ loading ? 'Memeriksa...' : 'Masuk' }}</button>
        <p class="text-center text-sm text-slate-600">Super admin pertama? <NuxtLink to="/admin/signup" class="font-bold text-primary hover:text-orange-700">Daftar atau klaim akun</NuxtLink></p>
      </form>
    </section>
  </main>
</template>

<script setup lang="ts">
definePageMeta({ layout: false });
useHead({ title: 'Masuk Admin | CV Banjar Indah' });

const route = useRoute();
const { login, loading } = useAuth();
const email = ref('');
const password = ref('');
const errorMessage = ref('');

const submit = async () => {
  errorMessage.value = '';
  try {
    await login(email.value, password.value);
    const destination = typeof route.query.redirect === 'string' && route.query.redirect.startsWith('/admin')
      ? route.query.redirect
      : '/admin';
    await navigateTo(destination);
  } catch (error) {
    errorMessage.value = error instanceof Error ? error.message : 'Tidak dapat masuk. Periksa koneksi Supabase dan akun Anda.';
  }
};

</script>