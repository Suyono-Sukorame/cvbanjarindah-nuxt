<template>
  <div 
    class="mb-12"
    :class="alignmentClasses"
  >
    <h2 
      class="text-3xl font-black text-slate-900"
      :class="[sizeClasses, alignmentClasses]"
    >
      <slot>{{ title }}</slot>
    </h2>
    <p 
      v-if="subtitle || $slots.subtitle"
      class="text-slate-600 mt-2"
      :class="alignmentClasses"
    >
      <slot name="subtitle">{{ subtitle }}</slot>
    </p>
  </div>
</template>

<script setup lang="ts">
interface Props {
  title?: string;
  subtitle?: string;
  align?: 'left' | 'center' | 'right';
  size?: 'sm' | 'md' | 'lg';
}

const props = withDefaults(defineProps<Props>(), {
  align: 'center',
  size: 'md',
});

const alignmentClasses = computed(() => {
  const aligns = {
    left: 'text-left',
    center: 'text-center',
    right: 'text-right',
  };
  return aligns[props.align];
});

const sizeClasses = computed(() => {
  const sizes = {
    sm: 'text-2xl',
    md: 'text-3xl',
    lg: 'text-4xl',
  };
  return sizes[props.size];
});
</script>
