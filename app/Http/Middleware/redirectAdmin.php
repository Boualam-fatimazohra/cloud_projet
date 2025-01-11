<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class redirectAdmin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     * @param  string|null  $guard
     */
    public function handle(Request $request, Closure $next, $guard = null): Response
    {
        // Vérifie si l'utilisateur est connecté et est un administrateur
        if (Auth::guard($guard)->check() && Auth::user()->isAdmin == 1) {
            // Redirige vers le tableau de bord admin
            return redirect()->route('admin.dashboard');
        }

        // Continue la requête pour les utilisateurs non administrateurs ou non connectés
        return $next($request);
    }
}