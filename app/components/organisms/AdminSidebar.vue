<template>
  <div>
    <button v-if="open" class="fixed inset-0 z-30 bg-slate-950/40 lg:hidden" aria-label="Tutup menu" @click="close" />
    <aside :class="['fixed inset-y-0 left-0 z-40 flex w-64 flex-col border-r border-slate-200 bg-white transition-transform lg:translate-x-0', open ? 'translate-x-0' : '-translate-x-full']">
      <NuxtLink to="/admin" class="flex h-16 items-center gap-3 border-b border-slate-100 px-5" @click="close">
        <span class="grid h-9 w-9 place-items-center rounded-lg bg-primary text-white"><span class="material-symbols-outlined">storefront</span></span>
        <span class="text-sm font-bold text-slate-900">CV Banjar Indah <span class="block text-xs font-medium text-slate-500">Panel admin</span></span>
      </NuxtLink>
      <nav class="flex-1 space-y-1 overflow-y-auto p-3" aria-label="Navigasi admin">
        <NuxtLink v-for="item in adminNavigation" :key="item.to" :to="item.to" :class="['flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors', isActive(item.to) ? 'bg-orange-50 text-primary' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900']" @click="close">
          <span class="material-symbols-outlined text-xl">{{ item.icon }}</span>{{ item.label }}
        </NuxtLink>
      </nav>
      <div class="border-t border-slate-100 p-4 text-xs text-slate-500">CV Banjar Indah · Admin</div>
    </aside>
  </div>
</template>

<script setup lang="ts">
import { adminNavigation } from '~/utils/adminResources';

defineProps<{ open: boolean }>();
const emit = defineEmits<{ close: [] }>();
const route = useRoute();
const close = () => emit('close');
const isActive = (to: string) => to === '/admin' ? route.path === to : route.path.startsWith(to);
</script>