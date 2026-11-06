<template>
  <div 
    class="flex gap-2 animate-in fade-in zoom-in-95 duration-300"
    :class="message.role === 'user' ? 'flex-row-reverse' : 'flex-row'"
  >
    <!-- Avatar -->
    <AtomsAvatar
      v-if="message.role === 'ai'"
      :initials="avatarInitials"
      size="sm"
      bg-color="bg-primary"
    />
    
    <!-- Message Bubble -->
    <div class="flex flex-col gap-1" :class="message.role === 'user' ? 'items-end' : 'items-start'">
      <AtomsChatBubble 
        :variant="message.role"
        :position="bubblePosition"
      >
        <FormattedMessage :text="message.text" />
      </AtomsChatBubble>
      
      <!-- Timestamp -->
      <span class="text-xs text-slate-400 px-2">
        {{ formatTime(message.timestamp) }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Message {
  role: 'user' | 'ai';
  text: string;
  timestamp?: Date;
}

interface Props {
  message: Message;
  avatarInitials?: string;
  isLastInGroup?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  avatarInitials: 'AI',
  isLastInGroup: true,
});

const bubblePosition = computed(() => {
  return props.isLastInGroup ? 'end' : 'start';
});

const formatTime = (date?: Date) => {
  if (!date) return '';
  const now = new Date();
  const diff = now.getTime() - date.getTime();
  
  if (diff < 60000) return 'Baru saja';
  if (diff < 3600000) return `${Math.floor(diff / 60000)} menit lalu`;
  
  return date.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
};
</script>
