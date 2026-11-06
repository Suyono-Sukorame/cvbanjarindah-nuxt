export default defineNuxtConfig({
  ssr: false,
  compatibilityDate: '2024-11-06',

  // Deploy target: Cloudflare Pages
  nitro: {
    preset: 'cloudflare-pages',
  },
  
  srcDir: 'app/',
  
  // Component auto-import configuration
  components: [
    {
      path: '~/components/atoms',
      pathPrefix: false,
      prefix: 'Atoms',
    },
    {
      path: '~/components/molecules',
      pathPrefix: false,
      prefix: 'Molecules',
    },
    {
      path: '~/components/organisms',
      pathPrefix: false,
      prefix: 'Organisms',
    },
    {
      path: '~/components/sections',
      pathPrefix: false,
      prefix: 'Sections',
    },
    {
      path: '~/components',
      pathPrefix: false,
    },
  ],
  
  modules: [
    // '@nuxt/devtools',
    '@nuxtjs/tailwindcss',
  ],

  app: {
    head: {
      title: 'CV Banjar Indah - Distributor Produk Berkualitas',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'CV Banjar Indah - Distributor terpercaya produk tissue, masker, dan perlengkapan bayi di Kalimantan' },
        { name: 'theme-color', content: '#ff5910' },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined' },
      ],
    },
  },

  css: ['~/assets/css/main.css'],

  typescript: {
    strict: true,
    typeCheck: false,
  },

  devServer: {
    port: 3000,
  },

  build: {
    transpile: ['@google/genai'],
  },

  runtimeConfig: {
    public: {
      supabaseEndpoint: process.env.SUPABASE_URL || process.env.NUXT_PUBLIC_SUPABASE_URL,
      supabasePublishableKey: process.env.SUPABASE_KEY || process.env.NUXT_PUBLIC_SUPABASE_ANON_KEY,
      geminiApiKey: process.env.NUXT_PUBLIC_GEMINI_API_KEY,
      appName: 'CV Banjar Indah',
      appUrl: process.env.NUXT_PUBLIC_APP_URL || 'http://localhost:3000',
    },
  },
});
