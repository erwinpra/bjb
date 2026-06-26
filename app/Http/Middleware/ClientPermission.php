<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class ClientPermission
{
    public function handle($request, Closure $next, $permission)
    {
        $client = Auth::guard('client')->user();

        if (!$client || !$client->hasClientPermission($permission)) {
            if ($request->expectsJson()) {
                return response()->json(['error' => 'Forbidden'], 403);
            }
            abort(403, 'Anda tidak memiliki izin untuk mengakses halaman ini.');
        }

        return $next($request);
    }
}
