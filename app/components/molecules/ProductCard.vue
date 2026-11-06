<template>
  <Card padding="none" class="group overflow-hidden">
    <AtomsImage
      :src="product.image"
      :alt="product.name"
      :hover="true"
      class="h-48"
    />
    
    <div class="p-6">
      <AtomsBadge :color="categoryColor" class="mb-3">
        {{ product.category }}
      </AtomsBadge>
      
      <h3 class="font-bold text-lg mb-2 text-slate-900">
        {{ product.name }}
      </h3>
      
      <p class="text-slate-600 text-sm mb-4">
        {{ product.description }}
      </p>
      
      <AtomsButton
        to="/kontak"
        variant="primary"
        size="sm"
        class="w-full"
      >
        Tanya Harga
      </AtomsButton>
    </div>
  </Card>
</template>

<script setup lang="ts">
import type { Product } from '~/types/product';

interface Props {
  product: Product;
}

const props = defineProps<Props>();

const categoryColor = computed(() => {
  const colors: Record<string, any> = {
    'Tissue': 'blue',
    'Masker': 'red',
    'Bayi': 'purple',
  };
  return colors[props.product.category] || 'primary';
});
</script>
