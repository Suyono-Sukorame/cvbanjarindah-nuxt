<template>
  <MoleculesCard class="h-full">
    <div class="flex flex-col h-full">
      <!-- Rating -->
      <div class="mb-4">
        <AtomsRating :rating="testimonial.rating" />
      </div>
      
      <!-- Quote -->
      <p class="text-slate-600 mb-6 flex-1 italic leading-relaxed">
        "{{ testimonial.text }}"
      </p>
      
      <!-- Author -->
      <div class="flex items-center gap-3 pt-4 border-t border-slate-100">
        <img 
          :src="testimonial.photo" 
          :alt="testimonial.name"
          class="w-12 h-12 rounded-full object-cover"
        />
        <div>
          <div class="font-bold text-slate-900">{{ testimonial.name }}</div>
          <div class="text-sm text-slate-500 flex items-center gap-1">
            <span class="material-symbols-outlined text-sm">location_on</span>
            {{ testimonial.location }}
          </div>
        </div>
      </div>
    </div>
  </MoleculesCard>
</template>

<script setup lang="ts">
interface Testimonial {
  id: string;
  name: string;
  location: string;
  photo: string;
  rating: number;
  text: string;
}

interface Props {
  testimonial: Testimonial;
}

defineProps<Props>();
</script>
