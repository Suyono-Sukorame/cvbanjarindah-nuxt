import { createClient } from '@supabase/supabase-js';

export const useSupabase = () => {
  const config = useRuntimeConfig();

  const supabase = createClient(
    config.public.supabaseEndpoint,
    config.public.supabasePublishableKey
  );

  return {
    supabase,
    
    /**
     * Get all products
     */
    async getProducts() {
      try {
        const { data, error } = await supabase
          .from('products')
          .select('*');
        
        if (error) throw error;
        return data;
      } catch (error) {
        console.error('Error fetching products:', error);
        return [];
      }
    },

    /**
     * Get product by category
     */
    async getProductsByCategory(category: string) {
      try {
        const { data, error } = await supabase
          .from('products')
          .select('*')
          .eq('category', category);
        
        if (error) throw error;
        return data;
      } catch (error) {
        console.error('Error fetching products by category:', error);
        return [];
      }
    },

    /**
     * Create customer inquiry
     */
    async createInquiry(inquiry: {
      name: string;
      email: string;
      phone: string;
      message: string;
    }) {
      try {
        const { data, error } = await supabase
          .from('inquiries')
          .insert([
            {
              name: inquiry.name,
              email: inquiry.email,
              phone: inquiry.phone,
              message: inquiry.message,
              status: 'new',
              created_at: new Date(),
            }
          ]);
        
        if (error) throw error;
        return { success: true, data };
      } catch (error) {
        console.error('Error creating inquiry:', error);
        return { success: false, error };
      }
    },

    /**
     * Get all inquiries (admin only)
     */
    async getInquiries() {
      try {
        const { data, error } = await supabase
          .from('inquiries')
          .select('*')
          .order('created_at', { ascending: false });
        
        if (error) throw error;
        return data;
      } catch (error) {
        console.error('Error fetching inquiries:', error);
        return [];
      }
    },

    /**
     * Subscribe to real-time changes
     */
    subscribeToProducts(callback: (payload: any) => void) {
      return supabase
        .on(
          'postgres_changes',
          { event: '*', schema: 'public', table: 'products' },
          (payload) => callback(payload)
        )
        .subscribe();
    },
  };
};
