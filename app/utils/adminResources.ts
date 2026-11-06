export interface AdminField {
  key: string;
  label: string;
  type?: 'text' | 'url' | 'email' | 'number' | 'textarea' | 'boolean' | 'select' | 'list' | 'image';
  required?: boolean;
  options?: Array<{ label: string; value: string }>;
  bucket?: string;
}

export interface AdminResource {
  label: string;
  table: string;
  fields: AdminField[];
  searchable: string[];
  allowCreate?: boolean;
  allowDelete?: boolean;
}

const activeOptions = [
  { label: 'Aktif', value: 'true' },
  { label: 'Nonaktif', value: 'false' },
];

export const adminResources: Record<string, AdminResource> = {
  products: {
    label: 'Produk', table: 'products', searchable: ['name', 'slug'],
    fields: [
      { key: 'name', label: 'Nama produk', required: true },
      { key: 'slug', label: 'Slug', required: true },
      { key: 'description', label: 'Deskripsi', type: 'textarea' },
      { key: 'category_id', label: 'ID kategori' }, { key: 'brand_id', label: 'ID brand' },
      { key: 'price', label: 'Harga', type: 'number' }, { key: 'stock', label: 'Stok', type: 'number' },
      { key: 'image_url', label: 'Gambar produk', type: 'image', bucket: 'products' },
      { key: 'is_featured', label: 'Produk unggulan', type: 'boolean' },
      { key: 'status', label: 'Status', type: 'select', options: [
        { label: 'Aktif', value: 'active' }, { label: 'Nonaktif', value: 'inactive' }, { label: 'Draft', value: 'draft' },
      ] },
    ],
  },
  categories: {
    label: 'Kategori', table: 'categories', searchable: ['name', 'slug'],
    fields: [
      { key: 'name', label: 'Nama kategori', required: true }, { key: 'slug', label: 'Slug', required: true },
      { key: 'description', label: 'Deskripsi', type: 'textarea' }, { key: 'icon', label: 'Ikon Material' },
      { key: 'image_url', label: 'Gambar kategori', type: 'image', bucket: 'categories' }, { key: 'sort_order', label: 'Urutan', type: 'number' },
      { key: 'is_active', label: 'Aktif', type: 'boolean' },
    ],
  },
  brands: {
    label: 'Brand', table: 'brands', searchable: ['name', 'slug'],
    fields: [
      { key: 'name', label: 'Nama brand', required: true }, { key: 'slug', label: 'Slug', required: true },
      { key: 'logo_url', label: 'Logo brand', type: 'image', bucket: 'brands', required: true },
      { key: 'website_url', label: 'Website', type: 'url' }, { key: 'description', label: 'Deskripsi', type: 'textarea' },
      { key: 'is_featured', label: 'Brand unggulan', type: 'boolean' }, { key: 'sort_order', label: 'Urutan', type: 'number' },
      { key: 'is_active', label: 'Aktif', type: 'boolean' },
    ],
  },
  areas: {
    label: 'Area distribusi', table: 'distribution_areas', searchable: ['name', 'province', 'city'],
    fields: [
      { key: 'name', label: 'Nama area', required: true }, { key: 'province', label: 'Provinsi', required: true },
      { key: 'city', label: 'Kota' }, { key: 'description', label: 'Deskripsi', type: 'textarea' },
      { key: 'coverage_type', label: 'Tipe cakupan', type: 'select', options: [
        { label: 'Kota', value: 'city' }, { label: 'Provinsi', value: 'province' }, { label: 'Wilayah', value: 'region' },
      ] },
      { key: 'is_active', label: 'Aktif', type: 'boolean' },
    ],
  },
  inquiries: {
    label: 'Pesan masuk', table: 'inquiries', searchable: ['name', 'email', 'company'],
    allowCreate: false, allowDelete: false,
    fields: [
      { key: 'name', label: 'Nama', required: true }, { key: 'email', label: 'Email', type: 'email', required: true },
      { key: 'phone', label: 'Telepon' }, { key: 'company', label: 'Perusahaan' },
      { key: 'message', label: 'Pesan', type: 'textarea', required: true },
      { key: 'status', label: 'Status', type: 'select', options: [
        { label: 'Baru', value: 'new' }, { label: 'Dihubungi', value: 'contacted' },
        { label: 'Dikonversi', value: 'converted' }, { label: 'Diarsipkan', value: 'archived' },
      ] },
    ],
  },
  testimonials: {
    label: 'Testimoni', table: 'testimonials', searchable: ['customer_name', 'customer_company'],
    fields: [
      { key: 'customer_name', label: 'Nama pelanggan', required: true }, { key: 'customer_company', label: 'Perusahaan' },
      { key: 'customer_avatar', label: 'Foto pelanggan', type: 'image', bucket: 'testimonials' }, { key: 'rating', label: 'Rating (1-5)', type: 'number', required: true },
      { key: 'testimonial', label: 'Testimoni', type: 'textarea', required: true },
      { key: 'is_featured', label: 'Unggulan', type: 'boolean' }, { key: 'is_active', label: 'Aktif', type: 'boolean' },
    ],
  },
  pricing: {
    label: 'Paket harga', table: 'pricing_plans', searchable: ['name', 'slug'],
    fields: [
      { key: 'name', label: 'Nama paket', required: true }, { key: 'slug', label: 'Slug', required: true },
      { key: 'description', label: 'Deskripsi', type: 'textarea' }, { key: 'price', label: 'Harga', type: 'number' },
      { key: 'features', label: 'Fitur (satu per baris)', type: 'list' }, { key: 'min_order', label: 'Minimum order', type: 'number' },
      { key: 'discount_percentage', label: 'Diskon (%)', type: 'number' },
      { key: 'is_popular', label: 'Paket populer', type: 'boolean' },
      { key: 'is_active', label: 'Aktif', type: 'boolean' }, { key: 'sort_order', label: 'Urutan', type: 'number' },
    ],
  },
};

export const adminNavigation = [
  { label: 'Ringkasan', to: '/admin', icon: 'space_dashboard' },
  { label: 'Produk', to: '/admin/products', icon: 'inventory_2' },
  { label: 'Kategori', to: '/admin/categories', icon: 'category' },
  { label: 'Brand', to: '/admin/brands', icon: 'business' },
  { label: 'Area distribusi', to: '/admin/areas', icon: 'location_on' },
  { label: 'Pesan masuk', to: '/admin/inquiries', icon: 'mail' },
  { label: 'Testimoni', to: '/admin/testimonials', icon: 'reviews' },
  { label: 'Paket harga', to: '/admin/pricing', icon: 'payments' },
];

export { activeOptions };