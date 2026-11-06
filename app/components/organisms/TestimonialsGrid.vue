<template>
  <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
    <MoleculesTestimonialCard
      v-for="testimonial in testimonials"
      :key="testimonial.id"
      :testimonial="testimonial"
    />
  </div>
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
  testimonials: Testimonial[];
}

defineProps<Props>();
</script>
