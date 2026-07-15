<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\ActivityLog;

class ActivityLogController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:activity_log,view')->only(['index', 'show']);
        $this->middleware('cms.permission:activity_log,delete')->only(['destroy']);
    }

    public function index()
    {
        $logs = ActivityLog::with('user')
            ->latest()
            ->paginate(50);

        return view('cms::activity-logs.index', compact('logs'));
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
