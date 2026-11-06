<template>
  <div class="max-w-7xl mx-auto px-4 py-16">
    <h1 class="text-4xl font-black mb-4 text-slate-900">Area Distribusi</h1>
    <p class="text-slate-600 mb-12">
      Jangkauan distribusi kami meliputi seluruh Kalimantan
    </p>

    <!-- Map section with image -->
    <div class="relative rounded-2xl overflow-hidden h-96 mb-12 shadow-2xl">
      <img 
        src="https://images.unsplash.com/photo-1524661135-423995f22d0b?w=1200&h=600&fit=crop" 
        alt="Kalimantan Map"
        class="w-full h-full object-cover"
      />
      <div class="absolute inset-0 bg-gradient-to-t from-slate-900/80 to-transparent flex items-end">
        <div class="p-8 text-white">
          <h3 class="text-2xl font-black mb-2">Melayani Seluruh Kalimantan</h3>
          <p class="text-slate-200">Distribusi cepat dan terpercaya ke setiap wilayah</p>
        </div>
      </div>
    </div>

    <!-- Coverage Areas -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
      <div class="bg-white rounded-2xl p-8 shadow-lg">
        <h3 class="font-black text-2xl mb-6 text-slate-900">Cakupan Area</h3>
        <ul class="space-y-4">
          <li class="flex items-center gap-3">
            <span class="material-symbols-outlined text-primary">check_circle</span>
            <span class="text-slate-900">Kalimantan Selatan</span>
          </li>
          <li class="flex items-center gap-3">
            <span class="material-symbols-outlined text-primary">check_circle</span>
            <span class="text-slate-900">Kalimantan Tengah</span>
          </li>
          <li class="flex items-center gap-3">
            <span class="material-symbols-outlined text-primary">check_circle</span>
            <span class="text-slate-900">Kalimantan Barat</span>
          </li>
          <li class="flex items-center gap-3">
            <span class="material-symbols-outlined text-primary">check_circle</span>
            <span class="text-slate-900">Kalimantan Timur</span>
          </li>
          <li class="flex items-center gap-3">
            <span class="material-symbols-outlined text-primary">check_circle</span>
            <span class="text-slate-900">Kalimantan Utara</span>
          </li>
        </ul>
      </div>

      <div class="bg-white rounded-2xl p-8 shadow-lg">
        <h3 class="font-black text-2xl mb-6 text-slate-900">Keunggulan Pengiriman</h3>
        <ul class="space-y-4">
          <li class="flex items-start gap-3">
            <span class="material-symbols-outlined text-primary mt-1">local_shipping</span>
            <div>
              <h4 class="font-bold text-slate-900">Pengiriman Tepat Waktu</h4>
              <p class="text-sm text-slate-600">Kami menjamin pengiriman sesuai jadwal</p>
            </div>
          </li>
          <li class="flex items-start gap-3">
            <span class="material-symbols-outlined text-primary mt-1">verified</span>
            <div>
              <h4 class="font-bold text-slate-900">Produk Aman</h4>
              <p class="text-sm text-slate-600">Packaging aman dan profesional</p>
            </div>
          </li>
          <li class="flex items-start gap-3">
            <span class="material-symbols-outlined text-primary mt-1">support_agent</span>
            <div>
              <h4 class="font-bold text-slate-900">Dukungan Penuh</h4>
              <p class="text-sm text-slate-600">Tim siap membantu di setiap kota</p>
            </div>
          </li>
        </ul>
      </div>
    </div>

    <!-- Delivery Fleet -->
    <div class="bg-gradient-to-br from-primary to-orange-600 rounded-2xl p-8 md:p-12 text-white shadow-2xl">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
        <div>
          <h3 class="text-3xl font-black mb-4">Armada Pengiriman Modern</h3>
          <p class="text-white/90 mb-6">
            Dilengkapi dengan armada pengiriman yang terawat dan sistem tracking untuk memastikan produk Anda sampai dengan aman dan tepat waktu.
          </p>
          <NuxtLink 
            to="/kontak"
            class="inline-block px-6 py-3 bg-white text-primary font-bold rounded-lg hover:scale-105 transition"
          >
            Hubungi Kami
          </NuxtLink>
        </div>
        <div class="relative h-64 rounded-xl overflow-hidden">
          <img 
            src="https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=600&h=400&fit=crop" 
            alt="Delivery Fleet"
            class="w-full h-full object-cover"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: 'default'
});
</script>
