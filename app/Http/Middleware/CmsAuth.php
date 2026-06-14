<?php

namespace App\Http\Middleware;

use Closure;

class CmsAuth
{
    public function handle($request, Closure $next)
    {
        if (!config('cms.enabled')) {
            abort(404);
        }

        $user = $request->user();
        if (!$user) {
            return redirect()->route('login');
        }

        if (!$user->canAccessCms()) {
            abort(403, 'Unauthorized access to CMS.');
        }

        return $next($request);
    }
}
