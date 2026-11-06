import type { Feature, Stat, TeamMember } from '~/types/common';

export const features: Feature[] = [
  {
    id: '1',
    title: 'Kualitas Terjamin',
    description: 'Produk original dan berlisensi',
    icon: '✓',
  },
  {
    id: '2',
    title: 'Pengiriman Cepat',
    description: 'Pengiriman tepat waktu ke seluruh area',
    icon: '⚡',
  },
  {
    id: '3',
    title: 'Harga Kompetitif',
    description: 'Harga grosir yang terjangkau',
    icon: '💰',
  },
  {
    id: '4',
    title: 'Layanan Terbaik',
    description: 'Tim profesional siap membantu',
    icon: '🤝',
  },
];

export const companyStats: Stat[] = [
  {
    id: '1',
    value: '15',
    label: 'Tahun Pengalaman',
    suffix: '+',
  },
  {
    id: '2',
    value: '500',
    label: 'Mitra Toko',
    suffix: '+',
  },
  {
    id: '3',
    value: '50',
    label: 'Produk Brand',
    suffix: '+',
  },
  {
    id: '4',
    value: '5',
    label: 'Provinsi Coverage',
  },
];

export const teamMembers: TeamMember[] = [
  {
    id: '1',
    name: 'Tim Distribusi',
    role: 'Professional & Berpengalaman',
    image: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&h=200&fit=crop',
  },
  {
    id: '2',
    name: 'Customer Service',
    role: 'Siap Melayani 24/7',
    image: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&h=200&fit=crop',
  },
  {
    id: '3',
    name: 'Manajemen',
    role: 'Berpengalaman Puluhan Tahun',
    image: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200&h=200&fit=crop',
  },
];

export const whyChooseUs = [
  {
    id: '1',
    icon: '📦',
    title: 'Stok Lengkap',
    description: 'Tersedia berbagai produk dengan stok yang selalu siap',
  },
  {
    id: '2',
    icon: '🚚',
    title: 'Distribusi Luas',
    description: 'Jangkauan ke seluruh wilayah Kalimantan',
  },
  {
    id: '3',
    icon: '⭐',
    title: 'Terpercaya',
    description: 'Sudah dipercaya oleh ribuan pelanggan',
  },
];

export const companyValues = [
  {
    id: '1',
    icon: '🎯',
    title: 'Integritas',
    description: 'Berkomitmen pada kejujuran dan transparansi dalam setiap transaksi bisnis',
    color: 'blue',
  },
  {
    id: '2',
    icon: '⚡',
    title: 'Profesionalisme',
    description: 'Memberikan layanan terbaik dengan standar profesional yang tinggi',
    color: 'green',
  },
  {
    id: '3',
    icon: '🤝',
    title: 'Kemitraan',
    description: 'Membangun hubungan jangka panjang yang saling menguntungkan',
    color: 'purple',
  },
];

// Client Brands
export const clientBrands = [
  { id: '1', name: 'Brand A', logo: 'https://via.placeholder.com/150x60/FF5910/FFFFFF?text=Brand+A' },
  { id: '2', name: 'Brand B', logo: 'https://via.placeholder.com/150x60/FF5910/FFFFFF?text=Brand+B' },
  { id: '3', name: 'Brand C', logo: 'https://via.placeholder.com/150x60/FF5910/FFFFFF?text=Brand+C' },
  { id: '4', name: 'Brand D', logo: 'https://via.placeholder.com/150x60/FF5910/FFFFFF?text=Brand+D' },
  { id: '5', name: 'Brand E', logo: 'https://via.placeholder.com/150x60/FF5910/FFFFFF?text=Brand+E' },
  { id: '6', name: 'Brand F', logo: 'https://via.placeholder.com/150x60/FF5910/FFFFFF?text=Brand+F' },
];

// Testimonials
export const testimonials = [
  {
    id: '1',
    name: 'Toko Jaya Makmur',
    location: 'Banjarmasin',
    photo: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop',
    rating: 5,
    text: 'Sudah 5 tahun bermitra dengan CV Banjar Indah. Stok selalu tersedia dan pengiriman tepat waktu. Sangat membantu bisnis kami!',
  },
  {
    id: '2',
    name: 'UD Sumber Rezeki',
    location: 'Palangkaraya',
    photo: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
    rating: 5,
    text: 'Harga kompetitif dan pelayanan ramah. Tim sales selalu responsif membantu kebutuhan stok toko kami.',
  },
  {
    id: '3',
    name: 'Toko Berkah Jaya',
    location: 'Balikpapan',
    photo: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop',
    rating: 5,
    text: 'Partner distributor terbaik! Produk berkualitas dan sistem pembayaran fleksibel. Highly recommended!',
  },
];

// Pricing Packages
export const pricingPackages = [
  {
    id: '1',
    name: 'Starter',
    description: 'Untuk toko retail pemula',
    icon: '🏪',
    features: [
      'Minimal order: 50 unit',
      'Harga grosir tier 1',
      'Pengiriman reguler',
      'Support via email',
      'Pembayaran COD/Transfer',
    ],
    highlighted: false,
  },
  {
    id: '2',
    name: 'Business',
    description: 'Untuk toko retail established',
    icon: '🏬',
    features: [
      'Minimal order: 100 unit',
      'Harga grosir tier 2 (lebih murah)',
      'Pengiriman prioritas',
      'Dedicated account manager',
      'Pembayaran tempo 7 hari',
      'Bonus produk promosi',
    ],
    highlighted: true,
    badge: 'Popular',
  },
  {
    id: '3',
    name: 'Enterprise',
    description: 'Untuk chain store & reseller',
    icon: '🏢',
    features: [
      'Minimal order: 500 unit',
      'Harga grosir tier 3 (termurah)',
      'Pengiriman express',
      'Priority support 24/7',
      'Pembayaran tempo 14-30 hari',
      'Custom packaging & branding',
      'Free marketing materials',
    ],
    highlighted: false,
  },
];

// Coverage Areas
export const coverageAreas = [
  {
    id: '1',
    name: 'Kalimantan Selatan',
    cities: ['Banjarmasin', 'Banjarbaru', 'Martapura', 'Kandangan'],
    color: 'blue',
  },
  {
    id: '2',
    name: 'Kalimantan Tengah',
    cities: ['Palangkaraya', 'Sampit', 'Pangkalan Bun'],
    color: 'green',
  },
  {
    id: '3',
    name: 'Kalimantan Timur',
    cities: ['Balikpapan', 'Samarinda', 'Bontang', 'Tenggarong'],
    color: 'red',
  },
  {
    id: '4',
    name: 'Kalimantan Barat',
    cities: ['Pontianak', 'Singkawang', 'Mempawah'],
    color: 'yellow',
  },
  {
    id: '5',
    name: 'Kalimantan Utara',
    cities: ['Tarakan', 'Tanjung Selor', 'Malinau'],
    color: 'purple',
  },
];
