<template>
  <div 
    class="px-4 py-2.5 rounded-2xl max-w-[85%] break-words"
    :class="[variantClasses, roundingClasses]"
  >
    <slot />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  variant?: 'user' | 'ai';
  position?: 'start' | 'end';
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'ai',
  position: 'start',
});

const variantClasses = computed(() => {
  const variants = {
    user: 'bg-primary text-white',
    ai: 'bg-white border border-slate-200 text-slate-900 shadow-sm',
  };
  return variants[props.variant];
});

const roundingClasses = computed(() => {
  if (props.variant === 'user') {
    return props.position === 'end' ? 'rounded-tr-sm' : 'rounded-tr-2xl';
  }
  return props.position === 'start' ? 'rounded-tl-sm' : 'rounded-tl-2xl';
});
</script>
