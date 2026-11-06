<template>
  <div>
    <!-- 1. Hero Section -->
    <SectionsHeroSection
      title="CV Banjar Indah"
      subtitle="Distributor Terpercaya Produk Berkualitas di Kalimantan"
      cta-text="Hubungi Kami"
      cta-link="/kontak"
    />

    <!-- 2. Stats Section (NEW) -->
    <section class="py-16 bg-slate-50 border-y border-slate-200">
      <div class="max-w-7xl mx-auto px-4">
        <OrganismsStatsCounter :stats="companyStats" size="lg" />
      </div>
    </section>

    <!-- 3. Products Section -->
    <section class="py-16 max-w-7xl mx-auto px-4">
      <SectionsSectionHeading 
        title="Produk Kami" 
        subtitle="Berbagai kategori produk berkualitas untuk kebutuhan toko Anda"
      />
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <MoleculesCategoryCard
          v-for="(category, index) in featuredCategories"
          :key="category.id"
          :category="category"
          :image="categoryImages[index]"
        />
      </div>
    </section>

    <!-- 4. Pricing Packages Section (NEW) -->
    <section class="py-16 bg-gradient-to-br from-slate-50 to-slate-100">
      <div class="max-w-7xl mx-auto px-4">
        <SectionsSectionHeading 
          title="Paket Kemitraan" 
          subtitle="Pilih paket yang sesuai dengan skala bisnis Anda"
          align="center"
        />
        
        <OrganismsPricingGrid :packages="pricingPackages" />
      </div>
    </section>

    <!-- 5. Features Section -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4">
        <SectionsSectionHeading 
          title="Keunggulan Kami" 
          subtitle="Mengapa memilih CV Banjar Indah sebagai partner distributor Anda"
          align="center"
        />
        <OrganismsFeatureGrid :features="features" />
      </div>
    </section>

    <!-- 6. Client Logos Section (NEW) -->
    <section class="py-16 bg-slate-50">
      <div class="max-w-7xl mx-auto px-4">
        <SectionsSectionHeading 
          title="Brand yang Kami Distribusikan" 
          subtitle="Bermitra dengan brand-brand ternama dan terpercaya"
          align="center"
        />
        
        <OrganismsLogoMarquee :clients="clientBrands" :speed="30" />
      </div>
    </section>

    <!-- 7. Why Choose Us Section -->
    <section class="py-16 bg-white max-w-7xl mx-auto px-4">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
        <div>
          <h2 class="text-3xl font-black mb-6 text-slate-900">
            Mengapa Memilih Kami?
          </h2>
          <div class="space-y-4">
            <div 
              v-for="reason in whyChooseUs"
              :key="reason.id"
              class="flex gap-4"
            >
              <div class="flex-shrink-0 w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                <span class="text-primary text-2xl">{{ reason.icon }}</span>
              </div>
              <div>
                <h4 class="font-bold mb-1 text-slate-900">
                  {{ reason.title }}
                </h4>
                <p class="text-slate-600">
                  {{ reason.description }}
                </p>
              </div>
            </div>
          </div>
        </div>
        
        <div class="relative h-96 rounded-2xl overflow-hidden shadow-2xl">
          <AtomsImage
            src="https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=600&h=800&fit=crop"
            alt="Warehouse"
            :hover="false"
            class="h-full"
          />
        </div>
      </div>
    </section>

    <!-- 8. Coverage Map Section (NEW) -->
    <section class="py-16 bg-slate-50">
      <div class="max-w-7xl mx-auto px-4">
        <SectionsSectionHeading 
          title="Jangkauan Distribusi" 
          subtitle="Melayani seluruh wilayah Kalimantan dengan jaringan distribusi yang luas"
          align="center"
        />
        
        <OrganismsCoverageGrid :areas="coverageAreas" />
      </div>
    </section>

    <!-- 9. Testimonials Section (NEW) -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4">
        <SectionsSectionHeading 
          title="Kata Mereka" 
          subtitle="Testimoni dari mitra-mitra yang telah bergabung bersama kami"
          align="center"
        />
        
        <OrganismsTestimonialsGrid :testimonials="testimonials" />
      </div>
    </section>

    <!-- 10. Final CTA Section (NEW) -->
    <SectionsFinalCTA />
  </div>
</template>

<script setup lang="ts">
import { productCategories } from '~/data/products';
import { 
  features, 
  whyChooseUs, 
  companyStats, 
  clientBrands, 
  testimonials, 
  pricingPackages,
  coverageAreas 
} from '~/data/content';

definePageMeta({
  layout: 'default',
});

const featuredCategories = productCategories;

const categoryImages = [
  'https://images.unsplash.com/photo-1584556326561-c8746083993b?w=400&h=300&fit=crop',
  'https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?w=400&h=300&fit=crop',
  'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=400&h=300&fit=crop',
];
</script>
