<template>
  <div class="min-h-screen bg-slate-50 text-slate-900">
    <OrganismsAdminSidebar :open="sidebarOpen" @close="sidebarOpen = false" />
    <div class="min-h-screen lg:pl-64">
      <header class="sticky top-0 z-20 flex h-16 items-center justify-between border-b border-slate-200 bg-white/95 px-4 backdrop-blur sm:px-6">
        <div class="flex items-center gap-3">
          <button class="grid h-10 w-10 place-items-center rounded-lg text-slate-600 hover:bg-slate-100 lg:hidden" aria-label="Buka menu" @click="sidebarOpen = true"><span class="material-symbols-outlined">menu</span></button>
          <div>
            <p class="text-xs font-medium text-slate-500">Administrasi</p>
            <h1 class="text-sm font-bold sm:text-base">{{ pageTitle }}</h1>
          </div>
        </div>
        <div class="flex items-center gap-3">
          <span class="hidden max-w-48 truncate text-sm text-slate-600 sm:block">{{ user?.email }}</span>
          <button class="inline-flex items-center gap-2 rounded-lg border border-slate-200 px-3 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50" :disabled="loading" @click="logout">
            <span class="material-symbols-outlined text-lg">logout</span><span class="hidden sm:inline">Keluar</span>
          </button>
        </div>
      </header>
      <main class="mx-auto w-full max-w-7xl p-4 sm:p-6 lg:p-8"><slot /></main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { adminNavigation } from '~/utils/adminResources';

const sidebarOpen = ref(false);
const route = useRoute();
const { user, loading, logout } = useAuth();
const pageTitle = computed(() => {
  const nav = adminNavigation.find(item => item.to === route.path || (item.to !== '/admin' && route.path.startsWith(item.to)));
  return nav?.label ?? 'Ringkasan';
});
</script>