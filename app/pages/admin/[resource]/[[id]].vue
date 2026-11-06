<template>
  <OrganismsAdminResourceView :resource-key="resourceKey" />
</template>

<script setup lang="ts">
definePageMeta({ layout: 'admin', middleware: 'auth' });
const route = useRoute();
const resourceKey = computed(() => String(route.params.resource ?? ''));
</script>