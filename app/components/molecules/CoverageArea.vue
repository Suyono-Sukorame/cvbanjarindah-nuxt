<template>
  <div class="bg-white rounded-xl p-6 shadow-lg border-l-4" :class="borderColor">
    <div class="flex items-start gap-3 mb-4">
      <span class="material-symbols-outlined text-2xl" :class="iconColor">
        location_on
      </span>
      <div>
        <h4 class="font-black text-lg text-slate-900 mb-1">{{ area.name }}</h4>
        <p class="text-sm text-slate-500">{{ area.cities.length }} Kota Terjangkau</p>
      </div>
    </div>
    
    <div class="flex flex-wrap gap-2">
      <span 
        v-for="city in area.cities"
        :key="city"
        class="px-3 py-1 rounded-full text-xs font-semibold"
        :class="badgeColor"
      >
        {{ city }}
      </span>
    </div>
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
  area: CoverageArea;
}

const props = defineProps<Props>();

const colorClasses = computed(() => {
  const colors: Record<string, { border: string; icon: string; badge: string }> = {
    blue: {
      border: 'border-blue-500',
      icon: 'text-blue-500',
      badge: 'bg-blue-100 text-blue-700',
    },
    green: {
      border: 'border-green-500',
      icon: 'text-green-500',
      badge: 'bg-green-100 text-green-700',
    },
    red: {
      border: 'border-red-500',
      icon: 'text-red-500',
      badge: 'bg-red-100 text-red-700',
    },
    yellow: {
      border: 'border-yellow-500',
      icon: 'text-yellow-500',
      badge: 'bg-yellow-100 text-yellow-700',
    },
    purple: {
      border: 'border-purple-500',
      icon: 'text-purple-500',
      badge: 'bg-purple-100 text-purple-700',
    },
  };
  return colors[props.area.color] || colors.blue;
});

const borderColor = computed(() => colorClasses.value.border);
const iconColor = computed(() => colorClasses.value.icon);
const badgeColor = computed(() => colorClasses.value.badge);
</script>
