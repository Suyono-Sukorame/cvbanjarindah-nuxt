<template>
  <div 
    class="bg-white rounded-xl p-6 flex items-center justify-center hover:shadow-lg transition-all duration-300 group border border-slate-100"
  >
    <img 
      :src="logo" 
      :alt="name"
      class="max-h-16 w-auto grayscale group-hover:grayscale-0 transition-all duration-300 opacity-60 group-hover:opacity-100"
    />
  </div>
</template>

<script setup lang="ts">
interface Props {
  name: string;
  logo: string;
}

defineProps<Props>();
</script>
