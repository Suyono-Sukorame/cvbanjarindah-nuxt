# 🚀 Quick Start Guide

## 5 Menit untuk Mulai Development

### 1️⃣ Install Dependencies (2 menit)

```bash
cd "/Users/admin/Project/01. Fullstack Web Developer/13. Nextjs/cvbanjarindah-nuxt"

# Install dengan pnpm (recommended)
pnpm install

# Atau gunakan npm
npm install

# Tunggu hingga selesai...
```

### 2️⃣ Setup Environment (1 menit)

```bash
# Copy environment file
cp .env.example .env.local

# Edit .env.local jika butuh (optional untuk tahap ini)
# nano .env.local
```

### 3️⃣ Start Development Server (2 menit)

```bash
# Run development server
pnpm dev

# Atau npm
npm run dev

# Tunggu hingga muncul "Local: http://localhost:3000"
```

### 4️⃣ Open in Browser

```
http://localhost:3000
```

Selesai! ✅

---

## 📁 Project Structure

```
app/
├── pages/           # Halaman (routes auto)
│   ├── index.vue    # Home page /
│   ├── produk.vue   # Product page /produk
│   ├── area.vue     # Distribution /area
│   ├── tentang.vue  # About /tentang
│   └── kontak.vue   # Contact /kontak
├── components/      # Reusable components
├── layouts/         # Page layouts
├── composables/     # Reusable logic
└── types/          # TypeScript types
```

---

## 🎨 Edit Your First Page

### Edit Home Page

```
File: app/pages/index.vue
```

Ubah text, warna, atau layout langsung! Perubahan otomatis terupdate di browser.

### Edit Navbar

```
File: app/components/Navbar.vue
```

Ubah logo, menu items, atau styling.

### Add New Page

1. Buat file baru: `app/pages/mypage.vue`
2. Otomatis accessible di: `http://localhost:3000/mypage`

Contoh:

```vue
<template>
  <div class="max-w-7xl mx-auto px-4 py-16">
    <h1 class="text-4xl font-black">Halaman Baru</h1>
    <p>Konten anda di sini</p>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: 'default'
});
</script>
```

---

## 🎨 Styling dengan Tailwind CSS

Gunakan Tailwind classes langsung:

```vue
<div class="p-4 rounded-lg bg-primary text-white hover:opacity-90 transition">
  Tombol dengan Tailwind
</div>
```

**Warna utama:** `primary` (oranye #ff5910)
**Warna sekunder:** `secondary` (biru gelap)

Lihat semua colors di `tailwind.config.ts`

---

## 🔌 Using Composables

Import logic yang sudah dibuat:

```vue
<script setup lang="ts">
// Auto-imported, tidak perlu import manual
const { messages, sendMessage } = useAIAssistant();
const { getProducts } = useSupabase();

// Gunakan langsung!
</script>
```

---

## 🐛 Debugging

### Console Errors?
1. Buka DevTools: `F12` atau `Cmd+Option+I`
2. Lihat tab "Console"
3. Fix error di code

### HMR (Hot Module Replacement)
- Ubah file → Otomatis terupdate di browser
- Jika tidak, refresh manual dengan `Cmd+R`

### Clear Cache
```bash
rm -rf .nuxt node_modules
pnpm install
pnpm dev
```

---

## 📚 Common Commands

```bash
# Development
pnpm dev              # Start dev server

# Build for production
pnpm build           # Build app
pnpm preview         # Preview build locally

# Other
pnpm lint            # Check code style (when configured)
pnpm test            # Run tests (when configured)
```

---

## 🌙 Dark Mode

Dark mode otomatis tersedia melalui:

```vue
<template>
  <!-- Otomatis adapt ke system dark mode -->
  <div class="bg-white dark:bg-slate-900">
    Content
  </div>
</template>
```

---

## ✨ Quick Tips

1. **Auto-import**: Components & composables otomatis di-import
2. **File-based routing**: Folder `pages/` = routes
3. **Hot reload**: Ubah file = instant update
4. **TypeScript**: Full type safety otomatis
5. **Tailwind**: Semua utilities ready to use

---

## 🔧 Environment Variables

Untuk koneksi ke Supabase & Gemini:

```
.env.local

NUXT_PUBLIC_SUPABASE_URL=your-url
NUXT_PUBLIC_SUPABASE_ANON_KEY=your-key
NUXT_PUBLIC_GEMINI_API_KEY=your-key
```

Prefix `NUXT_PUBLIC_` = accessible di client-side

---

## 📖 More Resources

- [Nuxt Docs](https://nuxt.com/docs)
- [Vue 3 Docs](https://vuejs.org)
- [Tailwind Docs](https://tailwindcss.com)
- [Project README](./README.md)
- [Setup Guide](./SETUP_GUIDE.md)

---

## ✅ What's Next?

1. ✅ Server running?
2. → Explore pages
3. → Edit components
4. → Add new pages
5. → Setup Supabase (Phase 2)
6. → Deploy (Phase 3)

---

## 🆘 Troubleshooting

**Port 3000 already in use?**
```bash
# Kill process
lsof -ti:3000 | xargs kill -9

# Or change port in nuxt.config.ts
```

**Dependencies error?**
```bash
# Clear and reinstall
rm -rf node_modules pnpm-lock.yaml
pnpm install
```

**HMR not working?**
```bash
# Restart server
# Kill: Ctrl+C
# Restart: pnpm dev
```

---

**Happy coding!** 🎉

Questions? Check the docs or run `pnpm dev` and explore!