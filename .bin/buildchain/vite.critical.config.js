import {resolve} from 'path'
import {normalizePath} from 'vite'
import critical from 'rollup-plugin-critical'

const nPath = (path) => normalizePath(resolve(__dirname, path))

const criticalUrl = process.env.CRITICAL_URL || false

export default {
  base: `/dist/`,
  publicDir: nPath('./src/static'),
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  build: {
    emptyOutDir: false,
    manifest: false,
    outDir: nPath('./cms/web/dist/'),
    rollupOptions: {
      input: ['./src/css/app.css'],
      output: {
        sourcemap: false
      }
    }
  },
  plugins: [
    ...(criticalUrl
      ? [
          critical.default({
            criticalUrl,
            criticalBase: nPath('./cms/web/dist/criticalcss/'),
            criticalPages: [
              {
                uri: '',
                template: '_pages/_home'
              }
            ],
            criticalConfig: {
              base: nPath('./cms/web/dist/criticalcss/'),
              extract: true,
              dimensions: [{width: 1300, height: 980}]
            }
          })
        ]
      : [])
  ]
}
