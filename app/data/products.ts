import type { Product, ProductCategory } from '~/types/product';

export const productCategories: ProductCategory[] = [
  {
    id: 'tissue',
    name: 'Tissue',
    slug: 'tissue',
    description: 'Tissue berkualitas premium dari brand ternama',
    color: 'blue',
  },
  {
    id: 'masker',
    name: 'Masker',
    slug: 'masker',
    description: 'Masker terpercaya dengan standar kesehatan internasional',
    color: 'red',
  },
  {
    id: 'bayi',
    name: 'Perlengkapan Bayi',
    slug: 'bayi',
    description: 'Perlengkapan bayi terlengkap dan terpercaya',
    color: 'pink',
  },
];

export const products: Product[] = [
  {
    id: '1',
    name: 'Paseo Tissue Premium',
    description: 'Tissue premium 2 ply lembut dan tebal',
    category: 'Tissue',
    image: 'https://images.unsplash.com/photo-1584556326561-c8746083993b?w=400&h=300&fit=crop',
    featured: true,
  },
  {
    id: '2',
    name: 'Nice Tissue Jumbo',
    description: 'Tissue jumbo ekonomis untuk keluarga',
    category: 'Tissue',
    image: 'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=400&h=300&fit=crop',
  },
  {
    id: '3',
    name: 'Jolly Facial Tissue',
    description: 'Tissue wajah yang lembut dan higienis',
    category: 'Tissue',
    image: 'https://images.unsplash.com/photo-1563291074-2bf8677ac0e5?w=400&h=300&fit=crop',
  },
  {
    id: '4',
    name: 'Pokana Masker 3 Ply',
    description: 'Masker medis 3 ply dengan filter berkualitas',
    category: 'Masker',
    image: 'https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?w=400&h=300&fit=crop',
    featured: true,
  },
  {
    id: '5',
    name: 'Sensi Masker Surgical',
    description: 'Masker bedah dengan earloop elastis nyaman',
    category: 'Masker',
    image: 'https://images.unsplash.com/photo-1584634731339-252c581abfc5?w=400&h=300&fit=crop',
  },
  {
    id: '6',
    name: 'Sensi Masker N95',
    description: 'Masker N95 proteksi maksimal',
    category: 'Masker',
    image: 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=400&h=300&fit=crop',
  },
  {
    id: '7',
    name: 'MamyPoko Pants',
    description: 'Popok celana bayi extra soft dan breathable',
    category: 'Bayi',
    image: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=400&h=300&fit=crop',
    featured: true,
  },
  {
    id: '8',
    name: 'Sweety Silver',
    description: 'Popok premium dengan technology terbaru',
    category: 'Bayi',
    image: 'https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400&h=300&fit=crop',
  },
  {
    id: '9',
    name: 'Cussons Baby Care',
    description: 'Rangkaian perawatan bayi lengkap',
    category: 'Bayi',
    image: 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=400&h=300&fit=crop',
  },
];
