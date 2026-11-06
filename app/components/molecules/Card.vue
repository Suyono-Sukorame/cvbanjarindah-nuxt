<template>
  <div 
    class="bg-white rounded-2xl shadow-lg transition-all duration-300"
    :class="[paddingClasses, { 'hover:shadow-xl': hoverable }]"
  >
    <slot />
  </div>
</template>

<script setup lang="ts">
interface Props {
  padding?: 'none' | 'sm' | 'md' | 'lg';
  hoverable?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  padding: 'md',
  hoverable: true,
});

const paddingClasses = computed(() => {
  const paddings = {
    none: '',
    sm: 'p-4',
    md: 'p-6',
    lg: 'p-8',
  };
  return paddings[props.padding];
});
</script>
