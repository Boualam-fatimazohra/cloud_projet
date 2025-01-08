import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import path from 'path'; // Importez le module 'path' pour gérer les chemins

export default defineConfig({
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
            // Ajoutez un alias pour Ziggy
            'ziggy': path.resolve(__dirname, 'vendor/tightenco/ziggy/dist/vue.esm.js'),
            // Optionnel : Ajoutez un alias pour simplifier les imports dans votre projet
            '@': path.resolve(__dirname, 'resources/js'),
        },
    },
});