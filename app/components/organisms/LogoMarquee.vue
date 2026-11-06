<template>
  <div class="relative overflow-hidden py-8">
    <!-- Gradient Overlays (fade edges) -->
    <div class="absolute left-0 top-0 bottom-0 w-32 bg-gradient-to-r from-slate-50 to-transparent z-10 pointer-events-none"></div>
    <div class="absolute right-0 top-0 bottom-0 w-32 bg-gradient-to-l from-slate-50 to-transparent z-10 pointer-events-none"></div>
    
    <!-- Marquee Container -->
    <div class="marquee-container">
      <div class="marquee-content">
        <!-- Original Set -->
        <div 
          v-for="client in clients" 
          :key="`original-${client.id}`"
          class="marquee-item"
        >
          <MoleculesClientLogo
            :name="client.name"
            :logo="client.logo"
          />
        </div>
        
        <!-- Duplicate Set (for seamless loop) -->
        <div 
          v-for="client in clients" 
          :key="`duplicate-${client.id}`"
          class="marquee-item"
        >
          <MoleculesClientLogo
            :name="client.name"
            :logo="client.logo"
          />
        </div>
      </div>
    </div>
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
  speed?: number; // Duration in seconds for one full cycle
}

withDefaults(defineProps<Props>(), {
  speed: 30,
});
</script>

<style scoped>
.marquee-container {
  display: flex;
  overflow: hidden;
  user-select: none;
}

.marquee-content {
  display: flex;
  gap: 3rem;
  animation: marquee var(--marquee-speed, 30s) linear infinite;
  will-change: transform;
}

.marquee-content:hover {
  animation-play-state: paused;
}

.marquee-item {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 180px;
}

/* Mobile: slower speed for better visibility */
@media (max-width: 768px) {
  .marquee-item {
    min-width: 140px;
  }
  
  .marquee-content {
    gap: 2rem;
    animation-duration: 40s;
  }
}

/* Marquee Animation */
@keyframes marquee {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(-50%);
  }
}

/* Reduce motion for accessibility */
@media (prefers-reduced-motion: reduce) {
  .marquee-content {
    animation-play-state: paused;
  }
}
</style>
