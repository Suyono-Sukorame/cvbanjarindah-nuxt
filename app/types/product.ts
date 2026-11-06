export interface Product {
  id: string;
  name: string;
  description: string;
  category: 'Tissue' | 'Masker' | 'Bayi';
  image: string;
  featured?: boolean;
}

export interface ProductCategory {
  id: string;
  name: string;
  slug: string;
  description: string;
  icon?: string;
  color?: string;
}
