<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\UserAddress;
use Illuminate\Database\Seeder;

class UserAddressesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Vous pouvez récupérer un utilisateur existant ou en créer un
        $user = User::first();  // Utilisez un utilisateur existant. Sinon, créez-en un.

        if ($user) {
            // Insérer des adresses dans la table user_addresses
            UserAddress::create([
                'type' => 'billing',  // Par exemple, adresse de facturation
                'address1' => '123 Main St',
                'address2' => 'Apt 4B',  // Si applicable
                'city' => 'CityName',
                'state' => 'StateName',
                'zipcode' => '12345',
                'isMain' => true,  // Marqué comme adresse principale
                'country_code' => 'US',  // Code du pays
                'user_id' => $user->id,  // Assurez-vous que l'ID utilisateur existe
            ]);

            UserAddress::create([
                'type' => 'shipping',  // Par exemple, adresse de livraison
                'address1' => '456 Another St',
                'address2' => '',
                'city' => 'OtherCity',
                'state' => 'OtherState',
                'zipcode' => '67890',
                'isMain' => false,
                'country_code' => 'US',
                'user_id' => $user->id,
            ]);
        } else {
            echo "Utilisateur non trouvé.\n";
        }
    }
}
