<template>
  <section class="bg-gradient-to-br from-primary via-orange-500 to-red-600 text-white py-20">
    <div class="max-w-5xl mx-auto px-4 text-center">
      <!-- Icon/Emoji -->
      <div class="text-6xl mb-6 animate-bounce">🚀</div>
      
      <!-- Heading -->
      <h2 class="text-3xl md:text-5xl font-black mb-4">
        Siap Jadi Mitra Kami?
      </h2>
      
      <!-- Subheading -->
      <p class="text-lg md:text-xl mb-8 opacity-90 max-w-2xl mx-auto">
        Bergabunglah dengan ratusan mitra sukses kami dan dapatkan harga grosir terbaik untuk produk berkualitas!
      </p>
      
      <!-- CTA Buttons -->
      <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
        <!-- WhatsApp CTA (Primary) -->
        <a 
          href="https://wa.me/62"
          target="_blank"
          class="inline-flex items-center gap-3 px-8 py-4 bg-green-500 hover:bg-green-600 text-white font-bold rounded-xl shadow-2xl hover:scale-105 transition-all duration-300"
        >
          <span class="material-symbols-outlined text-2xl">chat</span>
          <span>Chat via WhatsApp</span>
        </a>
        
        <!-- Contact Form CTA (Secondary) -->
        <NuxtLink 
          to="/kontak"
          class="inline-flex items-center gap-3 px-8 py-4 bg-white text-primary hover:bg-slate-50 font-bold rounded-xl shadow-2xl hover:scale-105 transition-all duration-300"
        >
          <span class="material-symbols-outlined text-2xl">mail</span>
          <span>Kirim Pesan</span>
        </NuxtLink>
      </div>
      
      <!-- Trust Indicator -->
      <div class="mt-8 flex items-center justify-center gap-2 text-sm opacity-75">
        <span class="material-symbols-outlined text-lg">verified</span>
        <span>Terpercaya sejak 2010 • 500+ Mitra Aktif</span>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
// Final CTA Section - No props needed for now
</script>
