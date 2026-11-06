# 📋 Admin Dashboard Implementation Plan

**Project:** CV Banjar Indah - Admin Dashboard CRUD
**Architecture:** Nuxt 3 + Vue 3 Composition API + Supabase + Atomic Design
**Approach:** Component-First Development
**Version:** 1.0.0
**Last Updated:** November 6, 2026

---

## 🎯 Executive Summary

Build a **super simple, modern, user-friendly, fully responsive Admin Dashboard** to manage all website content through CRUD operations. Prioritize **reusable components** and avoid code duplication.

**Design Philosophy:**
- Component-first approach (build small → compose big)
- Leverage existing 40 components
- No library bloat (use what's already there)
- Mobile-first responsive design
- Security-first architecture

---

## 📊 Project Audit

### Current State Analysis

**✅ Existing Components (40 total):**

**Atoms (9):**
- Avatar.vue
- Badge.vue  
- Button.vue ✅ (reusable for admin)
- ChatBubble.vue
- ChatInput.vue
- Counter.vue
- Icon.vue ✅ (reusable for admin)
- Image.vue ✅ (reusable for admin)
- Rating.vue

**Molecules (13):**
- Card.vue ✅ (reusable for admin)
- CategoryCard.vue
- ChatHeader.vue
- ChatMessage.vue
- ClientLogo.vue
- CoverageArea.vue
- FeatureCard.vue
- PricingCard.vue
- ProductCard.vue
- QuickReply.vue
- StatCard.vue ✅ (reusable for admin stats)
- TestimonialCard.vue

**Organisms (13):**
- ChatWindow.vue
- ClientLogosGrid.vue
- CoverageGrid.vue
- FeatureGrid.vue
- LogoMarquee.vue
- PricingGrid.vue
- ProductGrid.vue
- StatsCounter.vue
- StatsSection.vue
- TestimonialsGrid.vue
- WhatsAppHandoff.vue

**Layout Components (5):**
- AIAssistant.vue
- BottomNav.vue
- Footer.vue
- FormattedMessage.vue
- Navbar.vue

**✅ Existing Infrastructure:**
- Supabase integration (`useSupabase.ts`)
- Auth middleware skeleton (`middleware/auth.ts`)
- TypeScript types (`types/`)
- Tailwind CSS configured
- Material Icons loaded

**❌ Missing Components for Admin (24 new needed):**

**Critical Atoms (8):**
1. Input.vue - Text/email/password/number input
2. Textarea.vue - Multi-line text input
3. Select.vue - Dropdown select
4. Checkbox.vue - Checkbox input
5. Toggle.vue - Switch toggle
6. Spinner.vue - Loading indicator
7. Alert.vue - Notification/alert box
8. FileUpload.vue - Image/file upload

**Critical Molecules (9):**
1. FormField.vue - Label + Input + Error wrapper
2. DataTableHeader.vue - Table header with sort
3. DataTableRow.vue - Table row with actions
4. Modal.vue - Dialog/popup
5. ConfirmDialog.vue - Confirmation popup
6. Toast.vue - Toast notification
7. Breadcrumb.vue - Navigation breadcrumb
8. Pagination.vue - Table pagination
9. EmptyState.vue - Empty data placeholder

**Critical Organisms (7):**
1. DataTable.vue - Full-featured table
2. AdminSidebar.vue - Dashboard sidebar navigation
3. AdminHeader.vue - Dashboard header
4. AdminStats.vue - Dashboard stats overview
5. ProductForm.vue - Product CRUD form
6. BrandForm.vue - Brand CRUD form
7. CategoryForm.vue - Category CRUD form

---

## 🗄️ Database Schema (Supabase)

### Tables to Create

```sql
-- 1. products
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
  price DECIMAL(10,2),
  stock INTEGER DEFAULT 0,
  image_url TEXT,
  is_featured BOOLEAN DEFAULT false,
  status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'draft')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. categories
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  icon VARCHAR(50),
  image_url TEXT,
  sort_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. brands (client brands/partners)
CREATE TABLE brands (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  logo_url TEXT NOT NULL,
  website_url TEXT,
  description TEXT,
  is_featured BOOLEAN DEFAULT false,
  sort_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. distribution_areas
CREATE TABLE distribution_areas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  province VARCHAR(100) NOT NULL,
  city VARCHAR(100),
  description TEXT,
  coverage_type VARCHAR(50) DEFAULT 'city' CHECK (coverage_type IN ('city', 'province', 'region')),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. inquiries (customer leads - view only, no CRUD)
CREATE TABLE inquiries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  company VARCHAR(255),
  message TEXT NOT NULL,
  status VARCHAR(50) DEFAULT 'new' CHECK (status IN ('new', 'contacted', 'converted', 'archived')),
  source VARCHAR(50) DEFAULT 'website',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. testimonials
CREATE TABLE testimonials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_name VARCHAR(255) NOT NULL,
  customer_company VARCHAR(255),
  customer_avatar TEXT,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  testimonial TEXT NOT NULL,
  is_featured BOOLEAN DEFAULT false,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. pricing_plans
CREATE TABLE pricing_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  price DECIMAL(10,2),
  features JSONB,
  min_order INTEGER,
  discount_percentage DECIMAL(5,2),
  is_popular BOOLEAN DEFAULT false,
  is_active BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. admin_users (for authentication)
CREATE TABLE admin_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(255),
  avatar_url TEXT,
  role VARCHAR(50) DEFAULT 'admin' CHECK (role IN ('super_admin', 'admin', 'editor')),
  is_active BOOLEAN DEFAULT true,
  last_login_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_products_status ON products(status);
CREATE INDEX idx_products_featured ON products(is_featured);
CREATE INDEX idx_categories_active ON categories(is_active);
CREATE INDEX idx_brands_active ON brands(is_active);
CREATE INDEX idx_inquiries_status ON inquiries(status);
CREATE INDEX idx_inquiries_created ON inquiries(created_at DESC);

-- Row Level Security (RLS) - Enable
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE distribution_areas ENABLE ROW LEVEL SECURITY;
ALTER TABLE inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE pricing_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;

-- RLS Policies (authenticated admin users only)
CREATE POLICY "Admin users can do everything on products"
  ON products FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

CREATE POLICY "Admin users can do everything on categories"
  ON categories FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

CREATE POLICY "Admin users can do everything on brands"
  ON brands FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

CREATE POLICY "Admin users can do everything on distribution_areas"
  ON distribution_areas FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

CREATE POLICY "Admin users can read and update inquiries"
  ON inquiries FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

CREATE POLICY "Admin users can do everything on testimonials"
  ON testimonials FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

CREATE POLICY "Admin users can do everything on pricing_plans"
  ON pricing_plans FOR ALL
  TO authenticated
  USING (auth.uid() IN (SELECT id FROM admin_users WHERE is_active = true));

-- Public read access for frontend
CREATE POLICY "Public can read active products"
  ON products FOR SELECT
  TO anon
  USING (status = 'active');

CREATE POLICY "Public can read active categories"
  ON categories FOR SELECT
  TO anon
  USING (is_active = true);

CREATE POLICY "Public can read active brands"
  ON brands FOR SELECT
  TO anon
  USING (is_active = true);

CREATE POLICY "Public can read active areas"
  ON distribution_areas FOR SELECT
  TO anon
  USING (is_active = true);

CREATE POLICY "Public can read active testimonials"
  ON testimonials FOR SELECT
  TO anon
  USING (is_active = true);

CREATE POLICY "Public can read active pricing"
  ON pricing_plans FOR SELECT
  TO anon
  USING (is_active = true);

CREATE POLICY "Public can insert inquiries"
  ON inquiries FOR INSERT
  TO anon
  WITH CHECK (true);

-- Supabase Storage Buckets
-- Create buckets for file uploads
INSERT INTO storage.buckets (id, name, public) 
VALUES 
  ('products', 'products', true),
  ('brands', 'brands', true),
  ('categories', 'categories', true),
  ('testimonials', 'testimonials', true);

-- Storage policies
CREATE POLICY "Authenticated users can upload products images"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'products');

CREATE POLICY "Public can view products images"
  ON storage.objects FOR SELECT
  TO public
  USING (bucket_id = 'products');

CREATE POLICY "Authenticated users can update products images"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'products');

CREATE POLICY "Authenticated users can delete products images"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'products');
```

---

## 🏗️ Implementation Roadmap

### MILESTONE 1: Project Foundation & Audit ✅ (Already Done)
**Status:** Complete
**Duration:** N/A

**Deliverables:**
- ✅ Project structure audited
- ✅ 40 existing components documented
- ✅ Supabase integration verified
- ✅ TypeScript types in place
- ✅ Tailwind CSS configured

---

### MILESTONE 2: Reusable Admin Components (Atoms)
**Priority:** CRITICAL
**Duration:** 2-3 hours
**Dependencies:** None

#### 2.1 Form Input Atoms

**Files to Create:**

1. **`app/components/atoms/Input.vue`**
```typescript
Props: {
  modelValue: string | number;
  type: 'text' | 'email' | 'password' | 'number' | 'url';
  placeholder?: string;
  disabled?: boolean;
  required?: boolean;
  error?: string;
}
Emits: update:modelValue
```

2. **`app/components/atoms/Textarea.vue`**
```typescript
Props: {
  modelValue: string;
  placeholder?: string;
  rows?: number (default: 4);
  disabled?: boolean;
  required?: boolean;
  error?: string;
}
Emits: update:modelValue
```

3. **`app/components/atoms/Select.vue`**
```typescript
Props: {
  modelValue: string | number;
  options: Array<{ value: string | number; label: string }>;
  placeholder?: string;
  disabled?: boolean;
  required?: boolean;
  error?: string;
}
Emits: update:modelValue
```

4. **`app/components/atoms/Checkbox.vue`**
```typescript
Props: {
  modelValue: boolean;
  label?: string;
  disabled?: boolean;
}
Emits: update:modelValue
```

5. **`app/components/atoms/Toggle.vue`**
```typescript
Props: {
  modelValue: boolean;
  label?: string;
  disabled?: boolean;
}
Emits: update:modelValue
```

#### 2.2 Feedback Atoms

6. **`app/components/atoms/Spinner.vue`**
```typescript
Props: {
  size?: 'sm' | 'md' | 'lg';
  color?: 'primary' | 'white' | 'gray';
}
```

7. **`app/components/atoms/Alert.vue`**
```typescript
Props: {
  type: 'success' | 'error' | 'warning' | 'info';
  message: string;
  dismissible?: boolean;
}
Emits: dismiss
```

8. **`app/components/atoms/FileUpload.vue`**
```typescript
Props: {
  accept?: string (default: 'image/*');
  maxSize?: number (default: 2MB);
  preview?: boolean;
  disabled?: boolean;
}
Emits: upload, error
Features: Preview, drag-drop, validation
```

**Acceptance Criteria:**
- [ ] All 8 atom components created
- [ ] Props/emits TypeScript types defined
- [ ] Tailwind styling consistent with design system (orange primary)
- [ ] Form inputs support v-model
- [ ] Error states displayed
- [ ] Mobile responsive
- [ ] Accessibility (ARIA labels, keyboard navigation)

**Design System:**
- Primary color: `#ff5910` (orange)
- Neutral: Slate gray palette
- Border radius: `rounded-lg` (8px)
- Focus ring: `focus:ring-2 focus:ring-primary/50`
- Input height: `h-10` (40px)

---

### MILESTONE 3: Reusable Admin Components (Molecules)
**Priority:** CRITICAL
**Duration:** 3-4 hours
**Dependencies:** Milestone 2

**Files to Create:**

1. **`app/components/molecules/FormField.vue`**
```typescript
Props: {
  label: string;
  required?: boolean;
  error?: string;
  hint?: string;
}
Slots: default (for input component)
```

2. **`app/components/molecules/DataTableHeader.vue`**
```typescript
Props: {
  columns: Array<{
    key: string;
    label: string;
    sortable?: boolean;
    width?: string;
  }>;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
}
Emits: sort
```

3. **`app/components/molecules/DataTableRow.vue`**
```typescript
Props: {
  columns: Array<{ key: string }>;
  data: Record<string, any>;
  actions?: Array<{
    label: string;
    icon: string;
    onClick: () => void;
    variant?: string;
  }>;
}
```

4. **`app/components/molecules/Modal.vue`**
```typescript
Props: {
  modelValue: boolean;
  title: string;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  persistent?: boolean;
}
Slots: default, footer
Emits: update:modelValue, close
Features: Overlay, close on ESC, trap focus
```

5. **`app/components/molecules/ConfirmDialog.vue`**
```typescript
Props: {
  modelValue: boolean;
  title: string;
  message: string;
  confirmText?: string (default: 'Confirm');
  cancelText?: string (default: 'Cancel');
  type?: 'danger' | 'warning' | 'info';
}
Emits: confirm, cancel, update:modelValue
```

6. **`app/components/molecules/Toast.vue`**
```typescript
Props: {
  message: string;
  type: 'success' | 'error' | 'warning' | 'info';
  duration?: number (default: 3000);
}
Auto-dismiss after duration
```

7. **`app/components/molecules/Breadcrumb.vue`**
```typescript
Props: {
  items: Array<{
    label: string;
    to?: string;
  }>;
}
```

8. **`app/components/molecules/Pagination.vue`**
```typescript
Props: {
  currentPage: number;
  totalPages: number;
  perPage?: number;
  total?: number;
}
Emits: update:currentPage, update:perPage
```

9. **`app/components/molecules/EmptyState.vue`**
```typescript
Props: {
  icon?: string;
  title: string;
  message?: string;
  actionLabel?: string;
  actionTo?: string;
}
Emits: action
```

**Acceptance Criteria:**
- [ ] All 9 molecule components created
- [ ] Compositions use atoms from Milestone 2
- [ ] Modal has backdrop and animation
- [ ] Toast appears at top-right corner
- [ ] Pagination shows page numbers + prev/next
- [ ] EmptyState has centered layout with icon
- [ ] Mobile responsive
- [ ] Keyboard accessible

---

### MILESTONE 4: Admin Layout System
**Priority:** HIGH
**Duration:** 2-3 hours
**Dependencies:** Milestones 2, 3

**Files to Create:**

1. **`app/layouts/admin.vue`**
```vue
<template>
  <div class="admin-layout">
    <OrganismsAdminSidebar />
    <div class="admin-main">
      <OrganismsAdminHeader />
      <main class="admin-content">
        <slot />
      </main>
    </div>
  </div>
</template>
```

2. **`app/components/organisms/AdminSidebar.vue`**
```typescript
Features:
- Logo at top
- Navigation menu with icons
- Active state indication
- Collapsible on mobile
- Logout button at bottom

Menu items:
- Dashboard (home icon)
- Products (shopping_bag icon)
- Categories (category icon)
- Brands (business icon)
- Areas (location_on icon)
- Inquiries (mail icon)
- Testimonials (star icon)
- Pricing (payments icon)
```

3. **`app/components/organisms/AdminHeader.vue`**
```typescript
Features:
- Breadcrumb navigation
- User avatar + name dropdown
- Mobile menu toggle
- Logout action
```

4. **`app/components/organisms/AdminStats.vue`**
```typescript
Props: {
  stats: Array<{
    label: string;
    value: string | number;
    icon: string;
    change?: number;
    trend?: 'up' | 'down';
  }>;
}
Uses: MoleculesStatCard (existing)
```

**Page Routes to Create:**

5. **`app/pages/admin/index.vue`**
- Dashboard overview
- Stats cards (total products, inquiries, etc.)
- Recent inquiries list

6. **`app/pages/admin/login.vue`**
- Simple email + password form
- Supabase Auth integration
- Redirect to /admin after login

**Middleware Enhancement:**

7. **`app/middleware/auth.ts`** (update existing)
```typescript
export default defineNuxtRouteMiddleware(async (to, from) => {
  const { $supabase } = useNuxtApp();
  const { data: { session } } = await $supabase.auth.getSession();
  
  if (to.path.startsWith('/admin') && to.path !== '/admin/login') {
    if (!session) {
      return navigateTo('/admin/login');
    }
  }
  
  if (to.path === '/admin/login' && session) {
    return navigateTo('/admin');
  }
});
```

8. **`app/composables/useAuth.ts`** (create new)
```typescript
export const useAuth = () => {
  const { $supabase } = useNuxtApp();
  const user = ref(null);
  const loading = ref(false);
  
  const login = async (email: string, password: string) => { /* ... */ };
  const logout = async () => { /* ... */ };
  const checkAuth = async () => { /* ... */ };
  
  return { user, loading, login, logout, checkAuth };
};
```

**Acceptance Criteria:**
- [ ] Admin layout with sidebar + header
- [ ] Sidebar navigation functional
- [ ] Header shows user info
- [ ] Login page functional
- [ ] Auth middleware redirects correctly
- [ ] Dashboard shows stats
- [ ] Mobile: sidebar collapses to hamburger menu
- [ ] Logout works

---

### MILESTONE 5: DataTable Organism
**Priority:** CRITICAL
**Duration:** 3-4 hours
**Dependencies:** Milestones 2, 3

**File to Create:**

1. **`app/components/organisms/DataTable.vue`**
```typescript
Props: {
  columns: Array<{
    key: string;
    label: string;
    sortable?: boolean;
    width?: string;
    render?: (value: any, row: any) => string;
  }>;
  data: Array<Record<string, any>>;
  loading?: boolean;
  actions?: Array<{
    label: string;
    icon: string;
    onClick: (row: any) => void;
    variant?: 'primary' | 'danger' | 'ghost';
    show?: (row: any) => boolean;
  }>;
  emptyMessage?: string;
  selectable?: boolean;
  pagination?: {
    currentPage: number;
    totalPages: number;
    perPage: number;
    total: number;
  };
}

Emits: 
  - sort
  - select
  - update:currentPage
  - update:perPage

Features:
- Sortable columns
- Row actions (edit, delete)
- Checkbox selection
- Pagination
- Loading state
- Empty state
- Responsive (horizontal scroll on mobile)
```

**Composable:**

2. **`app/composables/useDataTable.ts`**
```typescript
export const useDataTable = () => {
  const sortBy = ref('');
  const sortOrder = ref<'asc' | 'desc'>('asc');
  const currentPage = ref(1);
  const perPage = ref(10);
  const selectedRows = ref<any[]>([]);
  
  const handleSort = (column: string) => { /* ... */ };
  const handlePageChange = (page: number) => { /* ... */ };
  const handleSelect = (row: any) => { /* ... */ };
  const handleSelectAll = (rows: any[]) => { /* ... */ };
  
  return {
    sortBy,
    sortOrder,
    currentPage,
    perPage,
    selectedRows,
    handleSort,
    handlePageChange,
    handleSelect,
    handleSelectAll,
  };
};
```

**Acceptance Criteria:**
- [ ] DataTable component renders data
- [ ] Column sorting works
- [ ] Pagination functional
- [ ] Row actions (edit/delete) clickable
- [ ] Loading spinner shows when loading
- [ ] Empty state shows when no data
- [ ] Mobile: horizontal scroll enabled
- [ ] Checkbox selection works

---

### MILESTONE 6: CRUD Module - Products
**Priority:** HIGH
**Duration:** 4-5 hours
**Dependencies:** Milestones 2-5

**Files to Create:**

1. **`app/pages/admin/products/index.vue`**
```typescript
Features:
- List all products in DataTable
- Search by name
- Filter by category/brand/status
- Actions: Edit, Delete, Toggle status
- "Add Product" button → navigate to create page
```

2. **`app/pages/admin/products/create.vue`**
```typescript
Features:
- ProductForm component
- Save → insert to Supabase
- Success toast → redirect to list
```

3. **`app/pages/admin/products/[id]/edit.vue`**
```typescript
Features:
- Load product by ID
- ProductForm component with data
- Save → update Supabase
- Success toast → redirect to list
```

4. **`app/components/organisms/ProductForm.vue`**
```typescript
Props: {
  product?: Product; // For edit mode
  mode: 'create' | 'edit';
}

Emits: submit, cancel

Fields:
- Name (Input - required)
- Slug (Input - auto-generated from name)
- Description (Textarea)
- Category (Select - from categories table)
- Brand (Select - from brands table)
- Price (Input number)
- Stock (Input number)
- Image (FileUpload → Supabase Storage)
- Is Featured (Checkbox)
- Status (Select: active/inactive/draft)

Validation:
- Name required
- Slug unique
- Price > 0
- Stock >= 0
```

5. **`app/composables/useProducts.ts`**
```typescript
export const useProducts = () => {
  const { $supabase } = useNuxtApp();
  
  const getProducts = async (filters?: any) => { /* ... */ };
  const getProduct = async (id: string) => { /* ... */ };
  const createProduct = async (data: any) => { /* ... */ };
  const updateProduct = async (id: string, data: any) => { /* ... */ };
  const deleteProduct = async (id: string) => { /* ... */ };
  const uploadProductImage = async (file: File) => { /* ... */ };
  
  return {
    getProducts,
    getProduct,
    createProduct,
    updateProduct,
    deleteProduct,
    uploadProductImage,
  };
};
```

6. **`app/types/admin.ts`** (create new)
```typescript
export interface Product {
  id: string;
  name: string;
  slug: string;
  description?: string;
  category_id?: string;
  brand_id?: string;
  price?: number;
  stock: number;
  image_url?: string;
  is_featured: boolean;
  status: 'active' | 'inactive' | 'draft';
  created_at: string;
  updated_at: string;
}

export interface Category {
  id: string;
  name: string;
  slug: string;
  description?: string;
  icon?: string;
  image_url?: string;
  sort_order: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

// ... other interfaces
```

**Acceptance Criteria:**
- [ ] Products list shows all products in table
- [ ] Search filters products by name
- [ ] Category/brand filter works
- [ ] Create product form validates and saves
- [ ] Edit product loads data and updates
- [ ] Delete product shows confirm dialog
- [ ] Image upload to Supabase Storage works
- [ ] Slug auto-generates from name
- [ ] Success/error toasts show
- [ ] Mobile responsive

---

### MILESTONE 7: CRUD Module - Categories
**Priority:** HIGH
**Duration:** 2-3 hours
**Dependencies:** Milestone 6

**Files to Create:**

1. **`app/pages/admin/categories/index.vue`**
2. **`app/pages/admin/categories/create.vue`**
3. **`app/pages/admin/categories/[id]/edit.vue`**
4. **`app/components/organisms/CategoryForm.vue`**
5. **`app/composables/useCategories.ts`**

**Form Fields:**
- Name (Input - required)
- Slug (Input - auto-generated)
- Description (Textarea)
- Icon (Select from Material Icons list)
- Image (FileUpload)
- Sort Order (Input number)
- Is Active (Toggle)

**Acceptance Criteria:**
- [ ] Categories CRUD functional
- [ ] Icon selector shows Material Icons
- [ ] Sort order affects display order
- [ ] Active toggle works

---

### MILESTONE 8: CRUD Module - Brands
**Priority:** HIGH
**Duration:** 2-3 hours
**Dependencies:** Milestone 6

**Files to Create:**

1. **`app/pages/admin/brands/index.vue`**
2. **`app/pages/admin/brands/create.vue`**
3. **`app/pages/admin/brands/[id]/edit.vue`**
4. **`app/components/organisms/BrandForm.vue`**
5. **`app/composables/useBrands.ts`**

**Form Fields:**
- Name (Input - required)
- Slug (Input - auto-generated)
- Logo (FileUpload - required)
- Website URL (Input URL)
- Description (Textarea)
- Is Featured (Checkbox)
- Sort Order (Input number)
- Is Active (Toggle)

**Acceptance Criteria:**
- [ ] Brands CRUD functional
- [ ] Logo upload validates image type
- [ ] Featured brands shown on homepage
- [ ] Sort order works in LogoMarquee

---

### MILESTONE 9: CRUD Module - Distribution Areas
**Priority:** MEDIUM
**Duration:** 2 hours
**Dependencies:** Milestone 6

**Files to Create:**

1. **`app/pages/admin/areas/index.vue`**
2. **`app/pages/admin/areas/create.vue`**
3. **`app/pages/admin/areas/[id]/edit.vue`**
4. **`app/components/organisms/AreaForm.vue`**
5. **`app/composables/useAreas.ts`**

**Form Fields:**
- Name (Input - required)
- Province (Select - Kalimantan provinces)
- City (Input)
- Description (Textarea)
- Coverage Type (Select: city/province/region)
- Is Active (Toggle)

**Acceptance Criteria:**
- [ ] Areas CRUD functional
- [ ] Province dropdown has 5 Kalimantan provinces
- [ ] Coverage type affects display on /area page

---

### MILESTONE 10: View Module - Inquiries
**Priority:** MEDIUM
**Duration:** 2 hours
**Dependencies:** Milestone 5

**Files to Create:**

1. **`app/pages/admin/inquiries/index.vue`**
```typescript
Features:
- View all inquiries in DataTable (no create/delete)
- Filter by status (new/contacted/converted/archived)
- Update status action
- View details modal
- Mark as read/unread
```

2. **`app/components/organisms/InquiryDetail.vue`**
```typescript
Props: {
  inquiry: Inquiry;
}
Shows: Name, email, phone, company, message, source, date
Actions: Update status, send email (future)
```

3. **`app/composables/useInquiries.ts`**
```typescript
getInquiries(filters)
getInquiry(id)
updateInquiryStatus(id, status)
```

**Acceptance Criteria:**
- [ ] Inquiries list shows all leads
- [ ] Status filter works
- [ ] Detail modal shows full info
- [ ] Update status saves to DB
- [ ] New inquiries highlighted

---

### MILESTONE 11: CRUD Module - Testimonials
**Priority:** LOW
**Duration:** 2 hours
**Dependencies:** Milestone 6

**Files to Create:**

1. **`app/pages/admin/testimonials/index.vue`**
2. **`app/pages/admin/testimonials/create.vue`**
3. **`app/pages/admin/testimonials/[id]/edit.vue`**
4. **`app/components/organisms/TestimonialForm.vue`**
5. **`app/composables/useTestimonials.ts`**

**Form Fields:**
- Customer Name (Input - required)
- Customer Company (Input)
- Customer Avatar (FileUpload)
- Rating (1-5 stars select)
- Testimonial (Textarea - required)
- Is Featured (Checkbox)
- Is Active (Toggle)

**Acceptance Criteria:**
- [ ] Testimonials CRUD functional
- [ ] Rating displayed as stars
- [ ] Featured testimonials on homepage

---

### MILESTONE 12: CRUD Module - Pricing Plans
**Priority:** LOW
**Duration:** 2-3 hours
**Dependencies:** Milestone 6

**Files to Create:**

1. **`app/pages/admin/pricing/index.vue`**
2. **`app/pages/admin/pricing/create.vue`**
3. **`app/pages/admin/pricing/[id]/edit.vue`**
4. **`app/components/organisms/PricingForm.vue`**
5. **`app/composables/usePricing.ts`**

**Form Fields:**
- Name (Input - required)
- Slug (Input - auto-generated)
- Description (Textarea)
- Price (Input number)
- Features (Dynamic list - add/remove)
- Min Order (Input number)
- Discount Percentage (Input number 0-100)
- Is Popular (Checkbox)
- Is Active (Toggle)
- Sort Order (Input number)

**Features Component:**
```vue
<FeaturesList v-model="features" />
<!-- Add/remove feature items dynamically -->
```

**Acceptance Criteria:**
- [ ] Pricing CRUD functional
- [ ] Dynamic features list works
- [ ] Popular badge displayed
- [ ] Frontend shows updated pricing

---

### MILESTONE 13: Integration & Testing
**Priority:** CRITICAL
**Duration:** 3-4 hours
**Dependencies:** All previous milestones

**Tasks:**

1. **Frontend Integration**
   - Update `useSupabase.ts` to use new tables
   - Update frontend pages to fetch from Supabase
   - Replace mock data with real data

2. **File Updates:**
   - `app/pages/index.vue` - Fetch products, brands, testimonials
   - `app/pages/produk.vue` - Fetch products with filters
   - `app/pages/area.vue` - Fetch distribution areas
   - `app/data/content.ts` - Remove hardcoded data or keep as fallback

3. **Image Optimization**
   - Implement Supabase Storage CDN URLs
   - Add image resizing/thumbnails
   - Lazy loading for images

4. **Error Handling**
   - Global error handler
   - Toast notifications for errors
   - Retry logic for failed uploads

5. **Security Audit**
   - Test RLS policies
   - Verify auth middleware
   - Check for SQL injection vulnerabilities
   - Test file upload restrictions

6. **Performance Testing**
   - Test with 100+ products
   - Pagination performance
   - Image load times
   - Query optimization

7. **Responsive Testing**
   - Test all admin pages on mobile (375px)
   - Test on tablet (768px)
   - Test on desktop (1920px)
   - Fix any layout issues

8. **Accessibility Testing**
   - Keyboard navigation works
   - Screen reader friendly
   - Focus states visible
   - ARIA labels present

**Acceptance Criteria:**
- [ ] All frontend pages fetch from Supabase
- [ ] Images load from Supabase Storage
- [ ] Error handling graceful
- [ ] RLS policies prevent unauthorized access
- [ ] Performance acceptable (< 2s page load)
- [ ] Mobile responsive works
- [ ] Keyboard accessible
- [ ] No console errors

---

## 📦 Dependencies & Tools

**No New Libraries Needed:**
- ✅ Nuxt 3 (already installed)
- ✅ Vue 3 (already installed)
- ✅ Supabase JS (already installed)
- ✅ TailwindCSS (already installed)
- ✅ TypeScript (already installed)
- ✅ Material Icons (already loaded)

**Optional Future Enhancements:**
- VueUse (utility composables) - if needed
- Vee-Validate (advanced form validation) - if needed
- Chart.js (dashboard charts) - future

---

## 🔐 Security Considerations

**Authentication:**
- Use Supabase Auth (email/password)
- Session-based authentication
- Auto logout after 24 hours inactivity
- Secure cookie storage

**Authorization:**
- Row Level Security (RLS) in Supabase
- Middleware checks on every admin route
- API route protection (if added later)

**Data Validation:**
- Client-side validation (immediate feedback)
- Server-side validation (RLS + database constraints)
- Sanitize user input
- File upload validation (type, size)

**Storage Security:**
- Bucket policies for public/private files
- Signed URLs for sensitive files
- File size limits (2MB for images)
- Allowed file types: jpg, png, webp

---

## 📱 Responsive Design Breakpoints

**Mobile First Approach:**
- Mobile: 375px - 767px (single column)
- Tablet: 768px - 1023px (sidebar collapsible)
- Desktop: 1024px+ (sidebar always visible)

**Admin Layout:**
- Mobile: hamburger menu, full-width content
- Tablet: collapsible sidebar, content 70%
- Desktop: fixed sidebar 240px, content fills remaining

**DataTable:**
- Mobile: horizontal scroll
- Tablet+: full table visible

**Forms:**
- Mobile: single column
- Desktop: two columns for efficiency

---

## 🎨 Design Tokens

**Colors:**
```css
--color-primary: #ff5910;
--color-primary-dark: #e54e0a;
--color-primary-light: #ff7a3d;

--color-success: #10b981;
--color-error: #ef4444;
--color-warning: #f59e0b;
--color-info: #3b82f6;

--color-gray-50: #f8fafc;
--color-gray-100: #f1f5f9;
--color-gray-200: #e2e8f0;
--color-gray-300: #cbd5e1;
--color-gray-400: #94a3b8;
--color-gray-500: #64748b;
--color-gray-600: #475569;
--color-gray-700: #334155;
--color-gray-800: #1e293b;
--color-gray-900: #0f172a;
```

**Typography:**
```css
--font-family: 'Poppins', sans-serif; (already loaded)
--font-size-xs: 0.75rem;
--font-size-sm: 0.875rem;
--font-size-base: 1rem;
--font-size-lg: 1.125rem;
--font-size-xl: 1.25rem;
--font-size-2xl: 1.5rem;
--font-size-3xl: 1.875rem;
```

**Spacing:**
```css
--spacing-1: 0.25rem;
--spacing-2: 0.5rem;
--spacing-3: 0.75rem;
--spacing-4: 1rem;
--spacing-6: 1.5rem;
--spacing-8: 2rem;
--spacing-12: 3rem;
--spacing-16: 4rem;
```

---

## 📝 File Structure Summary

**New Files (Total: ~60 files)**

```
app/
├── components/
│   ├── atoms/ (8 new)
│   │   ├── Input.vue
│   │   ├── Textarea.vue
│   │   ├── Select.vue
│   │   ├── Checkbox.vue
│   │   ├── Toggle.vue
│   │   ├── Spinner.vue
│   │   ├── Alert.vue
│   │   └── FileUpload.vue
│   │
│   ├── molecules/ (9 new)
│   │   ├── FormField.vue
│   │   ├── DataTableHeader.vue
│   │   ├── DataTableRow.vue
│   │   ├── Modal.vue
│   │   ├── ConfirmDialog.vue
│   │   ├── Toast.vue
│   │   ├── Breadcrumb.vue
│   │   ├── Pagination.vue
│   │   └── EmptyState.vue
│   │
│   └── organisms/ (11 new)
│       ├── DataTable.vue
│       ├── AdminSidebar.vue
│       ├── AdminHeader.vue
│       ├── AdminStats.vue
│       ├── ProductForm.vue
│       ├── CategoryForm.vue
│       ├── BrandForm.vue
│       ├── AreaForm.vue
│       ├── InquiryDetail.vue
│       ├── TestimonialForm.vue
│       └── PricingForm.vue
│
├── layouts/
│   └── admin.vue (1 new)
│
├── pages/
│   └── admin/ (27 new)
│       ├── index.vue (dashboard)
│       ├── login.vue
│       ├── products/
│       │   ├── index.vue
│       │   ├── create.vue
│       │   └── [id]/
│       │       └── edit.vue
│       ├── categories/
│       │   ├── index.vue
│       │   ├── create.vue
│       │   └── [id]/
│       │       └── edit.vue
│       ├── brands/
│       │   ├── index.vue
│       │   ├── create.vue
│       │   └── [id]/
│       │       └── edit.vue
│       ├── areas/
│       │   ├── index.vue
│       │   ├── create.vue
│       │   └── [id]/
│       │       └── edit.vue
│       ├── inquiries/
│       │   └── index.vue
│       ├── testimonials/
│       │   ├── index.vue
│       │   ├── create.vue
│       │   └── [id]/
│       │       └── edit.vue
│       └── pricing/
│           ├── index.vue
│           ├── create.vue
│           └── [id]/
│               └── edit.vue
│
├── composables/ (7 new)
│   ├── useAuth.ts
│   ├── useDataTable.ts
│   ├── useProducts.ts
│   ├── useCategories.ts
│   ├── useBrands.ts
│   ├── useAreas.ts
│   ├── useInquiries.ts
│   ├── useTestimonials.ts
│   └── usePricing.ts
│
├── types/
│   └── admin.ts (1 new - all admin types)
│
└── middleware/
    └── auth.ts (update existing)
```

---

## 🚀 Execution Order (Step-by-Step)

### Phase 1: Foundation (Milestones 1-4)
1. ✅ Audit project (Already done)
2. Create 8 atom components
3. Create 9 molecule components
4. Create admin layout + sidebar + header
5. Create login page + auth logic

**Checkpoint 1:** Login works, admin layout renders

---

### Phase 2: Core Components (Milestone 5)
6. Create DataTable organism
7. Create useDataTable composable

**Checkpoint 2:** DataTable shows mock data

---

### Phase 3: Database Setup
8. Run Supabase SQL schema (create tables)
9. Create storage buckets
10. Test RLS policies

**Checkpoint 3:** Supabase ready, auth configured

---

### Phase 4: CRUD Implementation (Milestones 6-12)
11. Products CRUD (Milestone 6)
12. Categories CRUD (Milestone 7)
13. Brands CRUD (Milestone 8)
14. Areas CRUD (Milestone 9)
15. Inquiries View (Milestone 10)
16. Testimonials CRUD (Milestone 11)
17. Pricing CRUD (Milestone 12)

**Checkpoint 4:** All CRUD modules working

---

### Phase 5: Integration (Milestone 13)
18. Update frontend to fetch from Supabase
19. Test all pages
20. Fix bugs
21. Performance optimization
22. Security audit
23. Responsive testing

**Checkpoint 5:** Production ready

---

## ✅ Acceptance Criteria (Overall)

**Functional Requirements:**
- [ ] Admin can login/logout
- [ ] Admin can CRUD products
- [ ] Admin can CRUD categories
- [ ] Admin can CRUD brands
- [ ] Admin can CRUD areas
- [ ] Admin can view/manage inquiries
- [ ] Admin can CRUD testimonials
- [ ] Admin can CRUD pricing
- [ ] Images upload to Supabase Storage
- [ ] Frontend displays data from Supabase
- [ ] RLS policies prevent unauthorized access

**Non-Functional Requirements:**
- [ ] Mobile responsive (375px+)
- [ ] Desktop optimized (1920px)
- [ ] Page load < 2 seconds
- [ ] Image load lazy
- [ ] Keyboard accessible
- [ ] Screen reader friendly
- [ ] No console errors
- [ ] Code follows Atomic Design
- [ ] TypeScript types complete
- [ ] Components reusable

---

## 📊 Estimated Timeline

**Total Duration:** 25-35 hours

- Milestone 2: 2-3 hours (Atoms)
- Milestone 3: 3-4 hours (Molecules)
- Milestone 4: 2-3 hours (Admin Layout)
- Milestone 5: 3-4 hours (DataTable)
- Milestone 6: 4-5 hours (Products CRUD)
- Milestone 7: 2-3 hours (Categories CRUD)
- Milestone 8: 2-3 hours (Brands CRUD)
- Milestone 9: 2 hours (Areas CRUD)
- Milestone 10: 2 hours (Inquiries View)
- Milestone 11: 2 hours (Testimonials CRUD)
- Milestone 12: 2-3 hours (Pricing CRUD)
- Milestone 13: 3-4 hours (Integration & Testing)

**Recommended Approach:**
- Day 1: Milestones 2-4 (Foundation)
- Day 2: Milestone 5 + 6 (DataTable + Products)
- Day 3: Milestones 7-9 (Categories, Brands, Areas)
- Day 4: Milestones 10-12 (Inquiries, Testimonials, Pricing)
- Day 5: Milestone 13 (Integration, Testing, Polish)

---

## 🎯 Success Metrics

**Post-Launch KPIs:**
- Time to add new product: < 2 minutes
- Page load time: < 2 seconds
- Mobile usability score: > 90
- Zero security vulnerabilities
- Zero breaking bugs in production
- Admin satisfaction: > 8/10

---

## 🔮 Future Enhancements (Out of Scope)

**Phase 2 Features (Later):**
- Bulk import/export (CSV)
- Rich text editor for descriptions
- Image gallery (multiple images per product)
- Product variants (size, color)
- Order management system
- Analytics dashboard (charts)
- Email notifications
- Activity log/audit trail
- Multi-language support
- SEO meta management
- Sitemap auto-generation
- Scheduled publishing
- Draft/preview mode
- Version history
- Role-based access control (super_admin, admin, editor)

---

## 📚 References

**Official Documentation:**
- [Nuxt 3 Docs](https://nuxt.com/)
- [Vue 3 Docs](https://vuejs.org/)
- [Supabase Docs](https://supabase.com/docs)
- [TailwindCSS Docs](https://tailwindcss.com/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

**Design Patterns:**
- [Atomic Design by Brad Frost](https://atomicdesign.bradfrost.com/)
- [Component-Driven Development](https://www.componentdriven.org/)

**Security Best Practices:**
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Supabase RLS Guide](https://supabase.com/docs/guides/auth/row-level-security)

---

## 🤝 Handoff Notes for AI Coding Agent

**Context:**
- This is a Nuxt 3 project with 40 existing components
- Atomic Design pattern already established
- Supabase already configured (just need to create tables)
- TailwindCSS + TypeScript + Material Icons ready
- Primary color: `#ff5910` (orange), use Slate for neutrals

**Key Principles:**
1. **Reuse before create** - Check existing components first
2. **Atomic Design** - Follow atoms → molecules → organisms hierarchy
3. **TypeScript strict** - All props/emits must be typed
4. **Mobile first** - Start with mobile styles, then desktop
5. **Accessibility** - ARIA labels, keyboard nav, semantic HTML
6. **Security** - Never bypass RLS, validate all inputs
7. **Performance** - Lazy load, optimize images, pagination

**Code Style:**
- Use Composition API (`<script setup lang="ts">`)
- Use `const props = defineProps<Props>()` pattern
- Use `defineEmits<Emits>()` for type-safe emits
- Use composables for business logic
- Keep components < 200 lines (split if bigger)
- Use `v-model` for two-way binding
- Use slots for flexible composition

**Testing Before Commit:**
- Test on mobile (375px)
- Test on desktop (1920px)
- Test keyboard navigation
- Test with empty data
- Test with 100+ records
- Check browser console (no errors)

**Supabase Notes:**
- Tables use UUID for primary keys
- Use `gen_random_uuid()` for default ID
- Always enable RLS on new tables
- Test policies before deploying
- Use storage buckets for files (not base64)

**Common Patterns:**
```vue
<!-- Form Field -->
<MoleculesFormField label="Name" required :error="errors.name">
  <AtomsInput v-model="form.name" />
</MoleculesFormField>

<!-- DataTable -->
<OrganismsDataTable
  :columns="columns"
  :data="products"
  :loading="loading"
  :actions="actions"
  @sort="handleSort"
/>

<!-- Modal -->
<MoleculesModal v-model="showModal" title="Delete Product">
  <p>Are you sure?</p>
  <template #footer>
    <AtomsButton @click="confirmDelete">Delete</AtomsButton>
  </template>
</MoleculesModal>
```

**Start Here:**
1. Read COMPONENT_ARCHITECTURE.md first
2. Follow milestone order (2 → 13)
3. Create atoms before molecules
4. Test each component before moving on
5. Commit after each milestone

**Questions?**
- Check existing code patterns in `/app/components`
- Reference Nuxt 3 docs for routing/composables
- Check Supabase docs for RLS examples

---

**Document Version:** 1.0.0
**Status:** Ready for Implementation
**Next Step:** Execute Milestone 2 (Atoms)

