<template>
  <div 
    class="flex items-center justify-center rounded-full overflow-hidden shrink-0"
    :class="sizeClasses"
  >
    <img 
      v-if="src" 
      :src="src" 
      :alt="alt"
      class="w-full h-full object-cover"
    />
    <div 
      v-else
      class="w-full h-full flex items-center justify-center font-bold"
      :class="[bgColor, textColor]"
    >
      {{ initials }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  src?: string;
  alt?: string;
  initials?: string;
  size?: 'xs' | 'sm' | 'md' | 'lg';
  bgColor?: string;
  textColor?: string;
}

const props = withDefaults(defineProps<Props>(), {
  src: '',
  alt: 'Avatar',
  initials: 'AI',
  size: 'md',
  bgColor: 'bg-primary',
  textColor: 'text-white',
});

const sizeClasses = computed(() => {
  const sizes = {
    xs: 'w-6 h-6 text-xs',
    sm: 'w-8 h-8 text-sm',
    md: 'w-10 h-10 text-base',
    lg: 'w-12 h-12 text-lg',
  };
  return sizes[props.size];
});
</script>
