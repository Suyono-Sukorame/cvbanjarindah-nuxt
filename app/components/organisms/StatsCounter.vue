<template>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
    <AtomsCounter
      v-for="stat in stats"
      :key="stat.id"
      :value="stat.value"
      :label="stat.label"
      :suffix="stat.suffix"
      :size="size"
    />
  </div>
</template>

<script setup lang="ts">
import type { Stat } from '~/types/common';

interface Props {
  stats: Stat[];
  size?: 'sm' | 'md' | 'lg';
}

withDefaults(defineProps<Props>(), {
  size: 'md',
});
</script>
