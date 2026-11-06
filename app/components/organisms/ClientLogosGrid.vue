<template>
  <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
    <MoleculesClientLogo
      v-for="client in clients"
      :key="client.id"
      :name="client.name"
      :logo="client.logo"
    />
  </div>
</template>

<script setup lang="ts">
interface Client {
  id: string;
  name: string;
  logo: string;
}

interface Props {
  clients: Client[];
}

defineProps<Props>();
</script>
