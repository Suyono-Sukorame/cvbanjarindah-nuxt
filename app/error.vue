<template>
  <div class="min-h-screen flex items-center justify-center bg-slate-50">
    <div class="text-center px-4">
      <h1 class="text-6xl font-black text-primary mb-4">Oops!</h1>
      <h2 class="text-2xl font-bold mb-4 text-slate-900">Terjadi Kesalahan</h2>
      <p class="text-slate-600 mb-8 max-w-md">
        Maaf, terjadi kesalahan pada aplikasi kami. Silakan coba lagi atau hubungi tim support.
      </p>
      <div class="flex gap-4 justify-center">
        <NuxtLink 
          to="/"
          class="px-6 py-3 bg-primary text-white font-bold rounded-lg hover:opacity-90 transition"
        >
          Kembali ke Home
        </NuxtLink>
        <button 
          @click="handleError"
          class="px-6 py-3 bg-slate-200 text-slate-900 font-bold rounded-lg hover:opacity-90 transition"
        >
          Coba Lagi
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue';

defineProps({
  error: Object,
});

const handleError = () => {
  clearError({ redirect: '/' });
};
</script>
