<template>
  <section 
    class="text-white py-20"
    :class="bgClasses"
  >
    <div class="max-w-7xl mx-auto px-4 text-center">
      <h1 
        class="font-black mb-4"
        :class="titleSizeClasses"
      >
        <slot name="title">{{ title }}</slot>
      </h1>
      
      <p 
        class="mb-8"
        :class="subtitleSizeClasses"
      >
        <slot name="subtitle">{{ subtitle }}</slot>
      </p>
      
      <slot name="cta">
        <NuxtLink
          v-if="ctaText && ctaLink"
          :to="ctaLink"
          class="inline-block px-8 py-4 text-lg bg-white text-primary font-bold rounded-lg hover:scale-105 transition-transform shadow-xl"
        >
          {{ ctaText }}
        </NuxtLink>
      </slot>
    </div>
  </section>
</template>

<script setup lang="ts">
interface Props {
  title?: string;
  subtitle?: string;
  ctaText?: string;
  ctaLink?: string;
  variant?: 'gradient' | 'dark' | 'primary';
  size?: 'normal' | 'large';
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'gradient',
  size: 'large',
});

const bgClasses = computed(() => {
  const variants = {
    gradient: 'bg-gradient-to-br from-primary via-orange-500 to-red-600',
    light: 'bg-gradient-to-br from-slate-100 to-slate-200',
    primary: 'bg-primary',
  };
  return variants[props.variant];
});

const titleSizeClasses = computed(() => {
  return props.size === 'large' 
    ? 'text-4xl md:text-6xl' 
    : 'text-3xl md:text-5xl';
});

const subtitleSizeClasses = computed(() => {
  return props.size === 'large'
    ? 'text-lg md:text-2xl opacity-90'
    : 'text-base md:text-xl opacity-90 max-w-3xl mx-auto';
});
</script>
