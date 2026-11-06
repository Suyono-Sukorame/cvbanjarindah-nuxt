<template>
  <div class="max-w-7xl mx-auto px-4 py-16">
    <SectionsSectionHeading 
      title="Produk Kami"
      subtitle="Jelajahi koleksi lengkap produk berkualitas dari CV Banjar Indah"
    />

    <OrganismsProductGrid
      :products="filteredProducts"
      :categories="categories"
      v-model:selected-category="selectedCategory"
    />
  </div>
</template>

<script setup lang="ts">
import { products } from '~/data/products';

definePageMeta({
  layout: 'default',
});

const selectedCategory = ref('Semua');
const categories = ['Semua', 'Tissue', 'Masker', 'Bayi'];

const filteredProducts = computed(() => {
  if (selectedCategory.value === 'Semua') return products;
  return products.filter((p) => p.category === selectedCategory.value);
});
</script>
