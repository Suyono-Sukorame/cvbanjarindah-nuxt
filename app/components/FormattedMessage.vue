<template>
  <div class="flex flex-col gap-4">
    <div 
      v-for="(para, pIdx) in paragraphs" 
      :key="pIdx"
    >
      <!-- List format -->
      <div 
        v-if="isList(para)"
        class="bg-slate-50/50 rounded-xl p-3 border border-slate-100"
      >
        <ul class="space-y-2">
          <li 
            v-for="(line, lIdx) in para.split('\n')" 
            :key="lIdx"
            class="flex gap-2 items-start"
          >
            <div class="mt-1.5 shrink-0 w-1.5 h-1.5 rounded-full bg-primary shadow-[0_0_8px_rgba(255,89,16,0.4)]"></div>
            <span 
              class="flex-1 text-[13px] leading-relaxed text-slate-700"
              v-html="formatText(line.replace(/^[•\-\d\.]+\s*/, ''))"
            ></span>
          </li>
        </ul>
      </div>

      <!-- Paragraph format -->
      <p 
        v-else
        class="text-[13px] leading-[1.6] text-slate-700"
        v-html="formatText(para)"
      ></p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  text: string;
}

const props = defineProps<Props>();

const paragraphs = computed(() => {
  return props.text.split('\n\n');
});

const isList = (para: string) => {
  const lines = para.split('\n');
  return lines.length > 1 && lines.every(line => {
    const trimmed = line.trim();
    return trimmed.startsWith('•') || trimmed.startsWith('-') || /^\d+\./.test(trimmed);
  });
};

const formatText = (text: string) => {
  return text.replace(/\*\*(.*?)\*\*/g, '<b class="font-extrabold text-slate-900">$1</b>');
};
</script>
