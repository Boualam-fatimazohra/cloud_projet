<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;


class OrderItemsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Vous pouvez récupérer une commande existante ou en créer une
        $order = Order::first();  // Utilisez une commande existante. Sinon, créez-en une.
        
        // Vous pouvez récupérer un produit existant ou en créer un
        $product = Product::first();  // Utilisez un produit existant. Sinon, créez-en un.

        if ($order && $product) {
            // Insérer des éléments dans la table order_items
            DB::table('order_items')->insert([
                'order_id' => $order->id,  // ID de la commande
                'product_id' => $product->id,  // ID du produit
                'quantity' => 2,  // Quantité de produit
                'unit_price' => 50.00,  // Prix unitaire du produit
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Ajouter d'autres produits si nécessaire
            DB::table('order_items')->insert([
                'order_id' => $order->id,
                'product_id' => $product->id,
                'quantity' => 3,
                'unit_price' => 25.00,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        } else {
            echo "Commande ou produit non trouvé.\n";
        }
    }
}
