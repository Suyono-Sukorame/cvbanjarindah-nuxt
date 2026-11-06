# CV Banjar Indah - Nuxt.js Version

Aplikasi distribusi produk CV Banjar Indah yang dibangun dengan **Nuxt 3**, **Supabase**, dan di-deploy di **Cloudflare Pages**.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- pnpm atau npm

### Installation

```bash
# Install dependencies
pnpm install

# Copy environment file
cp .env.example .env.local
```

### Development

```bash
# Start development server
pnpm dev

# Open http://localhost:3000
```

### Build & Deploy

```bash
# Build for production
pnpm build

# Preview production build
pnpm preview
```

## 📁 Project Structure

```
cvbanjarindah-nuxt/
├── app/
│   ├── components/        # Reusable Vue components
│   ├── composables/       # Vue composables (hooks equivalent)
│   ├── layouts/          # Layout templates
│   ├── pages/            # File-based routes
│   ├── types/            # TypeScript types
│   └── middleware/       # Route middleware (guards)
├── assets/
│   └── css/             # Global styles
├── public/              # Static files
├── nuxt.config.ts       # Nuxt configuration
├── tailwind.config.ts   # Tailwind CSS config
└── tsconfig.json        # TypeScript config
```

## 🔧 Environment Variables

Create `.env.local` file with:

```env
NUXT_PUBLIC_SUPABASE_URL=your-supabase-url
NUXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
NUXT_PUBLIC_GEMINI_API_KEY=your-gemini-api-key
NUXT_PUBLIC_APP_NAME=CV Banjar Indah
NUXT_PUBLIC_APP_URL=http://localhost:3000
```

## 🔄 Next Steps - Phase 2 Integration

### 1. Supabase Setup
- [ ] Create Supabase project
- [ ] Run database migrations
- [ ] Setup authentication
- [ ] Configure storage buckets

### 2. Google Gemini Integration
- [ ] Setup API key
- [ ] Integrate with AIAssistant component
- [ ] Test chat functionality

### 3. Cloudflare Deployment
- [ ] Connect Git repository
- [ ] Configure build settings
- [ ] Setup custom domain
- [ ] Enable edge caching

## 📚 Key Features

### ✅ Current
- File-based routing
- Responsive design with Tailwind CSS
- Dark mode support
- AI Assistant component
- Mobile navigation

### 🔄 Coming Soon (Phase 2-3)
- Supabase authentication
- Product management with database
- Customer inquiries storage
- AI Assistant with Gemini API
- Admin dashboard
- Real-time product updates

## 🛠️ Development

### Add a New Page
Create file in `app/pages/`:
```vue
<template>
  <div class="max-w-7xl mx-auto px-4">
    <!-- Your content -->
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: 'default'
});
</script>
```

### Add a New Component
Create file in `app/components/`:
```vue
<template>
  <div>
    <!-- Component markup -->
  </div>
</template>

<script setup lang="ts">
// Component logic
</script>
```

### Add a New Composable
Create file in `app/composables/`:
```ts
export const useMyComposable = () => {
  // Composable logic
  return {
    // Expose methods/refs
  };
};
```

## 🧪 Testing

```bash
# Run tests
pnpm run test

# Run tests in watch mode
pnpm run test:watch
```

## 📖 Documentation

- [Nuxt 3 Docs](https://nuxt.com)
- [Vue 3 Docs](https://vuejs.org)
- [Tailwind CSS](https://tailwindcss.com)
- [Supabase Docs](https://supabase.com/docs)
- [Cloudflare Pages](https://developers.cloudflare.com/pages/)

## 🚀 Deployment

### Deploy to Cloudflare Pages

1. Push to GitHub
2. Connect repository in Cloudflare Pages
3. Set build command: `pnpm build`
4. Set output directory: `.output/public`
5. Deploy! 🎉

## 📝 License

Private project - CV Banjar Indah

## 👥 Contributors

- Development Team

## 📞 Support

For inquiries, contact: info@cvbanjarindah.com
# cvbanjarindah-nuxt
