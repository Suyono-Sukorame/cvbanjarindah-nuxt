<template>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
    <MoleculesStatCard
      v-for="stat in stats"
      :key="stat.id"
      :stat="stat"
    />
  </div>
</template>

<script setup lang="ts">
import type { Stat } from '~/types/common';

interface Props {
  stats: Stat[];
}

defineProps<Props>();
</script>
