<template>
  <section class="space-y-6">
    <div><p class="text-sm text-slate-500">Ikhtisar website</p><h2 class="mt-1 text-2xl font-bold text-slate-900">Ringkasan</h2></div>
    <div v-if="errorMessage" role="alert" class="rounded-lg border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-900">{{ errorMessage }}</div>
    <div class="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
      <article v-for="stat in stats" :key="stat.key" class="rounded-lg border border-slate-200 bg-white p-5">
        <div class="flex items-center justify-between"><span class="text-sm font-medium text-slate-500">{{ stat.label }}</span><span class="material-symbols-outlined text-xl text-primary">{{ stat.icon }}</span></div>
        <p class="mt-4 text-3xl font-bold text-slate-900">{{ loading ? '–' : counts[stat.key] }}</p>
      </article>
    </div>
    <section class="overflow-hidden rounded-lg border border-slate-200 bg-white">
      <div class="flex items-center justify-between border-b border-slate-200 px-5 py-4"><div><h3 class="font-bold text-slate-900">Pesan terbaru</h3><p class="mt-1 text-sm text-slate-500">Permintaan dari calon pelanggan</p></div><NuxtLink to="/admin/inquiries" class="text-sm font-semibold text-primary hover:text-orange-700">Lihat semua</NuxtLink></div>
      <div v-if="loading" class="px-5 py-10 text-center text-sm text-slate-500">Memuat ringkasan...</div>
      <div v-else-if="!recentInquiries.length" class="px-5 py-10 text-center text-sm text-slate-500">Belum ada pesan masuk.</div>
      <div v-else class="divide-y divide-slate-100">
        <NuxtLink v-for="inquiry in recentInquiries" :key="inquiry.id" to="/admin/inquiries" class="flex flex-col gap-2 px-5 py-4 hover:bg-slate-50 sm:flex-row sm:items-center sm:justify-between">
          <div class="min-w-0"><p class="truncate text-sm font-semibold text-slate-800">{{ inquiry.name }} <span v-if="inquiry.company" class="font-normal text-slate-500">· {{ inquiry.company }}</span></p><p class="mt-1 truncate text-sm text-slate-500">{{ inquiry.message }}</p></div>
          <div class="flex shrink-0 items-center gap-3"><span class="rounded-full bg-orange-50 px-2.5 py-1 text-xs font-semibold text-orange-700">{{ inquiry.status }}</span><time class="text-xs text-slate-400">{{ formatDate(inquiry.created_at) }}</time></div>
        </NuxtLink>
      </div>
    </section>
  </section>
</template>

<script setup lang="ts">
definePageMeta({ layout: 'admin', middleware: 'auth' });
useHead({ title: 'Ringkasan Admin | CV Banjar Indah' });

const { $supabase } = useNuxtApp();
const loading = ref(true);
const errorMessage = ref('');
const counts = reactive<Record<string, number>>({ products: 0, inquiries: 0, categories: 0, brands: 0 });
const recentInquiries = ref<Array<Record<string, any>>>([]);
const stats = [
  { key: 'products', label: 'Total produk', icon: 'inventory_2' },
  { key: 'inquiries', label: 'Pesan masuk', icon: 'mail' },
  { key: 'categories', label: 'Kategori', icon: 'category' },
  { key: 'brands', label: 'Brand', icon: 'business' },
];
const formatDate = (value?: string) => value ? new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium' }).format(new Date(value)) : '-';

onMounted(async () => {
  if (!$supabase) {
    errorMessage.value = 'Konfigurasi Supabase belum terbaca. Pastikan .env berada di root proyek, lalu restart server Nuxt.';
    loading.value = false;
    return;
  }
  const results = await Promise.all(['products', 'inquiries', 'categories', 'brands'].map(table => $supabase.from(table).select('*', { count: 'exact', head: true })));
  const failed = results.find(result => result.error);
  if (failed?.error) errorMessage.value = failed.error.message;
  results.forEach((result, index) => { counts[['products', 'inquiries', 'categories', 'brands'][index]] = result.count ?? 0; });
  const { data, error } = await $supabase.from('inquiries').select('id,name,company,message,status,created_at').order('created_at', { ascending: false }).limit(5);
  if (error && !errorMessage.value) errorMessage.value = error.message;
  recentInquiries.value = data ?? [];
  loading.value = false;
});
</script>