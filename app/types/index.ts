export interface Product {
  id: string;
  name: string;
  description: string;
  category: string;
  price?: number;
  image_url?: string;
  stock?: number;
  created_at?: string;
  updated_at?: string;
}

export interface Customer {
  id: string;
  name: string;
  email: string;
  phone: string;
  company?: string;
  city?: string;
  created_at?: string;
}

export interface Inquiry {
  id: string;
  customer_id?: string;
  product_id?: string;
  name: string;
  email: string;
  phone: string;
  message: string;
  status: 'pending' | 'responded' | 'closed';
  created_at?: string;
  updated_at?: string;
}

export interface AIMessage {
  role: 'user' | 'ai';
  text: string;
  timestamp?: Date;
}
