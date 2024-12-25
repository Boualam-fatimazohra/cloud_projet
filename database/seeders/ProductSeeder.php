<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Product::create([
            'title' => 'fraper lepopé.',
            'price' => 19.03,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par alice zeniter il decrit  .'
        ]);
        Product::create([
            'title' => 'Le portrait dorain gray.',
            'price' => 15.00,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par lancdome .'
        ]);
        Product::create([
            'title' => 'Sans famille.',
            'price' => 20.00,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par hector malot .'
        ]);
        Product::create([
            'title' => 'Le signeur des anneaux .',
            'price' => 30.00,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par jor tolkien .'
        ]);
        Product::create([
            'title' => 'Dedierot.',
            'price' => 25.00,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par jack .'
        ]);
        Product::create([
            'title' => 'Ames mosquée  la nose .',
            'price' => 10.00,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par larevikest .'
        ]);
        Product::create([
            'title' => 'Notre dame de paris.',
            'price' => 30.00,
            'quantity' => 3,
            'category_id'=> 1,
            'brand_id'=>1,
            'description'=>'Livre de litterature francaise decrit par victor hugo .'
        ]);
        
    }
}
