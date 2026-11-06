CREATE TABLE IF NOT EXISTS public.admin_users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(255),
  avatar_url TEXT,
  role VARCHAR(50) NOT NULL DEFAULT 'admin' CHECK (role IN ('super_admin', 'admin', 'editor')),
  is_active BOOLEAN NOT NULL DEFAULT true,
  last_login_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  icon VARCHAR(50),
  image_url TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.brands (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  logo_url TEXT NOT NULL,
  website_url TEXT,
  description TEXT,
  is_featured BOOLEAN NOT NULL DEFAULT false,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
  brand_id UUID REFERENCES public.brands(id) ON DELETE SET NULL,
  price DECIMAL(10, 2),
  stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
  image_url TEXT,
  is_featured BOOLEAN NOT NULL DEFAULT false,
  status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'draft')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.distribution_areas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  province VARCHAR(100) NOT NULL,
  city VARCHAR(100),
  description TEXT,
  coverage_type VARCHAR(50) NOT NULL DEFAULT 'city' CHECK (coverage_type IN ('city', 'province', 'region')),
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.inquiries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  company VARCHAR(255),
  message TEXT NOT NULL,
  status VARCHAR(50) NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'contacted', 'converted', 'archived')),
  source VARCHAR(50) NOT NULL DEFAULT 'website',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.testimonials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_name VARCHAR(255) NOT NULL,
  customer_company VARCHAR(255),
  customer_avatar TEXT,
  rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
  testimonial TEXT NOT NULL,
  is_featured BOOLEAN NOT NULL DEFAULT false,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.pricing_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  price DECIMAL(10, 2),
  features JSONB NOT NULL DEFAULT '[]'::jsonb,
  min_order INTEGER,
  discount_percentage DECIMAL(5, 2) CHECK (discount_percentage BETWEEN 0 AND 100),
  is_popular BOOLEAN NOT NULL DEFAULT false,
  is_active BOOLEAN NOT NULL DEFAULT true,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_products_category ON public.products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_brand ON public.products(brand_id);
CREATE INDEX IF NOT EXISTS idx_products_status ON public.products(status);
CREATE INDEX IF NOT EXISTS idx_products_featured ON public.products(is_featured);
CREATE INDEX IF NOT EXISTS idx_categories_active ON public.categories(is_active);
CREATE INDEX IF NOT EXISTS idx_brands_active ON public.brands(is_active);
CREATE INDEX IF NOT EXISTS idx_inquiries_status ON public.inquiries(status);
CREATE INDEX IF NOT EXISTS idx_inquiries_created ON public.inquiries(created_at DESC);

CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

DO $$
DECLARE
  table_name TEXT;
BEGIN
  FOREACH table_name IN ARRAY ARRAY[
    'admin_users', 'categories', 'brands', 'products',
    'distribution_areas', 'inquiries', 'testimonials', 'pricing_plans'
  ] LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS set_updated_at ON public.%I', table_name);
    EXECUTE format(
      'CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.%I FOR EACH ROW EXECUTE FUNCTION public.set_updated_at()',
      table_name
    );
  END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION public.is_active_admin()
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.admin_users
    WHERE id = auth.uid() AND is_active = true
  );
$$;

CREATE OR REPLACE FUNCTION public.is_initial_super_admin_available()
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT NOT EXISTS (
    SELECT 1 FROM public.admin_users
    WHERE role = 'super_admin' AND is_active = true
  );
$$;

CREATE OR REPLACE FUNCTION public.claim_initial_super_admin()
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth
AS $$
DECLARE
  current_user_id UUID := auth.uid();
BEGIN
  IF current_user_id IS NULL THEN
    RAISE EXCEPTION 'Login diperlukan untuk mengklaim admin pertama.';
  END IF;

  PERFORM pg_advisory_xact_lock(hashtext('cvbanjarindah_initial_super_admin'));

  IF EXISTS (
    SELECT 1 FROM public.admin_users
    WHERE role = 'super_admin' AND is_active = true
  ) THEN
    RETURN false;
  END IF;

  INSERT INTO public.admin_users (id, email, full_name, role, is_active)
  SELECT id, email, raw_user_meta_data ->> 'full_name', 'super_admin', true
  FROM auth.users
  WHERE id = current_user_id
  ON CONFLICT (id) DO UPDATE
    SET email = EXCLUDED.email,
        full_name = COALESCE(EXCLUDED.full_name, public.admin_users.full_name),
        role = 'super_admin',
        is_active = true,
        updated_at = NOW();

  RETURN true;
END;
$$;

REVOKE ALL ON FUNCTION public.is_active_admin() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_active_admin() TO authenticated;
REVOKE ALL ON FUNCTION public.is_initial_super_admin_available() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_initial_super_admin_available() TO anon, authenticated;
REVOKE ALL ON FUNCTION public.claim_initial_super_admin() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.claim_initial_super_admin() TO authenticated;

ALTER TABLE public.admin_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.distribution_areas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pricing_plans ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Admins can read their own profile" ON public.admin_users;
DROP POLICY IF EXISTS "Active admins manage categories" ON public.categories;
DROP POLICY IF EXISTS "Active admins manage brands" ON public.brands;
DROP POLICY IF EXISTS "Active admins manage products" ON public.products;
DROP POLICY IF EXISTS "Active admins manage distribution areas" ON public.distribution_areas;
DROP POLICY IF EXISTS "Active admins manage inquiries" ON public.inquiries;
DROP POLICY IF EXISTS "Active admins manage testimonials" ON public.testimonials;
DROP POLICY IF EXISTS "Active admins manage pricing plans" ON public.pricing_plans;
DROP POLICY IF EXISTS "Public read active products" ON public.products;
DROP POLICY IF EXISTS "Public read active categories" ON public.categories;
DROP POLICY IF EXISTS "Public read active brands" ON public.brands;
DROP POLICY IF EXISTS "Public read active distribution areas" ON public.distribution_areas;
DROP POLICY IF EXISTS "Public read active testimonials" ON public.testimonials;
DROP POLICY IF EXISTS "Public read active pricing plans" ON public.pricing_plans;
DROP POLICY IF EXISTS "Public submit inquiries" ON public.inquiries;
DROP POLICY IF EXISTS "Public view admin media" ON storage.objects;
DROP POLICY IF EXISTS "Active admins upload media" ON storage.objects;
DROP POLICY IF EXISTS "Active admins update media" ON storage.objects;
DROP POLICY IF EXISTS "Active admins delete media" ON storage.objects;

CREATE POLICY "Admins can read their own profile" ON public.admin_users
  FOR SELECT TO authenticated USING (id = auth.uid());

CREATE POLICY "Active admins manage categories" ON public.categories
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());
CREATE POLICY "Active admins manage brands" ON public.brands
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());
CREATE POLICY "Active admins manage products" ON public.products
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());
CREATE POLICY "Active admins manage distribution areas" ON public.distribution_areas
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());
CREATE POLICY "Active admins manage inquiries" ON public.inquiries
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());
CREATE POLICY "Active admins manage testimonials" ON public.testimonials
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());
CREATE POLICY "Active admins manage pricing plans" ON public.pricing_plans
  FOR ALL TO authenticated USING (public.is_active_admin()) WITH CHECK (public.is_active_admin());

CREATE POLICY "Public read active products" ON public.products
  FOR SELECT TO anon USING (status = 'active');
CREATE POLICY "Public read active categories" ON public.categories
  FOR SELECT TO anon USING (is_active = true);
CREATE POLICY "Public read active brands" ON public.brands
  FOR SELECT TO anon USING (is_active = true);
CREATE POLICY "Public read active distribution areas" ON public.distribution_areas
  FOR SELECT TO anon USING (is_active = true);
CREATE POLICY "Public read active testimonials" ON public.testimonials
  FOR SELECT TO anon USING (is_active = true);
CREATE POLICY "Public read active pricing plans" ON public.pricing_plans
  FOR SELECT TO anon USING (is_active = true);
CREATE POLICY "Public submit inquiries" ON public.inquiries
  FOR INSERT TO anon, authenticated WITH CHECK (true);

INSERT INTO storage.buckets (id, name, public)
VALUES ('products', 'products', true), ('brands', 'brands', true),
  ('categories', 'categories', true), ('testimonials', 'testimonials', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public view admin media" ON storage.objects
  FOR SELECT TO anon, authenticated
  USING (bucket_id IN ('products', 'brands', 'categories', 'testimonials'));
CREATE POLICY "Active admins upload media" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (bucket_id IN ('products', 'brands', 'categories', 'testimonials') AND public.is_active_admin());
CREATE POLICY "Active admins update media" ON storage.objects
  FOR UPDATE TO authenticated
  USING (bucket_id IN ('products', 'brands', 'categories', 'testimonials') AND public.is_active_admin())
  WITH CHECK (bucket_id IN ('products', 'brands', 'categories', 'testimonials') AND public.is_active_admin());
CREATE POLICY "Active admins delete media" ON storage.objects
  FOR DELETE TO authenticated
  USING (bucket_id IN ('products', 'brands', 'categories', 'testimonials') AND public.is_active_admin());

-- After creating an Auth user, grant dashboard access from the SQL Editor:
-- INSERT INTO public.admin_users (id, email, full_name)
-- SELECT id, email, raw_user_meta_data ->> 'full_name' FROM auth.users WHERE email = 'admin@example.com'
-- ON CONFLICT (id) DO UPDATE SET is_active = true;