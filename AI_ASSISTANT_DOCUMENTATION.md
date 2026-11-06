# 🤖 AI Assistant Documentation

## Overview
AI Chat Assistant dengan **OPSI 1B: Industry Standard (420px)** - Modern live chat pattern dengan WhatsApp handoff terintegrasi.

---

## 🎯 **Design Pattern: Intercom Style**

### **Desktop (≥ 768px):**
```
Width: 420px (fixed)
Height: 680px (max 85vh)
Position: Fixed bottom-right (bottom-4 right-4)
Animation: Fade + slide up
```

### **Mobile (< 768px):**
```
Width: 95vw (centered with backdrop)
Height: 85vh
Position: Centered bottom
Backdrop: Blur + dim (black/40)
Animation: Slide up from bottom
```

---

## 📊 **Component Architecture**

### **NEW Components Created (10):**

#### **Atoms (3):**
1. ✅ **Avatar.vue** - Profile pictures dengan initials fallback
2. ✅ **ChatInput.vue** - Input field dengan send button
3. ✅ **ChatBubble.vue** - Message bubble (user/AI variants)

#### **Molecules (3):**
4. ✅ **ChatHeader.vue** - Header dengan status & close button
5. ✅ **QuickReply.vue** - Saran balasan cepat
6. ✅ **ChatMessage.vue** - Complete message dengan avatar & timestamp

#### **Organisms (2):**
7. ✅ **ChatWindow.vue** - Main chat interface
8. ✅ **WhatsAppHandoff.vue** - WhatsApp CTA section

#### **Main Component (1):**
9. ✅ **AIAssistant.vue** - Wrapper dengan button & transitions

#### **Deleted:**
- ❌ FloatingWhatsApp.vue (integrated into AI chat)

---

## 🎨 **Visual Specifications**

### **Chat Button:**
```typescript
Size: 56px × 56px (touch-friendly)
Shape: Rounded full
Colors:
  - Closed: bg-primary (orange)
  - Open: bg-slate-900 (dark)
Effects:
  - Pulse ring animation (when closed)
  - Notification badge (unread count)
  - Rotate icon on open
Position:
  - Mobile: bottom-24 right-4 (above BottomNav)
  - Desktop: bottom-4 right-4
```

### **Chat Window Sections:**
```
┌──────────────────────┐
│  HEADER (Sticky)     │ 60px
├──────────────────────┤
│                      │
│  MESSAGES (Scroll)   │ Flex-1
│                      │
├──────────────────────┤
│  WHATSAPP CTA        │ Auto (conditional)
├──────────────────────┤
│  INPUT (Sticky)      │ 72px
└──────────────────────┘
```

### **Color Palette:**
```css
/* Bubbles */
User: bg-primary (orange) + text-white
AI: bg-white + border-slate-200 + text-slate-900

/* Header */
Background: bg-slate-900
Status dot: bg-green-500 (animated pulse)

/* WhatsApp */
Background: gradient from-green-50 to-emerald-50
Button: bg-green-500 hover:bg-green-600
```

---

## ⚙️ **Features**

### **1. Smart Responses:**
Keyword-based AI responses:
- "produk" / "stok" → Product info + WhatsApp CTA
- "harga" / "grosir" → Pricing tiers + WhatsApp CTA
- "area" / "distribusi" → Coverage info + WhatsApp CTA
- Default → General info + WhatsApp CTA

### **2. Quick Replies:**
Pre-defined shortcuts yang muncul di awal chat:
- 🛍️ Lihat Produk
- 💰 Harga Grosir
- 📍 Area Distribusi

### **3. WhatsApp Handoff:**
- Muncul conditional (setelah AI response)
- Pre-filled message dengan context
- Smooth transition dari AI → Human

### **4. UX Details:**
- ✅ Typing indicator (3 dots animation)
- ✅ Message timestamps
- ✅ Avatar untuk AI messages
- ✅ Auto-scroll to bottom
- ✅ Smooth animations (fade, slide, bounce)
- ✅ Notification badge (unread count)

---

## 📱 **Responsive Behavior**

### **Breakpoints:**

#### **Mobile Small** (< 428px):
```typescript
Button: 56px, bottom-24 right-4
Chat: 95vw × 85vh, centered
Backdrop: Full screen blur
Body scroll: Locked when open
```

#### **Mobile Large / Tablet** (428px - 767px):
```typescript
Same as mobile small
```

#### **Desktop** (≥ 768px):
```typescript
Button: 56px, bottom-4 right-4
Chat: 420px × 680px (max 85vh), fixed bottom-right
No backdrop
Body scroll: Not locked
```

### **Safe Areas:**
- iOS notch support
- Android gesture navigation
- Bottom padding untuk BottomNav (mobile)

---

## 🔧 **Component API**

### **AIAssistant.vue** (Main)
```vue
No props - Self-contained

State:
- isOpen: boolean
- unreadCount: number

Methods:
- toggleChat()
- closeChat()
- minimizeChat()

Emits: None
```

### **ChatWindow.vue**
```vue
Props:
- title?: string (default: 'Asisten Indah')
- status?: string (default: 'Online')

Emits:
- @close
- @minimize

Features:
- Auto-scroll messages
- Keyword-based responses
- Conditional WhatsApp handoff
- Quick replies
```

### **ChatMessage.vue**
```vue
Props:
- message: { role, text, timestamp }
- avatarInitials?: string
- isLastInGroup?: boolean

Features:
- Avatar for AI messages
- Timestamp formatting
- Bubble positioning
```

### **WhatsAppHandoff.vue**
```vue
Props:
- phoneNumber?: string (default: '62')
- message?: string (auto-generated from context)

Features:
- Pre-filled WhatsApp message
- Gradient background
- Response time indicator
```

### **QuickReply.vue**
```vue
Props:
- replies: QuickReply[]

Emits:
- @select (reply)

Features:
- Pill-shaped buttons
- Icon support
- Hover effects
```

---

## 💬 **Message Flow**

### **Example Conversation:**
```
1. User opens chat
   → Welcome message + Quick replies

2. User clicks "Harga Grosir"
   → AI explains pricing tiers
   → WhatsApp CTA appears

3. User types custom question
   → AI responds with relevant info
   → WhatsApp CTA appears (if applicable)

4. User clicks "Chat via WhatsApp"
   → Opens WhatsApp with pre-filled message
```

### **AI Response Logic:**
```typescript
Keywords → Response Template → WhatsApp CTA

"produk" → Product categories → Show CTA
"harga" → Pricing packages → Show CTA
"area" → Coverage info → Show CTA
default → General help → Show CTA
```

---

## 🎭 **Animations**

### **Chat Window:**
```css
/* Desktop */
Enter: fade-in + slide-up + scale(0.95 → 1)
Exit: fade-out + slide-down + scale(1 → 0.95)
Duration: 0.3s cubic-bezier

/* Mobile */
Enter: fade-in + slide-up from bottom
Exit: fade-out + slide-down
Duration: 0.3s
```

### **Button:**
```css
Default: scale(1)
Hover: scale(1.1)
Active: scale(0.95)
Icon: rotate(0 → 90deg) when open

Pulse ring: animate-ping (always when closed)
```

### **Messages:**
```css
Each message: fade-in + zoom-in-95
Typing indicator: bounce animation (3 dots)
Quick replies: Active scale(0.95)
```

---

## 📊 **Performance**

### **Optimizations:**
- ✅ No external libraries (pure Vue + Tailwind)
- ✅ Lazy-loaded components (auto-import)
- ✅ CSS transforms (GPU-accelerated)
- ✅ Conditional rendering (v-if for chat window)
- ✅ Debounced scroll handlers

### **Bundle Impact:**
```
Atoms: ~1.5 KB
Molecules: ~3 KB
Organisms: ~5 KB
Total: ~9.5 KB (gzipped)
```

---

## 🔄 **State Management**

### **Current Implementation:**
- Local component state (ref)
- No Vuex/Pinia needed
- localStorage for future: message history

### **Future Enhancement:**
```typescript
// Message persistence
localStorage.setItem('chat_messages', JSON.stringify(messages))

// Unread count across sessions
localStorage.setItem('chat_unread', unreadCount)

// User preferences
localStorage.setItem('chat_preferences', { minimized, muted })
```

---

## 🚀 **Integration Guide**

### **Add to Any Page:**
```vue
<!-- In app/layouts/default.vue -->
<template>
  <div>
    <!-- ... other components -->
    <AIAssistant />
  </div>
</template>
```

### **Customize WhatsApp Number:**
```vue
<!-- In WhatsAppHandoff.vue -->
<OrganismsWhatsAppHandoff
  phone-number="6281234567890"
  :message="customMessage"
/>
```

### **Add Custom Quick Replies:**
```typescript
// In ChatWindow.vue
const quickReplies = ref([
  { id: '1', text: 'Custom Action', icon: '✨', value: 'custom' },
  // ... more
])
```

---

## 🎯 **Best Practices**

### **DO:**
- ✅ Keep responses concise (< 100 words)
- ✅ Show WhatsApp CTA after 2-3 exchanges
- ✅ Use emojis sparingly (1-2 per message)
- ✅ Format with **bold** for emphasis
- ✅ Test on real devices (iOS/Android)

### **DON'T:**
- ❌ Block entire screen on desktop
- ❌ Auto-open chat on page load
- ❌ Play sounds without user permission
- ❌ Show WhatsApp on every message
- ❌ Make button too small (< 48px)

---

## 🐛 **Troubleshooting**

### **Chat not opening:**
```bash
# Check z-index conflicts
.chat-button { z-index: 50 }
.chat-window { z-index: 50 }

# Verify v-if binding
isOpen.value is reactive
```

### **Mobile scroll issues:**
```typescript
// Body scroll lock
watch(isOpen, (val) => {
  document.body.style.overflow = val ? 'hidden' : ''
})
```

### **Messages not scrolling:**
```typescript
// Ensure messagesEndRef is in DOM
<div ref="messagesEndRef"></div>

// Call after nextTick
await nextTick()
scrollToBottom()
```

---

## 📈 **Analytics Events** (Future)

```typescript
// Track user interactions
trackEvent('chat_opened')
trackEvent('message_sent', { keyword })
trackEvent('quick_reply_clicked', { reply })
trackEvent('whatsapp_clicked', { from_ai_chat: true })
```

---

## ✅ **Checklist**

- [x] Button positioning (desktop & mobile)
- [x] Chat window sizing (420px desktop, 95vw mobile)
- [x] Backdrop on mobile
- [x] WhatsApp integration
- [x] Quick replies
- [x] Keyword responses
- [x] Animations & transitions
- [x] Responsive design
- [x] Touch-friendly sizes
- [x] Body scroll lock (mobile)
- [x] Clean component architecture
- [ ] Connect real AI API (future)
- [ ] Message persistence (future)
- [ ] Analytics tracking (future)

---

**Total Components**: 9 new + 1 updated
**Lines of Code**: ~800 lines
**Reusability**: High (atomic design)
**Mobile-First**: Yes

---

Built with ❤️ following industry best practices (Intercom, Drift, Crisp patterns)
