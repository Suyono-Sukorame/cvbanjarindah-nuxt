<template>
  <div class="text-center">
    <div 
      class="font-black text-primary mb-2"
      :class="sizeClasses"
    >
      {{ displayValue }}{{ suffix }}
    </div>
    <div 
      class="text-slate-600 font-semibold"
      :class="labelSizeClasses"
    >
      {{ label }}
    </div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  value: string | number;
  label: string;
  suffix?: string;
  size?: 'sm' | 'md' | 'lg';
  animated?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  suffix: '',
  size: 'md',
  animated: true,
});

const displayValue = ref(0);

const sizeClasses = computed(() => {
  const sizes = {
    sm: 'text-3xl',
    md: 'text-4xl md:text-5xl',
    lg: 'text-5xl md:text-6xl',
  };
  return sizes[props.size];
});

const labelSizeClasses = computed(() => {
  const sizes = {
    sm: 'text-xs',
    md: 'text-sm md:text-base',
    lg: 'text-base md:text-lg',
  };
  return sizes[props.size];
});

onMounted(() => {
  if (props.animated) {
    const target = typeof props.value === 'string' ? parseInt(props.value) : props.value;
    const duration = 2000;
    const steps = 60;
    const increment = target / steps;
    let current = 0;
    
    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        displayValue.value = target;
        clearInterval(timer);
      } else {
        displayValue.value = Math.floor(current);
      }
    }, duration / steps);
  } else {
    displayValue.value = typeof props.value === 'string' ? parseInt(props.value) : props.value;
  }
});
</script>
