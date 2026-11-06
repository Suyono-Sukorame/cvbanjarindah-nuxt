<template>
  <div class="flex gap-2 items-end">
    <input
      :value="modelValue"
      @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
      @keydown.enter="$emit('send')"
      type="text"
      :placeholder="placeholder"
      :disabled="disabled"
      class="flex-1 bg-slate-100 border-none rounded-xl px-4 py-3 text-sm text-slate-900 placeholder:text-slate-400 focus:ring-2 focus:ring-primary/20 transition-all resize-none disabled:opacity-50"
      :class="{ 'pr-12': $slots.default }"
    />
    
    <button
      v-if="showButton"
      @click="$emit('send')"
      :disabled="disabled || !modelValue"
      class="w-10 h-10 bg-primary text-white rounded-xl flex items-center justify-center hover:bg-primary/90 active:scale-95 transition-all disabled:opacity-50 disabled:cursor-not-allowed shrink-0"
    >
      <span class="material-symbols-outlined text-xl">send</span>
    </button>
  </div>
</template>

<script setup lang="ts">
interface Props {
  modelValue: string;
  placeholder?: string;
  disabled?: boolean;
  showButton?: boolean;
}

withDefaults(defineProps<Props>(), {
  placeholder: 'Ketik pesan...',
  disabled: false,
  showButton: true,
});

defineEmits<{
  'update:modelValue': [value: string];
  'send': [];
}>();
</script>
