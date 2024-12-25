<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class CartItemsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Vérifiez s'il y a des utilisateurs
        $users = User::all();

        // Vérifiez s'il y a des produits
        $products = Product::all();

        if ($users->isEmpty() || $products->isEmpty()) {
            Log::info('Aucun utilisateur ou produit trouvé pour insérer des éléments dans le panier.');
            return;
        }

        // Insérer des éléments dans le panier pour chaque utilisateur
        foreach ($users as $user) {
            // Sélectionner quelques produits au hasard
            $randomProducts = $products->random(3); // Choisir 3 produits au hasard

            foreach ($randomProducts as $product) {
                DB::table('cart_items')->insert([
                    'user_id' => $user->id,
                    'product_id' => $product->id,
                    'quantity' => rand(1, 5),  // Quantité aléatoire entre 1 et 5
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
