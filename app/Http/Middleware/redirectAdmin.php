<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class redirectAdmin
{
    public function handle(Request $request, Closure $next, $guard = null): Response
    {
        // Si l'utilisateur est déjà connecté et est un admin, redirigez-le vers le tableau de bord admin
        if (Auth::guard($guard)->check() && Auth::user()->isAdmin == 1) {
            return redirect()->route('admin.dashboard');
        }

        return $next($request);
    }
}