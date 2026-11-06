<template>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <MoleculesCoverageArea
      v-for="area in areas"
      :key="area.id"
      :area="area"
    />
  </div>
</template>

<script setup lang="ts">
interface CoverageArea {
  id: string;
  name: string;
  cities: string[];
  color: string;
}

interface Props {
  areas: CoverageArea[];
}

defineProps<Props>();
</script>
