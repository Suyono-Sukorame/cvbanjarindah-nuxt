# 🏗️ Component Architecture Documentation

## Atomic Design Pattern Implementation

This project follows the **Atomic Design Pattern** for a scalable and maintainable component structure.

---

## 📁 Folder Structure

```
app/
├── components/
│   ├── atoms/           # Smallest building blocks
│   │   ├── Button.vue
│   │   ├── Badge.vue
│   │   ├── Image.vue
│   │   └── Icon.vue
│   │
│   ├── molecules/       # Combination of atoms
│   │   ├── Card.vue
│   │   ├── ProductCard.vue
│   │   ├── CategoryCard.vue
│   │   ├── StatCard.vue
│   │   └── FeatureCard.vue
│   │
│   ├── organisms/       # Complex components
│   │   ├── ProductGrid.vue
│   │   ├── FeatureGrid.vue
│   │   └── StatsSection.vue
│   │
│   ├── sections/        # Page sections
│   │   ├── HeroSection.vue
│   │   └── SectionHeading.vue
│   │
│   └── [existing]/      # Legacy components
│       ├── Navbar.vue
│       ├── Footer.vue
│       ├── BottomNav.vue
│       └── AIAssistant.vue
│
├── data/                # Content management
│   ├── products.ts
│   └── content.ts
│
├── types/               # TypeScript definitions
│   ├── product.ts
│   └── common.ts
│
└── composables/         # Reusable logic
    ├── useDarkMode.ts
    ├── useSupabase.ts
    └── useAIAssistant.ts
```

---

## 🎨 Design System Hierarchy

### 1️⃣ **ATOMS** (Basic UI elements)

Smallest, indivisible components. No business logic.

- **Button.vue** - Reusable button with variants
  - Props: `variant`, `size`, `to`, `disabled`, `loading`
  - Variants: `primary`, `secondary`, `outline`, `ghost`
  - Sizes: `sm`, `md`, `lg`

- **Badge.vue** - Label/tag component
  - Props: `color`
  - Colors: `primary`, `blue`, `green`, `red`, `yellow`, `purple`

- **Image.vue** - Smart image component
  - Props: `src`, `alt`, `rounded`, `aspect`, `overlay`, `hover`, `lazy`
  - Features: Lazy loading, hover effects, overlay support

- **Icon.vue** - Icon wrapper
  - Props: `name`, `type`, `size`
  - Types: `material`, `emoji`

---

### 2️⃣ **MOLECULES** (Combinations of atoms)

Simple components combining atoms with minimal logic.

- **Card.vue** - Base card container
  - Props: `padding`, `hoverable`
  - Used as wrapper for all card types

- **ProductCard.vue** - Product display card
  - Props: `product` (Product interface)
  - Features: Image, badge, description, CTA button

- **CategoryCard.vue** - Product category card
  - Props: `category`, `image`
  - Features: Gradient overlay, category info

- **StatCard.vue** - Statistics display
  - Props: `stat` (Stat interface)
  - Features: Number + label display

- **FeatureCard.vue** - Feature/benefit display
  - Props: `feature` (Feature interface)
  - Features: Icon + title + description

---

### 3️⃣ **ORGANISMS** (Complex components)

Components with business logic and state management.

- **ProductGrid.vue** - Product listing with filters
  - Props: `products`, `categories`, `selectedCategory`
  - Features: Category filtering, grid layout, empty state
  - Emits: `update:selectedCategory`

- **FeatureGrid.vue** - Features grid layout
  - Props: `features`
  - Features: Responsive grid of feature cards

- **StatsSection.vue** - Company stats display
  - Props: `stats`
  - Features: Responsive grid of stat cards

---

### 4️⃣ **SECTIONS** (Page sections)

Page-specific reusable sections.

- **HeroSection.vue** - Hero banner component
  - Props: `title`, `subtitle`, `ctaText`, `ctaLink`, `variant`, `size`
  - Variants: `gradient`, `dark`, `primary`
  - Features: Slots for custom content

- **SectionHeading.vue** - Section title component
  - Props: `title`, `subtitle`, `align`, `size`
  - Features: Consistent section headers

---

## 📊 Data Layer

### Content Management

All content is centralized in `/data` folder:

**products.ts**
```typescript
- productCategories: ProductCategory[]
- products: Product[]
```

**content.ts**
```typescript
- features: Feature[]
- companyStats: Stat[]
- teamMembers: TeamMember[]
- whyChooseUs: Array
- companyValues: Array
```

### Type Definitions

All types in `/types` folder:

**product.ts**
```typescript
- Product
- ProductCategory
```

**common.ts**
```typescript
- Feature
- Stat
- TeamMember
- Area
- ButtonVariant
- ButtonSize
```

---

## 🔄 Component Usage Examples

### Basic Button
```vue
<AtomsButton variant="primary" size="md" to="/kontak">
  Hubungi Kami
</AtomsButton>
```

### Product Card
```vue
<MoleculesProductCard :product="product" />
```

### Product Grid with Filtering
```vue
<OrganismsProductGrid
  :products="filteredProducts"
  :categories="categories"
  v-model:selected-category="selectedCategory"
/>
```

### Hero Section
```vue
<SectionsHeroSection
  title="CV Banjar Indah"
  subtitle="Distributor Terpercaya"
  cta-text="Hubungi Kami"
  cta-link="/kontak"
  variant="gradient"
/>
```

---

## ✅ Benefits of This Architecture

1. **DRY (Don't Repeat Yourself)**
   - Single source of truth untuk setiap component
   - Update sekali, apply everywhere

2. **Scalability**
   - Easy to add new components
   - Clear hierarchy and structure

3. **Maintainability**
   - Easy to find and update components
   - Consistent naming convention

4. **Reusability**
   - Components dapat digunakan di berbagai page
   - Props untuk customization

5. **Type Safety**
   - Full TypeScript support
   - Type definitions untuk semua data

6. **Testability**
   - Each component can be tested independently
   - Clear dependencies

7. **Collaboration**
   - Multiple developers dapat bekerja parallel
   - Clear component ownership

---

## 🚀 Adding New Components

### Step 1: Determine the Level
- **Atom**: Basic UI element? → atoms/
- **Molecule**: Combination of atoms? → molecules/
- **Organism**: Complex with logic? → organisms/
- **Section**: Page section? → sections/

### Step 2: Create Type (if needed)
```typescript
// types/your-type.ts
export interface YourType {
  id: string;
  name: string;
  // ...
}
```

### Step 3: Create Data (if needed)
```typescript
// data/your-data.ts
import type { YourType } from '~/types/your-type';

export const yourData: YourType[] = [
  // ...
];
```

### Step 4: Create Component
```vue
<template>
  <!-- Your template -->
</template>

<script setup lang="ts">
import type { YourType } from '~/types/your-type';

interface Props {
  data: YourType;
}

defineProps<Props>();
</script>
```

### Step 5: Use in Page
```vue
<MoleculesYourComponent :data="yourData" />
```

---

## 📝 Naming Conventions

- **Atoms**: `atoms/ComponentName.vue` → `<AtomsComponentName />`
- **Molecules**: `molecules/ComponentName.vue` → `<MoleculesComponentName />`
- **Organisms**: `organisms/ComponentName.vue` → `<OrganismsComponentName />`
- **Sections**: `sections/ComponentName.vue` → `<SectionsComponentName />`

---

## 🎯 Next Steps for Enhancement

1. **Add Vitest Tests**
   - Unit tests untuk atoms
   - Integration tests untuk organisms

2. **Storybook Integration**
   - Visual component library
   - Interactive documentation

3. **Add More Variants**
   - Expand button variants
   - Add more card types

4. **Performance Optimization**
   - Lazy loading components
   - Virtual scrolling untuk lists

5. **Accessibility**
   - ARIA labels
   - Keyboard navigation
   - Screen reader support

---

## 📚 Resources

- [Atomic Design by Brad Frost](https://atomicdesign.bradfrost.com/)
- [Vue 3 Composition API](https://vuejs.org/guide/extras/composition-api-faq.html)
- [Nuxt 3 Documentation](https://nuxt.com/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

---

**Last Updated**: November 6, 2026
**Version**: 1.0.0
**Maintainer**: Development Team
