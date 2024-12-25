<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PersonalAccessTokensSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Récupère un utilisateur existant ou en crée un
        $user = User::first(); // Utilisez l'utilisateur qui existe dans votre base de données, ou créez-en un

        // Génération d'un token pour cet utilisateur
        DB::table('personal_access_tokens')->insert([
            'tokenable_type' => get_class($user),  // Type de modèle, ici c'est l'utilisateur
            'tokenable_id' => $user->id,           // ID de l'utilisateur
            'name' => 'Example Token',              // Nom du token
            'token' => Str::random(64),             // Génération d'un token aléatoire de 64 caractères
            'abilities' => json_encode(['*']),     // Les permissions associées au token (ici toutes les permissions)
            'last_used_at' => now(),               // Date et heure de dernière utilisation
            'expires_at' => now()->addDays(30),    // Expiration dans 30 jours
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
