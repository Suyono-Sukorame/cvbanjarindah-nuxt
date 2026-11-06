<template>
  <div class="flex flex-col min-h-screen pb-20 md:pb-0">
    <Navbar />
    
    <main class="flex-grow">
      <slot />
    </main>
    
    <Footer />
    <BottomNav />
    <AIAssistant />
  </div>
</template>

<script setup lang="ts">
// Layout setup
</script>
