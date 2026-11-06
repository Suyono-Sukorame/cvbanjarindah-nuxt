<template>
  <div class="bg-gradient-to-r from-green-50 to-emerald-50 border-t border-green-200 p-4">
    <div class="flex items-center gap-3 mb-3">
      <div class="w-10 h-10 bg-green-500 rounded-full flex items-center justify-center shrink-0">
        <span class="material-symbols-outlined text-white">chat</span>
      </div>
      <div class="flex-1">
        <h4 class="font-bold text-sm text-slate-900">Butuh bantuan langsung?</h4>
        <p class="text-xs text-slate-600">Tim kami siap membantu via WhatsApp</p>
      </div>
    </div>
    
    <a
      :href="whatsappUrl"
      target="_blank"
      class="flex items-center justify-center gap-2 w-full px-4 py-2.5 bg-green-500 hover:bg-green-600 text-white font-bold rounded-lg transition-colors active:scale-95"
    >
      <span class="material-symbols-outlined text-xl">send</span>
      <span>Chat via WhatsApp</span>
    </a>
    
    <p class="text-center text-xs text-slate-500 mt-2">
      Response time: ~5 menit
    </p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  phoneNumber?: string;
  message?: string;
}

const props = withDefaults(defineProps<Props>(), {
  phoneNumber: '62',
  message: 'Halo, saya ingin bertanya tentang produk CV Banjar Indah',
});

const whatsappUrl = computed(() => {
  const encodedMessage = encodeURIComponent(props.message);
  return `https://wa.me/${props.phoneNumber}?text=${encodedMessage}`;
});
</script>
