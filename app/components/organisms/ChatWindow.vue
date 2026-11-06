<template>
  <div class="flex flex-col h-full bg-slate-50">
    <!-- Header -->
    <MoleculesChatHeader
      :title="title"
      :status="status"
      @close="$emit('close')"
      @minimize="$emit('minimize')"
    />
    
    <!-- Messages Area -->
    <div 
      ref="messagesRef"
      class="flex-1 overflow-y-auto px-4 py-4 space-y-4 scroll-smooth"
    >
      <!-- Welcome Message -->
      <div v-if="messages.length === 1" class="text-center py-8">
        <div class="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="material-symbols-outlined text-primary text-3xl">chat_bubble</span>
        </div>
        <h3 class="font-bold text-slate-900 mb-2">Halo! 👋</h3>
        <p class="text-sm text-slate-600 mb-4">Ada yang bisa kami bantu?</p>
      </div>
      
      <!-- Messages -->
      <MoleculesChatMessage
        v-for="(message, index) in messages"
        :key="index"
        :message="message"
      />
      
      <!-- Loading Indicator -->
      <div v-if="isLoading" class="flex gap-2 items-center text-slate-400 text-sm">
        <AtomsAvatar size="sm" />
        <div class="flex gap-1">
          <span class="w-2 h-2 bg-slate-400 rounded-full animate-bounce"></span>
          <span class="w-2 h-2 bg-slate-400 rounded-full animate-bounce" style="animation-delay: 0.1s"></span>
          <span class="w-2 h-2 bg-slate-400 rounded-full animate-bounce" style="animation-delay: 0.2s"></span>
        </div>
      </div>
      
      <!-- Quick Replies -->
      <MoleculesQuickReply
        v-if="showQuickReplies && quickReplies.length > 0"
        :replies="quickReplies"
        @select="handleQuickReply"
      />
      
      <div ref="messagesEndRef"></div>
    </div>
    
    <!-- WhatsApp Handoff (conditional) -->
    <OrganismsWhatsAppHandoff
      v-if="showWhatsAppHandoff"
      :message="whatsappMessage"
    />
    
    <!-- Input Area -->
    <div class="bg-white border-t border-slate-200 p-4">
      <AtomsChatInput
        v-model="input"
        :disabled="isLoading"
        placeholder="Tanya stok, harga, atau area..."
        @send="handleSend"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, nextTick, onMounted } from 'vue';

interface Message {
  role: 'user' | 'ai';
  text: string;
  timestamp: Date;
}

interface QuickReply {
  id: string;
  text: string;
  icon?: string;
  value?: string;
}

interface Props {
  title?: string;
  status?: string;
}

withDefaults(defineProps<Props>(), {
  title: 'Asisten Indah',
  status: 'Online',
});

const emit = defineEmits<{
  'close': [];
  'minimize': [];
}>();

// State
const messages = ref<Message[]>([
  {
    role: 'ai',
    text: 'Halo! Saya **Asisten Indah** dari CV Banjar Indah. Ada yang bisa saya bantu?\n\nAnda bisa bertanya tentang:\n• Produk & stok\n• Harga grosir\n• Area distribusi\n• Cara jadi mitra',
    timestamp: new Date(),
  },
]);

const input = ref('');
const isLoading = ref(false);
const messagesRef = ref<HTMLDivElement>();
const messagesEndRef = ref<HTMLDivElement>();
const showWhatsAppHandoff = ref(false);

// Quick Replies
const quickReplies = ref<QuickReply[]>([
  { id: '1', text: 'Lihat Produk', icon: '🛍️', value: 'produk' },
  { id: '2', text: 'Harga Grosir', icon: '💰', value: 'harga' },
  { id: '3', text: 'Area Distribusi', icon: '📍', value: 'area' },
]);

const showQuickReplies = computed(() => {
  return messages.value.length <= 2 && !isLoading.value;
});

const whatsappMessage = computed(() => {
  const lastUserMessage = messages.value.filter(m => m.role === 'user').pop();
  return lastUserMessage 
    ? `Halo, saya ingin bertanya tentang: ${lastUserMessage.text}` 
    : 'Halo, saya ingin bertanya tentang produk CV Banjar Indah';
});

// Methods
const scrollToBottom = () => {
  nextTick(() => {
    messagesEndRef.value?.scrollIntoView({ behavior: 'smooth' });
  });
};

const handleQuickReply = (reply: QuickReply) => {
  input.value = reply.text;
  handleSend();
};

const handleSend = async () => {
  const userMsg = input.value.trim();
  if (!userMsg || isLoading.value) return;
  
  // Add user message
  messages.value.push({
    role: 'user',
    text: userMsg,
    timestamp: new Date(),
  });
  
  input.value = '';
  isLoading.value = true;
  scrollToBottom();
  
  // Simulate AI response
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  // Generate response based on keywords
  let response = '';
  const lowerMsg = userMsg.toLowerCase();
  
  if (lowerMsg.includes('produk') || lowerMsg.includes('stok')) {
    response = 'Kami menyediakan berbagai kategori produk:\n\n• **Makanan & Minuman**\n• **Perawatan & Kecantikan**\n• **Kebutuhan Rumah Tangga**\n\nUntuk info stok terkini dan katalog lengkap, silakan hubungi tim sales kami via WhatsApp! 📱';
    showWhatsAppHandoff.value = true;
  } else if (lowerMsg.includes('harga') || lowerMsg.includes('grosir')) {
    response = 'Kami menawarkan **3 paket kemitraan**:\n\n🏪 **Starter** - Minimal order 50 unit\n🏬 **Business** - Minimal order 100 unit (Popular!)\n🏢 **Enterprise** - Minimal order 500 unit\n\nUntuk penawaran harga khusus sesuai kebutuhan Anda, mari lanjut chat via WhatsApp! 💰';
    showWhatsAppHandoff.value = true;
  } else if (lowerMsg.includes('area') || lowerMsg.includes('distribusi') || lowerMsg.includes('kirim')) {
    response = 'Kami melayani distribusi ke **seluruh Kalimantan**:\n\n📍 Kalimantan Selatan\n📍 Kalimantan Tengah\n📍 Kalimantan Timur\n📍 Kalimantan Barat\n📍 Kalimantan Utara\n\nPengiriman cepat & aman! Untuk detail lebih lanjut tentang pengiriman ke area Anda, hubungi kami via WhatsApp.';
    showWhatsAppHandoff.value = true;
  } else {
    response = 'Terima kasih atas pertanyaan Anda! 🙏\n\nUntuk informasi lebih detail dan respon yang lebih cepat, silakan hubungi tim sales kami via WhatsApp. Kami siap membantu Anda!';
    showWhatsAppHandoff.value = true;
  }
  
  messages.value.push({
    role: 'ai',
    text: response,
    timestamp: new Date(),
  });
  
  isLoading.value = false;
  scrollToBottom();
};

// Auto scroll on mount
onMounted(() => {
  scrollToBottom();
});
</script>
