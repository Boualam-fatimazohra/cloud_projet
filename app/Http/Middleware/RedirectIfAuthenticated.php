<?php

namespace App\Http\Middleware;

use App\Providers\RouteServiceProvider;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RedirectIfAuthenticated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     * @param  string|null  ...$guards
     */
    public function handle(Request $request, Closure $next, string ...$guards): Response
    {
        // Si aucun guard n'est spécifié, utilise le guard par défaut (null)
        $guards = empty($guards) ? [null] : $guards;

        foreach ($guards as $guard) {
            // Vérifie si l'utilisateur est connecté
            if (Auth::guard($guard)->check()) {
                // Si l'utilisateur est déjà sur la page d'accueil, ne pas rediriger
                if ($request->routeIs('home')) {
                    return $next($request);
                }
                // Redirige vers la page d'accueil
                return redirect(RouteServiceProvider::HOME);
            }
        }

        // Continue la requête pour les utilisateurs non connectés
        return $next($request);
    }
}