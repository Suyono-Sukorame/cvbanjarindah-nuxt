<template>
  <Card padding="none" class="group overflow-hidden">
    <div 
      class="relative h-48 overflow-hidden"
      :class="gradientClasses"
    >
      <AtomsImage
        :src="image"
        :alt="category.name"
        :hover="true"
        overlay
        :overlayColor="overlayColor"
      />
    </div>
    
    <div class="p-6">
      <h3 class="font-black text-xl mb-2 text-slate-900">
        {{ category.name }}
      </h3>
      <p class="text-slate-600 mb-4">
        {{ category.description }}
      </p>
      <NuxtLink 
        to="/produk" 
        class="text-primary font-bold hover:underline inline-flex items-center gap-1"
      >
        Lihat Produk
        <AtomsIcon name="arrow_forward" type="material" size="sm" />
      </NuxtLink>
    </div>
  </Card>
</template>

<script setup lang="ts">
import type { ProductCategory } from '~/types/product';

interface Props {
  category: ProductCategory;
  image: string;
}

const props = defineProps<Props>();

const gradientClasses = computed(() => {
  const gradients: Record<string, string> = {
    'blue': 'bg-gradient-to-br from-blue-400 to-blue-600',
    'red': 'bg-gradient-to-br from-red-400 to-red-600',
    'pink': 'bg-gradient-to-br from-pink-400 to-pink-600',
  };
  return gradients[props.category.color || 'blue'];
});

const overlayColor = computed(() => {
  const overlays: Record<string, string> = {
    'blue': 'bg-blue-600/30',
    'red': 'bg-red-600/30',
    'pink': 'bg-pink-600/30',
  };
  return overlays[props.category.color || 'blue'];
});
</script>
