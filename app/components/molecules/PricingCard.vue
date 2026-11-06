<template>
  <MoleculesCard 
    :class="[
      'relative h-full transition-all duration-300',
      highlighted ? 'ring-2 ring-primary shadow-2xl scale-105' : 'hover:shadow-xl'
    ]"
  >
    <!-- Badge -->
    <div 
      v-if="badge"
      class="absolute -top-3 left-1/2 -translate-x-1/2 px-4 py-1 bg-primary text-white text-sm font-bold rounded-full shadow-lg"
    >
      {{ badge }}
    </div>
    
    <div class="text-center">
      <!-- Icon -->
      <div class="text-5xl mb-4">{{ icon }}</div>
      
      <!-- Name -->
      <h3 class="text-2xl font-black mb-2 text-slate-900">{{ name }}</h3>
      <p class="text-slate-600 mb-6">{{ description }}</p>
      
      <!-- Features -->
      <ul class="space-y-3 text-left mb-8">
        <li 
          v-for="(feature, index) in features"
          :key="index"
          class="flex gap-2 items-start"
        >
          <span class="material-symbols-outlined text-green-500 text-sm mt-0.5">check_circle</span>
          <span class="text-sm text-slate-700">{{ feature }}</span>
        </li>
      </ul>
      
      <!-- CTA -->
      <AtomsButton 
        to="/kontak"
        :variant="highlighted ? 'primary' : 'outline'"
        size="md"
        class="w-full"
      >
        Hubungi Sales
      </AtomsButton>
    </div>
  </MoleculesCard>
</template>

<script setup lang="ts">
interface Props {
  name: string;
  description: string;
  icon: string;
  features: string[];
  highlighted?: boolean;
  badge?: string;
}

withDefaults(defineProps<Props>(), {
  highlighted: false,
  badge: '',
});
</script>
