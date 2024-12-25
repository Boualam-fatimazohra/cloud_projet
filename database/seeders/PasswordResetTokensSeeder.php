<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PasswordResetTokensSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Exemple d'utilisateur pour lequel on génère un token
        $email = 'user@example.com';  // Remplacez ceci par un email d'un utilisateur existant

        // Générer un token aléatoire
        $token = Str::random(60);  // Token de 60 caractères

        // Insérer un token de réinitialisation de mot de passe dans la table
        DB::table('password_reset_tokens')->insert([
            'email' => $email,
            'token' => $token,
            'created_at' => now(),
        ]);
    }
}
