<template>
  <div class="w-[6vh] flex flex-col gap-[0.5vh] select-none">
    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">
      {{ label || 'Opacitate' }}
    </span>

    <div class="w-[6vh] h-[6vh] shrink-0 bg-white/5 rounded-[0.75vh] relative">
      
      <div 
        class="absolute bottom-0 left-0 w-full bg-white/20 rounded-[0.75vh] pointer-events-none"
        :style="{ height: `${opacity * 100}%` }"
      ></div>

      <div 
        ref="handleRef"
        @mousedown="startDrag"
        class="absolute left-[-0.4vh] w-[calc(100%+0.8vh)] py-[1vh] flex items-end cursor-ns-resize z-20"
        :style="{ bottom: `calc(${opacity * 100}% - 1.3vh)` }"
      >
        <div class="w-full h-[0.6vh] rounded-full bg-white filter drop-shadow-[0_0_1px_rgba(0,0,0,1)]"></div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, onUnmounted } from 'vue';
defineProps({ label : String });
const opacity = ref(0.0); 
const handleRef = ref(null);
let isDragging = false;
let startY = 0;
let startOpacity = 0;

const startDrag = (event) => {
  isDragging = true;
  startY = event.clientY;
  startOpacity = opacity.value;

  window.addEventListener('mousemove', handleDrag);
  window.addEventListener('mouseup', stopDrag);
};

const handleDrag = (event) => {
  if (!isDragging) return;

  const deltaY = startY - event.clientY;
  const vhInPixels = window.innerHeight / 100;
  const deltaInVh = deltaY / vhInPixels;
  const deltaPercent = deltaInVh / 6;
  let newValue = startOpacity + deltaPercent;
  opacity.value = Math.max(0, Math.min(1, newValue));
};

const stopDrag = () => {
  isDragging = false;
  window.removeEventListener('mousemove', handleDrag);
  window.removeEventListener('mouseup', stopDrag);
};

onUnmounted(() => {
  stopDrag();
});
</script>