<template>
  <div>
    <!-- Hero Section -->
    <SectionsHeroSection
      variant="gradient"
      size="large"
      title="Tentang CV Banjar Indah"
      subtitle="Distributor terpercaya produk berkualitas di Kalimantan sejak tahun 2010"
    />

    <!-- About Content -->
    <section class="py-16 max-w-7xl mx-auto px-4">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-16">
        <AtomsImage
          src="https://images.unsplash.com/photo-1556761175-b413da4baf72?w=600&h=800&fit=crop"
          alt="Our Team"
          class="h-96"
          rounded="xl"
          :hover="false"
        />
        
        <div>
          <h2 class="text-3xl font-black mb-6 text-slate-900">
            Visi Kami
          </h2>
          <p class="text-slate-600 mb-6 leading-relaxed">
            Menjadi distributor produk consumer goods terdepan di Kalimantan dengan menghadirkan 
            produk berkualitas tinggi dan layanan terbaik untuk memenuhi kebutuhan masyarakat.
          </p>
          
          <h2 class="text-3xl font-black mb-6 text-slate-900">
            Misi Kami
          </h2>
          <ul class="space-y-3">
            <li 
              v-for="mission in missions"
              :key="mission"
              class="flex gap-3 text-slate-600"
            >
              <span class="text-primary mt-1">✓</span>
              <span>{{ mission }}</span>
            </li>
          </ul>
        </div>
      </div>

      <!-- Stats -->
      <div class="mb-16">
        <OrganismsStatsSection :stats="companyStats" />
      </div>

      <!-- Values -->
      <div class="mb-16">
        <SectionsSectionHeading title="Nilai-Nilai Kami" />
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div
            v-for="value in companyValues"
            :key="value.id"
            class="text-white rounded-2xl p-8 shadow-lg"
            :class="`bg-gradient-to-br from-${value.color}-500 to-${value.color}-600`"
          >
            <div class="text-5xl mb-4">{{ value.icon }}</div>
            <h3 class="font-black text-xl mb-3">{{ value.title }}</h3>
            <p :class="`text-${value.color}-50`">{{ value.description }}</p>
          </div>
        </div>
      </div>

      <!-- Team Section -->
      <MoleculesCard padding="lg" class="bg-slate-50">
        <SectionsSectionHeading title="Tim Kami" />
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div 
            v-for="member in teamMembers"
            :key="member.id"
            class="text-center"
          >
            <AtomsImage
              :src="member.image"
              :alt="member.name"
              rounded="full"
              aspect="square"
              :hover="false"
              class="w-32 h-32 mx-auto mb-4 shadow-lg"
            />
            <h4 class="font-bold text-lg text-slate-900">
              {{ member.name }}
            </h4>
            <p class="text-slate-600 text-sm">
              {{ member.role }}
            </p>
          </div>
        </div>
      </MoleculesCard>
    </section>
  </div>
</template>

<script setup lang="ts">
import { companyStats, teamMembers, companyValues } from '~/data/content';

definePageMeta({
  layout: 'default',
});

const missions = [
  'Menyediakan produk berkualitas dengan harga kompetitif',
  'Memberikan layanan distribusi yang cepat dan tepat waktu',
  'Membangun kemitraan jangka panjang dengan pelanggan',
  'Berkontribusi pada pertumbuhan ekonomi lokal',
];
</script>
