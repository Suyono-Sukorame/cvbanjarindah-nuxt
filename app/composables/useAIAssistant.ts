import { ref, nextTick } from 'vue';

export interface Message {
  role: 'user' | 'ai';
  text: string;
  timestamp?: Date;
}

export const useAIAssistant = () => {
  const messages = ref<Message[]>([
    {
      role: 'ai',
      text: 'Halo! Saya **Asisten Indah**. Ada yang bisa saya bantu terkait distribusi produk kami?',
      timestamp: new Date(),
    }
  ]);

  const isLoading = ref(false);
  const input = ref('');

  const sendMessage = async (userMessage: string) => {
    if (!userMessage.trim() || isLoading.value) return;

    // Add user message
    messages.value.push({
      role: 'user',
      text: userMessage,
      timestamp: new Date(),
    });

    input.value = '';
    isLoading.value = true;

    try {
      // TODO: Integrate with Google Gemini API
      // This is a placeholder - will be replaced with actual API call
      await new Promise(resolve => setTimeout(resolve, 1000));

      const aiResponse = 'Terima kasih atas pertanyaan Anda. Untuk informasi harga grosir dan stok terkini, silakan hubungi kami via WhatsApp di menu **Kontak**.';

      messages.value.push({
        role: 'ai',
        text: aiResponse,
        timestamp: new Date(),
      });
    } catch (error) {
      console.error('AI Assistant Error:', error);
      messages.value.push({
        role: 'ai',
        text: 'Layanan sibuk, silakan cek menu Kontak.',
        timestamp: new Date(),
      });
    } finally {
      isLoading.value = false;
    }
  };

  const clearMessages = () => {
    messages.value = [
      {
        role: 'ai',
        text: 'Halo! Saya **Asisten Indah**. Ada yang bisa saya bantu terkait distribusi produk kami?',
        timestamp: new Date(),
      }
    ];
  };

  return {
    messages,
    isLoading,
    input,
    sendMessage,
    clearMessages,
  };
};
