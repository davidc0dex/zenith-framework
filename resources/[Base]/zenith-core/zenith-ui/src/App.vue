<script setup>
import Interface from './components/Interface/Index.vue';
import Auth from './components/Auth/Index.vue';
import { post } from './utils'; 
window.addEventListener('message', function(event) {
  let data = event.data;

  if (data.action === 'copyClipboard') {
      const textArea = document.createElement('textarea');
      textArea.value = data.text;
      document.body.appendChild(textArea);
      textArea.select();
      document.execCommand('copy');
      document.body.removeChild(textArea);
  }
});
</script>

<template>
  <Interface />
  <Auth />
</template>