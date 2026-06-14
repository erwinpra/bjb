<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Role;
use App\Models\Cms\Pasal;
use App\Models\Cms\Badan;
use App\Models\Cms\DataClient;
use App\Models\User;

class DashboardController extends Controller
{
    public function index()
    {
        $stats = [
            'roles' => Role::count(),
            'users' => User::count(),
            'pasal' => Pasal::count(),
            'badan' => Badan::count(),
            'data_client' => DataClient::count(),
        ];

        return view('cms::dashboard.index', compact('stats'));
    }
}
