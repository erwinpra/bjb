<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Setting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function index()
    {
        $groups = Setting::all()->groupBy('group');
        return view('cms::settings.index', compact('groups'));
    }

    public function update(Request $request)
    {
        $settings = $request->except('_token', '_method');

        foreach ($settings as $key => $value) {
            if (str_starts_with($key, 'setting_')) {
                $realKey = substr($key, 8);
                Setting::setValue($realKey, $value);
            }
        }

        return redirect()->route('cms.settings.index')
            ->with('success', 'Settings saved.');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'key' => 'required|max:255|unique:cms_settings,key',
            'value' => 'nullable',
            'group' => 'required|max:100',
            'type' => 'required|max:50',
        ]);

        Setting::create($data);

        return redirect()->route('cms.settings.index')
            ->with('success', 'Setting created.');
    }

    public function destroy(Setting $setting)
    {
        $setting->delete();
        return redirect()->route('cms.settings.index')
            ->with('success', 'Setting deleted.');
    }
}
