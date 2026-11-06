<template>
  <div class="flex flex-wrap gap-2">
    <button
      v-for="reply in replies"
      :key="reply.id"
      @click="$emit('select', reply)"
      class="px-4 py-2 bg-white border border-slate-300 text-slate-700 text-sm font-semibold rounded-full hover:border-primary hover:text-primary hover:bg-primary/5 transition-all active:scale-95"
    >
      <span v-if="reply.icon" class="mr-1">{{ reply.icon }}</span>
      {{ reply.text }}
    </button>
  </div>
</template>

<script setup lang="ts">
interface QuickReply {
  id: string;
  text: string;
  icon?: string;
  value?: string;
}

interface Props {
  replies: QuickReply[];
}

defineProps<Props>();

defineEmits<{
  'select': [reply: QuickReply];
}>();
</script>
