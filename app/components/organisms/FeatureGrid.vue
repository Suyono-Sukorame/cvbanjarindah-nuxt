<template>
  <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
    <MoleculesFeatureCard
      v-for="feature in features"
      :key="feature.id"
      :feature="feature"
    />
  </div>
</template>

<script setup lang="ts">
import type { Feature } from '~/types/common';

interface Props {
  features: Feature[];
}

defineProps<Props>();
</script>
