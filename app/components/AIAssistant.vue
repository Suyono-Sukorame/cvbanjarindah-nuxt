<template>
  <div>
    <!-- Chat Button (Bottom Right) -->
    <button 
      @click="toggleChat"
      class="fixed bottom-24 right-4 md:bottom-4 md:right-4 z-50 w-14 h-14 rounded-full flex items-center justify-center transition-all duration-300 shadow-2xl group"
      :class="isOpen ? 'bg-slate-900 scale-95' : 'bg-primary hover:scale-110'"
      aria-label="Chat Assistant"
    >
      <span class="material-symbols-outlined text-white text-2xl transition-transform" :class="{ 'rotate-90': isOpen }">
        {{ isOpen ? 'close' : 'chat_bubble' }}
      </span>
      
      <!-- Pulse Ring Animation (when closed) -->
      <span 
        v-if="!isOpen"
        class="absolute inset-0 rounded-full bg-primary animate-ping opacity-20"
      ></span>
      
      <!-- Notification Badge -->
      <span 
        v-if="!isOpen && unreadCount > 0"
        class="absolute -top-1 -right-1 w-5 h-5 bg-red-500 text-white text-xs font-bold rounded-full flex items-center justify-center"
      >
        {{ unreadCount }}
      </span>
    </button>

    <!-- Backdrop (Mobile & Tablet) -->
    <Transition name="backdrop">
      <div
        v-if="isOpen"
        @click="closeChat"
        class="fixed inset-0 bg-black/40 backdrop-blur-sm z-40 md:hidden"
      ></div>
    </Transition>

    <!-- Chat Window -->
    <Transition name="chat">
      <div
        v-if="isOpen"
        class="fixed z-50 bg-white rounded-2xl shadow-2xl flex flex-col overflow-hidden"
        :class="chatWindowClasses"
      >
        <OrganismsChatWindow
          @close="closeChat"
          @minimize="minimizeChat"
        />
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, onUnmounted } from 'vue';

const isOpen = ref(false);
const unreadCount = ref(0);

const chatWindowClasses = computed(() => {
  return [
    // Mobile (< 768px): 70% width, 55vh height, positioned right, above AI button
    'bottom-[108px] right-4',  // 108px = 96px (button bottom-24) + 12px gap
    'w-[70vw] h-[55vh]',
    // Tablet & Desktop (>= 768px): Fixed bottom-right, standard size
    'md:bottom-4',
    'md:w-[420px] md:h-[680px] md:max-h-[85vh]',
  ];
});

const toggleChat = () => {
  console.log('🔵 Toggle Chat clicked! Current state:', isOpen.value);
  isOpen.value = !isOpen.value;
  console.log('🔵 New state:', isOpen.value);
  if (isOpen.value) {
    unreadCount.value = 0;
  }
};

const closeChat = () => {
  isOpen.value = false;
};

const minimizeChat = () => {
  isOpen.value = false;
};

// Prevent body scroll when chat is open on mobile
watch(isOpen, (newVal) => {
  if (newVal && window.innerWidth < 768) {
    document.body.style.overflow = 'hidden';
  } else {
    document.body.style.overflow = '';
  }
});

// Cleanup on unmount
onUnmounted(() => {
  document.body.style.overflow = '';
});
</script>

<style scoped>
/* Chat Window Transitions */
.chat-enter-active,
.chat-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.chat-enter-from,
.chat-leave-to {
  opacity: 0;
  transform: translateY(20px) scale(0.95);
}

/* Backdrop Transitions */
.backdrop-enter-active,
.backdrop-leave-active {
  transition: opacity 0.3s ease;
}

.backdrop-enter-from,
.backdrop-leave-to {
  opacity: 0;
}
</style>
