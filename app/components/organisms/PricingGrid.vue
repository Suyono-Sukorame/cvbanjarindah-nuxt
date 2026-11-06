<template>
  <div class="grid grid-cols-1 md:grid-cols-3 gap-8 items-start">
    <MoleculesPricingCard
      v-for="pkg in packages"
      :key="pkg.id"
      :name="pkg.name"
      :description="pkg.description"
      :icon="pkg.icon"
      :features="pkg.features"
      :highlighted="pkg.highlighted"
      :badge="pkg.badge"
    />
  </div>
</template>

<script setup lang="ts">
interface PricingPackage {
  id: string;
  name: string;
  description: string;
  icon: string;
  features: string[];
  highlighted?: boolean;
  badge?: string;
}

interface Props {
  packages: PricingPackage[];
}

defineProps<Props>();
</script>
