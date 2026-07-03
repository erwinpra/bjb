<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;

class AuthController extends Controller
{
    public function showLogin()
    {
        return view('client.login');
    }

    public function login(Request $request)
    {
        $rules = [
            'nik_npwp' => 'required',
            'password' => 'required',
        ];

        if (config('services.captcha.use')) {
            $rules['g-recaptcha-response'] = 'required';
        }

        $request->validate($rules);

        if (config('services.captcha.use')) {
            $response = Http::asForm()->post('https://www.google.com/recaptcha/api/siteverify', [
                'secret' => config('services.captcha.secret'),
                'response' => $request->input('g-recaptcha-response'),
                'remoteip' => $request->ip(),
            ]);

            if (!($response->json()['success'] ?? false)) {
                return back()->withErrors(['captcha' => 'Verifikasi reCAPTCHA gagal.'])->onlyInput('nik_npwp');
            }
        }

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
