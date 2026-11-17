import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  base: './', // Important: use relative paths for NUI
  build: {
    outDir: 'dist', // Output folder
    assetsDir: '',  // Put assets directly in dist root
    rollupOptions: {
      output: {
        entryFileNames: `[name].js`,
        chunkFileNames: `[name].js`,
        assetFileNames: `[name].[ext]`, // No hashes
      },
    },
  },
})
