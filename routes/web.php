<?php

use App\Http\Controllers\Admin\AdminAuthController;
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\ProductController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\User\CartController;
use App\Http\Controllers\User\CheckoutController;
use App\Http\Controllers\User\DashboardController;
use App\Http\Controllers\User\ProductController as UserProductController;
use App\Http\Controllers\User\ProductListController;
use App\Http\Controllers\User\UserController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

// Routes publiques
Route::get('/', [UserController::class, 'index'])->name('home');
Route::get('/categorie', function () {
    return Inertia::render('categori');
});
Route::get('/contact', function () {
    return Inertia::render('contact');
});

// Routes pour les produits
Route::prefix('products')->controller(ProductListController::class)->group(function () {
    Route::get('/', 'index')->name('products.index');
});

// Routes pour le panier
Route::prefix('cart')->controller(CartController::class)->group(function () {
    Route::get('view', 'view')->name('cart.view');
    Route::post('store/{product}', 'store')->name('cart.store');
    Route::patch('update/{product}', 'update')->name('cart.update');
    Route::delete('delete/{product}', 'delete')->name('cart.delete');
});

// Routes pour les utilisateurs connectés
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Checkout
    Route::prefix('checkout')->controller(CheckoutController::class)->group(function () {
        Route::post('order', 'store')->name('checkout.store');
        Route::get('success', 'success')->name('checkout.success');
        Route::get('cancel', 'cancel')->name('checkout.cancel');
    });
});

// Routes pour l'administration
Route::prefix('admin')->group(function () {
    // Routes publiques pour l'admin (login/logout)
    Route::get('login', [AdminAuthController::class, 'showLoginForm'])->name('admin.login');
    Route::post('login', [AdminAuthController::class, 'login'])->name('admin.login.post');
    Route::post('logout', [AdminAuthController::class, 'logout'])->name('admin.logout');

    // Routes protégées pour l'admin
    Route::middleware(['auth', 'admin'])->group(function () {
        Route::get('/dashboard', [AdminController::class, 'index'])->name('admin.dashboard');
        Route::get('/products', [ProductController::class, 'index'])->name('admin.products.index');
        Route::post('/products/store', [ProductController::class, 'store'])->name('admin.products.store');
        Route::put('/products/update/{id}', [ProductController::class, 'update'])->name('admin.products.update');
        Route::delete('/products/image/{id}', [ProductController::class, 'deleteImage'])->name('admin.products.image.delete');
        Route::delete('/products/destroy/{id}', [ProductController::class, 'destroy'])->name('admin.products.destroy');
    });
});

// Routes pour les images de produits
Route::get('/product_images/{image}', function ($image) {
    $path = storage_path('app/public/product_images/' . $image);
    if (file_exists($path)) {
        return response()->file($path);
    } else {
        abort(404, 'Image non trouvée');
    }
});

require __DIR__ . '/auth.php';