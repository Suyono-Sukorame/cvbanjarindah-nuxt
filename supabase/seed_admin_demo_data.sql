BEGIN;

INSERT INTO public.categories (name, slug, description, icon, image_url, sort_order, is_active)
VALUES
  ('Tissue', 'tissue', 'Tissue berkualitas premium dari brand ternama', 'category', 'https://images.unsplash.com/photo-1584556326561-c8746083993b?w=400&h=300&fit=crop', 1, true),
  ('Masker', 'masker', 'Masker terpercaya dengan standar kesehatan internasional', 'masks', 'https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?w=400&h=300&fit=crop', 2, true),
  ('Perlengkapan Bayi', 'perlengkapan-bayi', 'Perlengkapan bayi terlengkap dan terpercaya', 'child_care', 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=400&h=300&fit=crop', 3, true)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  icon = EXCLUDED.icon,
  image_url = EXCLUDED.image_url,
  sort_order = EXCLUDED.sort_order,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO public.brands (name, slug, logo_url, description, is_featured, sort_order, is_active)
VALUES
  ('Brand A', 'brand-a', 'https://placehold.co/300x120/FF5910/FFFFFF?text=Brand+A', 'Brand demo - ganti dengan brand distributor sebenarnya.', true, 1, true),
  ('Brand B', 'brand-b', 'https://placehold.co/300x120/FF5910/FFFFFF?text=Brand+B', 'Brand demo - ganti dengan brand distributor sebenarnya.', true, 2, true),
  ('Brand C', 'brand-c', 'https://placehold.co/300x120/FF5910/FFFFFF?text=Brand+C', 'Brand demo - ganti dengan brand distributor sebenarnya.', true, 3, true),
  ('Brand D', 'brand-d', 'https://placehold.co/300x120/FF5910/FFFFFF?text=Brand+D', 'Brand demo - ganti dengan brand distributor sebenarnya.', true, 4, true),
  ('Brand E', 'brand-e', 'https://placehold.co/300x120/FF5910/FFFFFF?text=Brand+E', 'Brand demo - ganti dengan brand distributor sebenarnya.', true, 5, true),
  ('Brand F', 'brand-f', 'https://placehold.co/300x120/FF5910/FFFFFF?text=Brand+F', 'Brand demo - ganti dengan brand distributor sebenarnya.', true, 6, true)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  logo_url = EXCLUDED.logo_url,
  description = EXCLUDED.description,
  is_featured = EXCLUDED.is_featured,
  sort_order = EXCLUDED.sort_order,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO public.products (name, slug, description, category_id, price, stock, image_url, is_featured, status)
VALUES
  ('Paseo Tissue Premium', 'paseo-tissue-premium', 'Tissue premium 2 ply lembut dan tebal', (SELECT id FROM public.categories WHERE slug = 'tissue'), NULL, 0, 'https://images.unsplash.com/photo-1584556326561-c8746083993b?w=400&h=300&fit=crop', true, 'active'),
  ('Nice Tissue Jumbo', 'nice-tissue-jumbo', 'Tissue jumbo ekonomis untuk keluarga', (SELECT id FROM public.categories WHERE slug = 'tissue'), NULL, 0, 'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=400&h=300&fit=crop', false, 'active'),
  ('Jolly Facial Tissue', 'jolly-facial-tissue', 'Tissue wajah yang lembut dan higienis', (SELECT id FROM public.categories WHERE slug = 'tissue'), NULL, 0, 'https://images.unsplash.com/photo-1563291074-2bf8677ac0e5?w=400&h=300&fit=crop', false, 'active'),
  ('Pokana Masker 3 Ply', 'pokana-masker-3-ply', 'Masker medis 3 ply dengan filter berkualitas', (SELECT id FROM public.categories WHERE slug = 'masker'), NULL, 0, 'https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?w=400&h=300&fit=crop', true, 'active'),
  ('Sensi Masker Surgical', 'sensi-masker-surgical', 'Masker bedah dengan earloop elastis nyaman', (SELECT id FROM public.categories WHERE slug = 'masker'), NULL, 0, 'https://images.unsplash.com/photo-1584634731339-252c581abfc5?w=400&h=300&fit=crop', false, 'active'),
  ('Sensi Masker N95', 'sensi-masker-n95', 'Masker N95 proteksi maksimal', (SELECT id FROM public.categories WHERE slug = 'masker'), NULL, 0, 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=400&h=300&fit=crop', false, 'active'),
  ('MamyPoko Pants', 'mamypoko-pants', 'Popok celana bayi extra soft dan breathable', (SELECT id FROM public.categories WHERE slug = 'perlengkapan-bayi'), NULL, 0, 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=400&h=300&fit=crop', true, 'active'),
  ('Sweety Silver', 'sweety-silver', 'Popok premium dengan technology terbaru', (SELECT id FROM public.categories WHERE slug = 'perlengkapan-bayi'), NULL, 0, 'https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400&h=300&fit=crop', false, 'active'),
  ('Cussons Baby Care', 'cussons-baby-care', 'Rangkaian perawatan bayi lengkap', (SELECT id FROM public.categories WHERE slug = 'perlengkapan-bayi'), NULL, 0, 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=400&h=300&fit=crop', false, 'active')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  category_id = EXCLUDED.category_id,
  image_url = EXCLUDED.image_url,
  is_featured = EXCLUDED.is_featured,
  status = EXCLUDED.status,
  updated_at = NOW();

WITH demo_areas(name, province, city, description, coverage_type) AS (
  VALUES
    ('Banjarmasin', 'Kalimantan Selatan', 'Banjarmasin', 'Cakupan distribusi demo', 'city'),
    ('Banjarbaru', 'Kalimantan Selatan', 'Banjarbaru', 'Cakupan distribusi demo', 'city'),
    ('Martapura', 'Kalimantan Selatan', 'Martapura', 'Cakupan distribusi demo', 'city'),
    ('Kandangan', 'Kalimantan Selatan', 'Kandangan', 'Cakupan distribusi demo', 'city'),
    ('Palangkaraya', 'Kalimantan Tengah', 'Palangkaraya', 'Cakupan distribusi demo', 'city'),
    ('Sampit', 'Kalimantan Tengah', 'Sampit', 'Cakupan distribusi demo', 'city'),
    ('Pangkalan Bun', 'Kalimantan Tengah', 'Pangkalan Bun', 'Cakupan distribusi demo', 'city'),
    ('Balikpapan', 'Kalimantan Timur', 'Balikpapan', 'Cakupan distribusi demo', 'city'),
    ('Samarinda', 'Kalimantan Timur', 'Samarinda', 'Cakupan distribusi demo', 'city'),
    ('Bontang', 'Kalimantan Timur', 'Bontang', 'Cakupan distribusi demo', 'city'),
    ('Tenggarong', 'Kalimantan Timur', 'Tenggarong', 'Cakupan distribusi demo', 'city'),
    ('Pontianak', 'Kalimantan Barat', 'Pontianak', 'Cakupan distribusi demo', 'city'),
    ('Singkawang', 'Kalimantan Barat', 'Singkawang', 'Cakupan distribusi demo', 'city'),
    ('Mempawah', 'Kalimantan Barat', 'Mempawah', 'Cakupan distribusi demo', 'city'),
    ('Tarakan', 'Kalimantan Utara', 'Tarakan', 'Cakupan distribusi demo', 'city'),
    ('Tanjung Selor', 'Kalimantan Utara', 'Tanjung Selor', 'Cakupan distribusi demo', 'city'),
    ('Malinau', 'Kalimantan Utara', 'Malinau', 'Cakupan distribusi demo', 'city')
)
INSERT INTO public.distribution_areas (name, province, city, description, coverage_type, is_active)
SELECT demo.name, demo.province, demo.city, demo.description, demo.coverage_type, true
FROM demo_areas AS demo
WHERE NOT EXISTS (
  SELECT 1
  FROM public.distribution_areas AS existing
  WHERE existing.province = demo.province
    AND existing.city = demo.city
);

INSERT INTO public.testimonials (customer_name, customer_company, customer_avatar, rating, testimonial, is_featured, is_active)
SELECT demo.customer_name, demo.customer_company, demo.customer_avatar, demo.rating, demo.testimonial, demo.is_featured, true
FROM (VALUES
  ('Toko Jaya Makmur', 'Toko Jaya Makmur', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop', 5, 'Sudah 5 tahun bermitra dengan CV Banjar Indah. Stok selalu tersedia dan pengiriman tepat waktu. Sangat membantu bisnis kami!', true),
  ('UD Sumber Rezeki', 'UD Sumber Rezeki', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop', 5, 'Harga kompetitif dan pelayanan ramah. Tim sales selalu responsif membantu kebutuhan stok toko kami.', true),
  ('Toko Berkah Jaya', 'Toko Berkah Jaya', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop', 5, 'Partner distributor terbaik! Produk berkualitas dan sistem pembayaran fleksibel. Highly recommended!', true)
) AS demo(customer_name, customer_company, customer_avatar, rating, testimonial, is_featured)
WHERE NOT EXISTS (
  SELECT 1 FROM public.testimonials AS existing
  WHERE existing.customer_name = demo.customer_name
    AND existing.testimonial = demo.testimonial
);

INSERT INTO public.pricing_plans (name, slug, description, price, features, min_order, discount_percentage, is_popular, is_active, sort_order)
VALUES
  ('Starter', 'starter', 'Untuk toko retail pemula', NULL, '["Minimal order: 50 unit", "Harga grosir tier 1", "Pengiriman reguler", "Support via email", "Pembayaran COD/Transfer"]'::jsonb, 50, 0, false, true, 1),
  ('Business', 'business', 'Untuk toko retail established', NULL, '["Minimal order: 100 unit", "Harga grosir tier 2 (lebih murah)", "Pengiriman prioritas", "Dedicated account manager", "Pembayaran tempo 7 hari", "Bonus produk promosi"]'::jsonb, 100, 0, true, true, 2),
  ('Enterprise', 'enterprise', 'Untuk chain store & reseller', NULL, '["Minimal order: 500 unit", "Harga grosir tier 3 (termurah)", "Pengiriman express", "Priority support 24/7", "Pembayaran tempo 14-30 hari", "Custom packaging & branding", "Free marketing materials"]'::jsonb, 500, 0, false, true, 3)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  features = EXCLUDED.features,
  min_order = EXCLUDED.min_order,
  discount_percentage = EXCLUDED.discount_percentage,
  is_popular = EXCLUDED.is_popular,
  is_active = EXCLUDED.is_active,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

COMMIT;

SELECT
  (SELECT COUNT(*) FROM public.categories) AS categories,
  (SELECT COUNT(*) FROM public.products) AS products,
  (SELECT COUNT(*) FROM public.brands) AS brands,
  (SELECT COUNT(*) FROM public.distribution_areas) AS distribution_areas,
  (SELECT COUNT(*) FROM public.testimonials) AS testimonials,
  (SELECT COUNT(*) FROM public.pricing_plans) AS pricing_plans;
