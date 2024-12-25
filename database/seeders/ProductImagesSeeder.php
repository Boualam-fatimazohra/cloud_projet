<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;

class ProductImagesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Vérifiez s'il y a des produits dans la table
        $products = DB::table('products')->get();

        if ($products->isEmpty()) {
            Log::info('Aucun produit trouvé pour insérer des images.');
            return;
        }

        // Chemin vers le dossier contenant les images
        $imageDirectory = public_path('product_images');

        // Vérifiez si le dossier existe
        if (!File::exists($imageDirectory)) {
            Log::error("Le dossier {$imageDirectory} n'existe pas.");
            return;
        }

        // Récupère tous les fichiers dans le dossier
        $images = collect(File::files($imageDirectory))
            ->filter(function ($file) {
                // Filtrer uniquement les fichiers avec des extensions valides
                return in_array(strtolower($file->getExtension()), ['jpg', 'jpeg', 'png', 'gif']);
            });

        if ($images->isEmpty()) {
            Log::info('Aucune image valide trouvée dans le dossier product_images.');
            return;
        }

        // Associer chaque produit à une image disponible
        foreach ($products as $product) {
            // Récupérer une image aléatoire ou utiliser un ordre séquentiel
            $imageFile = $images->shift(); // Prend la première image et la retire de la collection

            if ($imageFile) {
                DB::table('product_images')->insert([
                    'image' => 'product_images/' . $imageFile->getFilename(), // Chemin relatif
                    'product_id' => $product->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            } else {
                // Si aucune image n'est disponible, utilisez une image par défaut
                DB::table('product_images')->insert([
                    'image' => 'product_images/default.jpg', // Exemple d'image par défaut
                    'product_id' => $product->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
