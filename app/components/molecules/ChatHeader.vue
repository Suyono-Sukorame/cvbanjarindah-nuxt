<template>
  <div class="bg-slate-900 text-white px-4 py-3 flex items-center justify-between shrink-0">
    <div class="flex items-center gap-3">
      <AtomsAvatar
        :initials="avatarInitials"
        size="md"
        bg-color="bg-primary"
      />
      <div>
        <h3 class="font-bold text-sm">{{ title }}</h3>
        <div class="flex items-center gap-1.5">
          <span class="w-2 h-2 bg-green-500 rounded-full animate-pulse"></span>
          <p class="text-xs text-slate-400">{{ status }}</p>
        </div>
      </div>
    </div>
    
    <div class="flex items-center gap-2">
      <!-- Minimize button (desktop only) -->
      <button
        v-if="showMinimize"
        @click="$emit('minimize')"
        class="hidden md:flex w-8 h-8 items-center justify-center hover:bg-white/10 rounded-lg transition-colors"
        aria-label="Minimize"
      >
        <span class="material-symbols-outlined text-xl">remove</span>
      </button>
      
      <!-- Close button -->
      <button
        @click="$emit('close')"
        class="w-8 h-8 flex items-center justify-center hover:bg-white/10 rounded-lg transition-colors"
        aria-label="Close"
      >
        <span class="material-symbols-outlined text-xl">close</span>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  title?: string;
  status?: string;
  avatarInitials?: string;
  showMinimize?: boolean;
}

withDefaults(defineProps<Props>(), {
  title: 'Asisten Indah',
  status: 'Online',
  avatarInitials: 'AI',
  showMinimize: true,
});

defineEmits<{
  'close': [];
  'minimize': [];
}>();
</script>
