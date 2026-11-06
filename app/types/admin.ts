export type AdminRole = 'super_admin' | 'admin' | 'editor';
export type ProductStatus = 'active' | 'inactive' | 'draft';
export type InquiryStatus = 'new' | 'contacted' | 'converted' | 'archived';

export interface AdminRecord {
  id: string;
  created_at?: string;
  updated_at?: string;
  [key: string]: unknown;
}

export interface Product extends AdminRecord {
  name: string;
  slug: string;
  description?: string | null;
  category_id?: string | null;
  brand_id?: string | null;
  price?: number | null;
  stock: number;
  image_url?: string | null;
  is_featured: boolean;
  status: ProductStatus;
}

export interface Category extends AdminRecord {
  name: string;
  slug: string;
  description?: string | null;
  icon?: string | null;
  image_url?: string | null;
  sort_order: number;
  is_active: boolean;
}

export interface Brand extends AdminRecord {
  name: string;
  slug: string;
  logo_url: string;
  website_url?: string | null;
  description?: string | null;
  is_featured: boolean;
  sort_order: number;
  is_active: boolean;
}

export interface DistributionArea extends AdminRecord {
  name: string;
  province: string;
  city?: string | null;
  description?: string | null;
  coverage_type: 'city' | 'province' | 'region';
  is_active: boolean;
}

export interface Inquiry extends AdminRecord {
  name: string;
  email: string;
  phone?: string | null;
  company?: string | null;
  message: string;
  status: InquiryStatus;
  source?: string | null;
}

export interface Testimonial extends AdminRecord {
  customer_name: string;
  customer_company?: string | null;
  customer_avatar?: string | null;
  rating: number;
  testimonial: string;
  is_featured: boolean;
  is_active: boolean;
}

export interface PricingPlan extends AdminRecord {
  name: string;
  slug: string;
  description?: string | null;
  price?: number | null;
  features: string[];
  min_order?: number | null;
  discount_percentage?: number | null;
  is_popular: boolean;
  is_active: boolean;
  sort_order: number;
}