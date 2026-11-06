<template>
  <div class="space-y-3">
    <div v-if="modelValue" class="flex items-center gap-3 rounded-lg border border-slate-200 bg-slate-50 p-3">
      <img :src="modelValue" alt="Pratinjau gambar" class="h-14 w-14 rounded-md border border-slate-200 bg-white object-cover">
      <span class="min-w-0 flex-1 truncate text-sm text-slate-600">Gambar terpilih</span>
      <button type="button" class="grid h-8 w-8 shrink-0 place-items-center rounded text-slate-500 hover:bg-white hover:text-red-600" aria-label="Hapus gambar" @click="emit('update:modelValue', '')"><span class="material-symbols-outlined text-lg">close</span></button>
    </div>
    <label :for="inputId" :class="['flex min-h-24 cursor-pointer flex-col items-center justify-center rounded-lg border border-dashed border-slate-300 px-4 py-5 text-center transition-colors hover:border-primary hover:bg-orange-50/40', disabled ? 'pointer-events-none opacity-50' : '']">
      <span class="material-symbols-outlined text-2xl text-slate-400">cloud_upload</span>
      <span class="mt-1 text-sm font-semibold text-slate-700">Pilih gambar untuk diunggah</span>
      <span class="mt-1 text-xs text-slate-500">JPG, PNG, WebP · Maks. {{ maxSizeMB }} MB</span>
      <input :id="inputId" type="file" accept="image/jpeg,image/png,image/webp" class="sr-only" :disabled="disabled" @change="selectFile">
    </label>
  </div>
</template>

<script setup lang="ts">
interface Props {
  modelValue?: string;
  maxSizeMB?: number;
  disabled?: boolean;
}

const props = withDefaults(defineProps<Props>(), { modelValue: '', maxSizeMB: 2, disabled: false });
const emit = defineEmits<{
  'update:modelValue': [value: string];
  upload: [file: File];
  error: [message: string];
}>();
const inputId = useId();

const selectFile = (event: Event) => {
  const input = event.target as HTMLInputElement;
  const file = input.files?.[0];
  input.value = '';
  if (!file) return;
  const allowedTypes = ['image/jpeg', 'image/png', 'image/webp'];
  if (!allowedTypes.includes(file.type)) {
    emit('error', 'Format gambar harus JPG, PNG, atau WebP.');
    return;
  }
  if (file.size > props.maxSizeMB * 1024 * 1024) {
    emit('error', `Ukuran gambar maksimal ${props.maxSizeMB} MB.`);
    return;
  }
  emit('error', '');
  emit('upload', file);
};
</script>