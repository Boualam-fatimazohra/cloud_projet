<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Category::create([
            'name' => 'Biographie',
            'slug'=>'biographies '
        ]);
        Category::create([
            'name' => 'Roman',
            'slug'=>'romans'
        ]);
        Category::create([
            'name' => 'Poésie',
            'slug'=>'poesie'
        ]);
    }
}
