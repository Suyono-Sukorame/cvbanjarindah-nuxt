<template>
  <span
    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold"
    :class="colorClasses"
  >
    <slot />
  </span>
</template>

<script setup lang="ts">
interface Props {
  color?: 'primary' | 'blue' | 'green' | 'red' | 'yellow' | 'purple';
}

const props = withDefaults(defineProps<Props>(), {
  color: 'primary',
});

const colorClasses = computed(() => {
  const colors = {
    primary: 'bg-primary/10 text-primary',
    blue: 'bg-blue-100 text-blue-600',
    green: 'bg-green-100 text-green-600',
    red: 'bg-red-100 text-red-600',
    yellow: 'bg-yellow-100 text-yellow-600',
    purple: 'bg-purple-100 text-purple-600',
  };
  return colors[props.color];
});
</script>
