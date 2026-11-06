<template>
  <nav class="fixed bottom-0 left-0 right-0 md:hidden bg-white border-t border-slate-200 z-40">
    <div class="flex justify-around items-center">
      <NuxtLink 
        to="/" 
        class="flex-1 py-3 flex flex-col items-center gap-1 text-xs font-semibold transition"
        :class="[
          $route.path === '/' 
            ? 'text-primary' 
            : 'text-slate-600'
        ]"
      >
        <span class="material-symbols-outlined text-xl">home</span>
        <span>Home</span>
      </NuxtLink>

      <NuxtLink 
        to="/produk" 
        class="flex-1 py-3 flex flex-col items-center gap-1 text-xs font-semibold transition"
        :class="[
          $route.path === '/produk' 
            ? 'text-primary' 
            : 'text-slate-600'
        ]"
      >
        <span class="material-symbols-outlined text-xl">shopping_bag</span>
        <span>Produk</span>
      </NuxtLink>

      <NuxtLink 
        to="/area" 
        class="flex-1 py-3 flex flex-col items-center gap-1 text-xs font-semibold transition"
        :class="[
          $route.path === '/area' 
            ? 'text-primary' 
            : 'text-slate-600'
        ]"
      >
        <span class="material-symbols-outlined text-xl">location_on</span>
        <span>Area</span>
      </NuxtLink>

      <NuxtLink 
        to="/tentang" 
        class="flex-1 py-3 flex flex-col items-center gap-1 text-xs font-semibold transition"
        :class="[
          $route.path === '/tentang' 
            ? 'text-primary' 
            : 'text-slate-600'
        ]"
      >
        <span class="material-symbols-outlined text-xl">info</span>
        <span>Tentang</span>
      </NuxtLink>

      <NuxtLink 
        to="/kontak" 
        class="flex-1 py-3 flex flex-col items-center gap-1 text-xs font-semibold transition"
        :class="[
          $route.path === '/kontak' 
            ? 'text-primary' 
            : 'text-slate-600'
        ]"
      >
        <span class="material-symbols-outlined text-xl">mail</span>
        <span>Kontak</span>
      </NuxtLink>
    </div>
  </nav>
</template>

<script setup lang="ts">
// BottomNav logic
</script>
