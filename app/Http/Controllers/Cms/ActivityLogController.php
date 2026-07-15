<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\ActivityLog;
use Illuminate\Http\Request;

class ActivityLogController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:activity_log,view')->only(['index', 'show']);
        $this->middleware('cms.permission:activity_log,delete')->only(['destroy', 'clear']);
    }

    public function index(Request $request)
    {
        $search = $request->get('search');
        $perPage = $request->get('per_page', 20);

        $logs = ActivityLog::with('user')
            ->when($search, function ($q) use ($search) {
                $q->where('action', 'like', "%{$search}%")
                  ->orWhere('module', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%")
                  ->orWhere('ip_address', 'like', "%{$search}%")
                  ->orWhereHas('user', function ($u) use ($search) {
                      $u->where('name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%");
                  });
            })
            ->latest()
            ->paginate($perPage);

        return view('cms::activity-logs.index', compact('logs', 'search', 'perPage'));
    }

    public function show(ActivityLog $activityLog)
    {
        $activityLog->load('user');
        return view('cms::activity-logs.show', compact('activityLog'));
    }

    public function destroy(ActivityLog $activityLog)
    {
        $activityLog->delete();
        return redirect()->route('cms.activity-logs.index')
            ->with('success', 'Log deleted.');
    }

    public function clear()
    {
        ActivityLog::truncate();
        return redirect()->route('cms.activity-logs.index')
            ->with('success', 'All logs cleared.');
    }
}
