// Accept HMR as per: https://vitejs.dev/guide/api-hmr.html
if (import.meta.hot) {
  import.meta.hot.accept(() => {
    console.log('HMR')
  })
}

import 'vite/modulepreload-polyfill'
import './alpinejs/alpinejs'

console.log('Hello from app.ts')
