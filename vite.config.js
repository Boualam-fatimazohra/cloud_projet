import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import path from 'path'; // Importez le module 'path' pour gérer les chemins

export default defineConfig({
    base: '/', // ou '/mon-app/' si déployé dans un sous-répertoire
    server: {
        host: '0.0.0.0',
        port: process.env.PORT || 4173,
    },
    preview: {
        host: '0.0.0.0',
        port: process.env.PORT || 4173,
    },
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    resolve: {
        alias: {
            'ziggy': path.resolve(__dirname, 'vendor/tightenco/ziggy/dist/vue.esm.js'),
            '@': path.resolve(__dirname, 'resources/js'),
        },
    },
});