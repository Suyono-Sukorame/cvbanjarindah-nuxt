<template>
  <div 
    class="relative overflow-hidden"
    :class="[roundedClasses, aspectClasses]"
  >
    <img
      :src="src"
      :alt="alt"
      :loading="lazy ? 'lazy' : 'eager'"
      class="w-full h-full object-cover transition-transform duration-300"
      :class="{ 'group-hover:scale-105': hover }"
    />
    <div 
      v-if="overlay"
      class="absolute inset-0"
      :class="overlayClasses"
    />
  </div>
</template>

<script setup lang="ts">
interface Props {
  src: string;
  alt: string;
  rounded?: 'none' | 'sm' | 'md' | 'lg' | 'xl' | 'full';
  aspect?: 'square' | 'video' | 'portrait' | 'auto';
  overlay?: boolean;
  overlayColor?: string;
  hover?: boolean;
  lazy?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  rounded: 'lg',
  aspect: 'auto',
  overlay: false,
  overlayColor: 'bg-slate-900/30',
  hover: true,
  lazy: true,
});

const roundedClasses = computed(() => {
  const rounded = {
    none: '',
    sm: 'rounded',
    md: 'rounded-lg',
    lg: 'rounded-xl',
    xl: 'rounded-2xl',
    full: 'rounded-full',
  };
  return rounded[props.rounded];
});

const aspectClasses = computed(() => {
  const aspects = {
    square: 'aspect-square',
    video: 'aspect-video',
    portrait: 'aspect-[3/4]',
    auto: '',
  };
  return aspects[props.aspect];
});

const overlayClasses = computed(() => {
  return props.overlay ? props.overlayColor : '';
});
</script>
