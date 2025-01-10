import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import path from 'path'; // Importez le module 'path' pour gérer les chemins

export default defineConfig({
    server: {
        host: '0.0.0.0', // Écoute sur toutes les interfaces réseau
        port: process.env.PORT || 4173, // Utilise le port défini par Render ou 4173 par défaut
    },
    preview: {
        host: '0.0.0.0', // Écoute sur toutes les interfaces réseau en mode prévisualisation
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
            // Ajoutez un alias pour Ziggy
            'ziggy': path.resolve(__dirname, 'vendor/tightenco/ziggy/dist/vue.esm.js'),
            // Optionnel : Ajoutez un alias pour simplifier les imports dans votre projet
            '@': path.resolve(__dirname, 'resources/js'),
        },
    },
});