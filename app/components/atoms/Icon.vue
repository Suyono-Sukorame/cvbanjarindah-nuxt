<template>
  <span 
    v-if="type === 'material'"
    class="material-symbols-outlined"
    :class="sizeClasses"
  >
    {{ name }}
  </span>
  <span 
    v-else
    :class="sizeClasses"
  >
    {{ name }}
  </span>
</template>

<script setup lang="ts">
interface Props {
  name: string;
  type?: 'material' | 'emoji';
  size?: 'sm' | 'md' | 'lg' | 'xl';
}

const props = withDefaults(defineProps<Props>(), {
  type: 'material',
  size: 'md',
});

const sizeClasses = computed(() => {
  const sizes = {
    sm: 'text-xl',
    md: 'text-2xl',
    lg: 'text-4xl',
    xl: 'text-6xl',
  };
  return sizes[props.size];
});
</script>
