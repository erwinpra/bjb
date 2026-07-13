<?php

namespace App\Http\Middleware;

use Closure;

class CmsPermission
{
    public function handle($request, Closure $next, $module, $action)
    {
        $user = $request->user();

        if (!$user || !$user->hasCmsPermission($module, $action)) {
            abort(403, 'Anda tidak memiliki izin untuk mengakses halaman ini.');
        }

        return $next($request);
    }
}
