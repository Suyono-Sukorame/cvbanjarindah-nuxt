<template>
  <div class="max-w-7xl mx-auto px-4 py-16">
    <h1 class="text-4xl font-black mb-8">Hubungi Kami</h1>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
      <!-- Contact Form -->
      <div class="bg-white rounded-2xl p-8 shadow-lg">
        <h2 class="text-2xl font-black mb-6 text-slate-900">Kirim Pesan</h2>
        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div>
            <label class="block font-bold mb-2 text-slate-900">Nama</label>
            <input 
              v-model="form.name"
              type="text" 
              placeholder="Nama Anda"
              class="w-full px-4 py-2 rounded-lg border border-slate-300 bg-white text-slate-900 focus:ring-2 focus:ring-primary/30 focus:border-primary"
            />
          </div>
          <div>
            <label class="block font-bold mb-2 text-slate-900">Email</label>
            <input 
              v-model="form.email"
              type="email" 
              placeholder="Email Anda"
              class="w-full px-4 py-2 rounded-lg border border-slate-300 bg-white text-slate-900 focus:ring-2 focus:ring-primary/30 focus:border-primary"
            />
          </div>
          <div>
            <label class="block font-bold mb-2 text-slate-900">Nomor Telepon</label>
            <input 
              v-model="form.phone"
              type="tel" 
              placeholder="+62..."
              class="w-full px-4 py-2 rounded-lg border border-slate-300 bg-white text-slate-900 focus:ring-2 focus:ring-primary/30 focus:border-primary"
            />
          </div>
          <div>
            <label class="block font-bold mb-2 text-slate-900">Pesan</label>
            <textarea 
              v-model="form.message"
              placeholder="Tulis pesan Anda di sini..."
              rows="5"
              class="w-full px-4 py-2 rounded-lg border border-slate-300 bg-white text-slate-900 focus:ring-2 focus:ring-primary/30 focus:border-primary"
            ></textarea>
          </div>
          <button 
            type="submit"
            class="w-full px-6 py-3 bg-primary text-white font-bold rounded-lg hover:opacity-90 transition"
          >
            Kirim Pesan
          </button>
        </form>
      </div>

      <!-- Contact Information -->
      <div class="space-y-8">
        <!-- Direct Contact -->
        <div class="bg-white rounded-2xl p-8 shadow-lg">
          <h3 class="text-xl font-black mb-6 text-slate-900">Informasi Kontak</h3>
          <div class="space-y-6">
            <div class="flex gap-4">
              <span class="material-symbols-outlined text-primary text-2xl shrink-0">location_on</span>
              <div>
                <h4 class="font-bold mb-1 text-slate-900">Lokasi</h4>
                <p class="text-slate-600">Kalimantan</p>
              </div>
            </div>
            <div class="flex gap-4">
              <span class="material-symbols-outlined text-primary text-2xl shrink-0">phone</span>
              <div>
                <h4 class="font-bold mb-1 text-slate-900">Telepon</h4>
                <p class="text-slate-600">Hubungi via WhatsApp</p>
              </div>
            </div>
            <div class="flex gap-4">
              <span class="material-symbols-outlined text-primary text-2xl shrink-0">mail</span>
              <div>
                <h4 class="font-bold mb-1 text-slate-900">Email</h4>
                <p class="text-slate-600">info@cvbanjarindah.com</p>
              </div>
            </div>
          </div>
        </div>

        <!-- WhatsApp CTA -->
        <div class="bg-gradient-to-br from-green-500 to-green-600 text-white rounded-2xl p-8 shadow-lg">
          <h3 class="text-xl font-black mb-4">Chat via WhatsApp</h3>
          <p class="mb-6 opacity-90">
            Hubungi kami langsung melalui WhatsApp untuk informasi harga, stok, dan penawaran khusus.
          </p>
          <a 
            href="https://wa.me/62" 
            target="_blank"
            class="inline-flex items-center gap-2 px-6 py-3 bg-white text-green-600 font-bold rounded-lg hover:scale-105 transition"
          >
            <span class="material-symbols-outlined">chat</span>
            Buka WhatsApp
          </a>
        </div>

        <!-- Business Hours -->
        <div class="bg-white rounded-2xl p-8 shadow-lg">
          <h3 class="text-xl font-black mb-6 text-slate-900">Jam Operasional</h3>
          <div class="space-y-3">
            <div class="flex justify-between">
              <span class="font-bold text-slate-900">Senin - Jumat</span>
              <span class="text-slate-600">08:00 - 17:00</span>
            </div>
            <div class="flex justify-between">
              <span class="font-bold text-slate-900">Sabtu</span>
              <span class="text-slate-600">08:00 - 12:00</span>
            </div>
            <div class="flex justify-between">
              <span class="font-bold text-slate-900">Minggu</span>
              <span class="text-slate-600">Tutup</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

definePageMeta({
  layout: 'default'
});

interface ContactForm {
  name: string;
  email: string;
  phone: string;
  message: string;
}

const form = ref<ContactForm>({
  name: '',
  email: '',
  phone: '',
  message: ''
});

const handleSubmit = () => {
  // TODO: Integrate with Supabase to save inquiry
  console.log('Form submitted:', form.value);
  // Show success message
  alert('Terima kasih! Pesan Anda telah dikirim.');
  // Reset form
  form.value = { name: '', email: '', phone: '', message: '' };
};
</script>
