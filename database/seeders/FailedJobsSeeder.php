<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FailedJobsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('failed_jobs')->insert([
            'uuid' => (string) \Str::uuid(), // Générer un UUID unique
            'connection' => 'database', // Exemple de type de connexion
            'queue' => 'default', // Exemple de queue
            'payload' => json_encode([
                'job' => 'App\\Jobs\\ExampleJob',
                'data' => 'Job data here',
            ]), // Payload simulé
            'exception' => 'Error: Database connection failed', // Exception simulée
            'failed_at' => now(), // Date et heure de l'échec
        ]);

        // Vous pouvez également ajouter plus d'exemples en dupliquant l'insertion
    }
}
