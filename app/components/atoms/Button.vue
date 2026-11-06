<template>
  <component
    :is="tag"
    :to="to"
    :type="type"
    :disabled="disabled"
    class="inline-flex items-center justify-center font-bold rounded-lg transition-all duration-200"
    :class="[variantClasses, sizeClasses, { 'opacity-50 cursor-not-allowed': disabled }]"
  >
    <span v-if="loading" class="material-symbols-outlined animate-spin mr-2">progress_activity</span>
    <slot />
  </component>
</template>

<script setup lang="ts">
import type { ButtonVariant, ButtonSize } from '~/types/common';

interface Props {
  variant?: ButtonVariant;
  size?: ButtonSize;
  to?: string;
  type?: 'button' | 'submit' | 'reset';
  disabled?: boolean;
  loading?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  size: 'md',
  type: 'button',
  disabled: false,
  loading: false,
});

const tag = computed(() => (props.to ? resolveComponent('NuxtLink') : 'button'));

const variantClasses = computed(() => {
  const variants = {
    primary: 'bg-primary text-white hover:bg-opacity-90 shadow-lg hover:shadow-xl',
    secondary: 'bg-slate-900 text-white hover:bg-slate-800',
    outline: 'border-2 border-primary text-primary hover:bg-primary hover:text-white',
    ghost: 'text-slate-700 hover:bg-slate-100',
  };
  return variants[props.variant];
});

const sizeClasses = computed(() => {
  const sizes = {
    sm: 'px-4 py-2 text-sm',
    md: 'px-6 py-3 text-base',
    lg: 'px-8 py-4 text-lg',
  };
  return sizes[props.size];
});
</script>
