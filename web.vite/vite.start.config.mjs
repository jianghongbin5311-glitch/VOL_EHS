import { fileURLToPath } from 'node:url'
import commonjs from 'vite-plugin-commonjs'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'

export default defineConfig({
  plugins: [
    commonjs(),
    vue(),
    vueJsx()
  ],
  define: {
    eval: 'window.eval',
    __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: 'true'
  },
  optimizeDeps: {
    disabled: true
  },
  esbuild: false,
  publicDir: 'public',
  css: {
    devSourcemap: false
  },
  server: {
    port: 9000,
    host: true
  },
  resolve: {
    extensions: ['.mjs', '.js', '.jsx', '.json', '.vue'],
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
