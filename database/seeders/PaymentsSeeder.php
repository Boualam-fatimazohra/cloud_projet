<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class PaymentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create();

        // Vous pouvez ajuster le nombre de paiements à insérer
        $orders = Order::all(); // Récupère toutes les commandes existantes
        $users = User::all(); // Récupère tous les utilisateurs

        foreach ($orders as $order) {
            // Sélectionne un utilisateur aléatoire parmi les utilisateurs
            $user = $users->random();

            // Insérer des paiements fictifs pour chaque commande
            DB::table('payments')->insert([
                'order_id' => $order->id,
                'amount' => $faker->randomFloat(2, 10, 1000), // Montant aléatoire entre 10 et 1000
                'status' => $faker->randomElement(['pending', 'completed', 'failed']), // Statut aléatoire
                'type' => $faker->randomElement(['credit_card', 'paypal', 'bank_transfer']), // Type de paiement aléatoire
                'created_by' => $user->id,
                'updated_by' => $user->id,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
