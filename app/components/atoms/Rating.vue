<template>
  <div class="flex gap-1">
    <span 
      v-for="i in 5" 
      :key="i"
      class="material-symbols-outlined"
      :class="i <= rating ? 'text-yellow-400' : 'text-slate-300'"
    >
      {{ i <= rating ? 'star' : 'star_outline' }}
    </span>
  </div>
</template>

<script setup lang="ts">
interface Props {
  rating: number;
}

defineProps<Props>();
</script>
