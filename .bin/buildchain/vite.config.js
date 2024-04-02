/* eslint-disable @typescript-eslint/no-explicit-any */
import { defineConfig, normalizePath } from 'vite';
import { resolve } from 'path';
import { ViteFaviconsPlugin } from 'vite-plugin-favicon2';
import manifestSRI from 'vite-plugin-manifest-sri';
import legacy from '@vitejs/plugin-legacy';
import ViteRestart from 'vite-plugin-restart';

const nPath = (path) => normalizePath(resolve(__dirname, path));

const ddevUrl = process.env.DDEV_PRIMARY_URL || 'http://localhost';
const ddevVitePort = parseInt(process.env.VITE_PRIMARY_PORT || '5173');

const viteRestartValue = (() => {
  try {
    return ViteRestart({ reload: ['./cms/templates/**/*'] });
  } catch {
    return ViteRestart.default({ reload: ['./cms/templates/**/*'] });
  }
})();

export default defineConfig(({ command }) => ({
  base: command === 'serve' ? '' : '/dist/',
  publicDir: nPath('./src/static'),
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  build: {
    manifest: true,
    outDir: nPath('./cms/web/dist'),
    rollupOptions: {
      input: [
        './src/js/app.ts',
        './src/css/app.css',
        './src/js/utils/lazysizes-wrapper.ts',
      ],
      output: {
        sourcemap: false,
      },
    },
    emptyOutDir: true,
  },
  plugins: [
    manifestSRI(),

    legacy({
      targets: ['defaults', 'not IE 11'],
    }),

    /*
      Using undocumented "reload" prop instead "restart" for
      faster developement. Check:
      https://github.com/antfu/vite-plugin-restart/blob/main/src/index.ts#L25
    */

    viteRestartValue,

    ViteFaviconsPlugin({
      logo: nPath('./src/static/favicon.svg'),
      inject: false,
      outputPath: 'favicons',
      favicons: {
        appName: 'project-slug',
        appShortName: 'PROJECT NAME',
        appDescription: 'PROJECT DESCRIPTION',
        start_url: '/',
        background: '#fff',
        theme_color: '#ccc',
      },
    }),
  ],
  server: {
    fs: {
      strict: false,
    },
    origin: `${ddevUrl}:${ddevVitePort}`,
    host: '0.0.0.0',
    port: ddevVitePort,
    strictPort: true,
  },
}));
