<template>
  <footer class="bg-slate-900 text-white py-12 mt-20">
    <div class="max-w-7xl mx-auto px-4">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
        <!-- About -->
        <div>
          <h3 class="font-bold text-lg mb-4">CV Banjar Indah</h3>
          <p class="text-slate-300 text-sm leading-relaxed">
            Distributor terpercaya produk tissue, masker, dan perlengkapan bayi berkualitas di Kalimantan.
          </p>
        </div>

        <!-- Products -->
        <div>
          <h4 class="font-bold mb-4">Produk</h4>
          <ul class="space-y-2 text-slate-300 text-sm">
            <li><a href="#" class="hover:text-white transition">Tissue</a></li>
            <li><a href="#" class="hover:text-white transition">Masker</a></li>
            <li><a href="#" class="hover:text-white transition">Perlengkapan Bayi</a></li>
          </ul>
        </div>

        <!-- Quick Links -->
        <div>
          <h4 class="font-bold mb-4">Menu</h4>
          <ul class="space-y-2 text-slate-300 text-sm">
            <li><NuxtLink to="/" class="hover:text-white transition">Home</NuxtLink></li>
            <li><NuxtLink to="/tentang" class="hover:text-white transition">Tentang</NuxtLink></li>
            <li><NuxtLink to="/kontak" class="hover:text-white transition">Kontak</NuxtLink></li>
          </ul>
        </div>

        <!-- Contact -->
        <div>
          <h4 class="font-bold mb-4">Hubungi Kami</h4>
          <div class="space-y-2 text-slate-300 text-sm">
            <p>📍 Kalimantan</p>
            <p>📞 (Hubungi via kontak)</p>
            <p>✉️ info@cvbanjarindah.com</p>
          </div>
        </div>
      </div>

      <!-- Divider -->
      <div class="border-t border-slate-800 pt-8">
        <div class="flex flex-col md:flex-row items-center justify-between">
          <p class="text-slate-400 text-sm">
            © 2024 CV Banjar Indah. Semua hak cipta dilindungi.
          </p>
          <div class="flex gap-4 mt-4 md:mt-0">
            <a href="#" class="text-slate-400 hover:text-white transition">Twitter</a>
            <a href="#" class="text-slate-400 hover:text-white transition">Facebook</a>
            <a href="#" class="text-slate-400 hover:text-white transition">Instagram</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
// Footer without dark mode
</script>
