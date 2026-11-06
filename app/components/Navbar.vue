<template>
  <nav class="bg-white border-b border-slate-200 sticky top-0 z-40 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
      <!-- Logo -->
      <div class="flex items-center gap-2">
        <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center text-white font-bold text-lg">
          BI
        </div>
        <div>
          <h1 class="font-black text-lg text-slate-900">CV Banjar Indah</h1>
          <p class="text-[10px] text-slate-500">Kalimantan</p>
        </div>
      </div>

      <!-- Desktop Menu -->
      <div class="hidden md:flex items-center gap-8">
        <NuxtLink 
          to="/" 
          class="font-semibold text-slate-700 hover:text-primary transition"
          :class="{ 'text-primary': $route.path === '/' }"
        >
          Home
        </NuxtLink>
        <NuxtLink 
          to="/produk" 
          class="font-semibold text-slate-700 hover:text-primary transition"
          :class="{ 'text-primary': $route.path === '/produk' }"
        >
          Produk
        </NuxtLink>
        <NuxtLink 
          to="/area" 
          class="font-semibold text-slate-700 hover:text-primary transition"
          :class="{ 'text-primary': $route.path === '/area' }"
        >
          Area
        </NuxtLink>
        <NuxtLink 
          to="/tentang" 
          class="font-semibold text-slate-700 hover:text-primary transition"
          :class="{ 'text-primary': $route.path === '/tentang' }"
        >
          Tentang
        </NuxtLink>
        
        <NuxtLink 
          to="/kontak" 
          class="px-6 py-2 bg-primary text-white rounded-lg font-semibold hover:bg-opacity-90 transition"
        >
          Kontak
        </NuxtLink>
      </div>

      <!-- Mobile: No dark mode toggle needed -->
      <div class="md:hidden">
        <!-- Placeholder for future mobile actions if needed -->
      </div>
    </div>
  </nav>
</template>

<script setup lang="ts">
// Navbar without dark mode
</script>
