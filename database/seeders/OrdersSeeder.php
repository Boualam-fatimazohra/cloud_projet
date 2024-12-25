<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\User;
use App\Models\UserAddress;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class OrdersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Simuler un utilisateur et une adresse
        $user = User::first(); // Récupérer un utilisateur existant, sinon créez-en un
        $userAddress = UserAddress::first(); // Récupérer une adresse existante, sinon créez-en une

        // Insérer des commandes fictives
        DB::table('orders')->insert([
            'total_price' => 99.99,
            'status' => 'pending',
            'session_id' => Str::random(32),
            'user_address_id' => $userAddress ? $userAddress->id : 1, // Utiliser une adresse existante ou une valeur par défaut
            'created_by' => $user ? $user->id : null, // Si un utilisateur est trouvé, utiliser son ID
            'updated_by' => $user ? $user->id : null, // Similaire pour updated_by
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Vous pouvez ajouter plus d'exemples de données si nécessaire
    }
}
