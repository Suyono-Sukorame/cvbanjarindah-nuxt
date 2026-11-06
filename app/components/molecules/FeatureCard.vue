<template>
  <div class="text-center">
    <div class="text-4xl mb-4">{{ feature.icon }}</div>
    <h3 class="font-bold mb-2 text-slate-900">
      {{ feature.title }}
    </h3>
    <p class="text-slate-600">
      {{ feature.description }}
    </p>
  </div>
</template>

<script setup lang="ts">
import type { Feature } from '~/types/common';

interface Props {
  feature: Feature;
}

defineProps<Props>();
</script>
