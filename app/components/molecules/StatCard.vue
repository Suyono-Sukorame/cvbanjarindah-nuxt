<template>
  <Card class="text-center">
    <div class="text-4xl font-black text-primary mb-2">
      {{ stat.value }}{{ stat.suffix }}
    </div>
    <div class="text-slate-600 text-sm">
      {{ stat.label }}
    </div>
  </Card>
</template>

<script setup lang="ts">
import type { Stat } from '~/types/common';

interface Props {
  stat: Stat;
}

defineProps<Props>();
</script>
