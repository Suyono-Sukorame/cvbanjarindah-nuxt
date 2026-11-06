<template>
  <div>
    <!-- Filters -->
    <div class="flex gap-4 mb-8 overflow-x-auto pb-2">
      <button
        v-for="category in categories"
        :key="category"
        @click="emit('update:selectedCategory', category)"
        class="px-6 py-2 rounded-full font-bold whitespace-nowrap transition"
        :class="
          selectedCategory === category
            ? 'bg-primary text-white'
            : 'bg-slate-200 text-slate-900 hover:bg-slate-300'
        "
      >
        {{ category }}
      </button>
    </div>

    <!-- Products Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <MoleculesProductCard
        v-for="product in products"
        :key="product.id"
        :product="product"
      />
    </div>

    <!-- Empty State -->
    <div v-if="products.length === 0" class="text-center py-16">
      <AtomsIcon name="inbox" type="material" size="xl" class="text-slate-400 mb-4" />
      <p class="text-slate-600 mb-4">
        Tidak ada produk di kategori ini
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { Product } from '~/types/product';

interface Props {
  products: Product[];
  categories: string[];
  selectedCategory: string;
}

interface Emits {
  (e: 'update:selectedCategory', value: string): void;
}

defineProps<Props>();
const emit = defineEmits<Emits>();
</script>
