<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function showLogin()
    {
        return view('client.login');
    }

    public function login(Request $request)
    {
        $request->validate([
            'nik_npwp' => 'required',
            'password' => 'required',
        ]);

        $client = DataClient::where('npwp', $request->nik_npwp)->first();

        if ($client && Hash::check($request->password, $client->password)) {
            Auth::guard('client')->login($client);
            $request->session()->regenerate();
            return redirect()->intended(route('client.dashboard'));
        }

        return back()->withErrors(['nik_npwp' => 'NIK/NPWP atau password salah.'])->onlyInput('nik_npwp');
    }

    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:6',
            'confirm_password' => 'required|same:new_password',
        ]);

        $client = Auth::guard('client')->user();

        if (!Hash::check($request->current_password, $client->password)) {
            return back()->withErrors(['current_password' => 'Password saat ini salah.']);
        }

        $client->password = Hash::make($request->new_password);
        $client->save();

        return back()->with('success', 'Password berhasil diubah.');
    }

    public function logout(Request $request)
    {
        Auth::guard('client')->logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect()->route('client.login');
    }
}
