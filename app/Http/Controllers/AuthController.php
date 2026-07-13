<?php

namespace App\Http\Controllers;

use App\Mail\TwoFactorCode;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class AuthController extends Controller
{
    public function showLogin()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $rules = [
            'email' => 'required|email',
            'password' => 'required',
        ];

        if (config('services.captcha.use')) {
            $rules['g-recaptcha-response'] = 'required';
        }

        $credentials = $request->validate($rules);

        if (config('services.captcha.use')) {
            $response = Http::asForm()->post('https://www.google.com/recaptcha/api/siteverify', [
                'secret' => config('services.captcha.secret'),
                'response' => $request->input('g-recaptcha-response'),
                'remoteip' => $request->ip(),
            ]);

            if (!($response->json()['success'] ?? false)) {
                return back()->withErrors(['captcha' => 'Verifikasi reCAPTCHA gagal.'])->onlyInput('email');
            }
        }

        unset($credentials['g-recaptcha-response']);

        $user = \App\Models\User::where('email', $credentials['email'])->first();

        if (!$user || !Hash::check($credentials['password'], $user->password)) {
            return back()->withErrors(['email' => 'Invalid credentials.']);
        }

        if (!config('services.two_fa.enabled')) {
            Auth::login($user);
            $request->session()->regenerate();
            return redirect()->intended(route('cms.dashboard'));
        }

        $code = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        Log::info('[2FA] Kode verifikasi untuk ' . $user->email . ': ' . $code);

        $user->two_factor_code = bcrypt($code);
        $user->two_factor_expires_at = Carbon::now()->addMinutes(5);
        $user->save();

        try {
            Mail::to($user->email)->send(new TwoFactorCode($code));
        } catch (\Exception $e) {
            Log::error('[2FA] Gagal kirim email: ' . $e->getMessage());
        }

        $request->session()->put('two_factor_user_id', $user->id);

        return redirect()->route('verify-2fa');
    }

    public function showVerifyForm()
    {
        if (!config('services.two_fa.enabled')) {
            return redirect()->route('login');
        }

        if (!session()->has('two_factor_user_id')) {
            return redirect()->route('login');
        }

        $user = \App\Models\User::find(session('two_factor_user_id'));

        if (!$user) {
            return redirect()->route('login')->withErrors(['email' => 'Sesi tidak valid.']);
        }

        return view('auth.verify-2fa', ['email' => $user->email]);
    }

    public function verifyCode(Request $request)
    {
        if (!config('services.two_fa.enabled')) {
            return redirect()->route('login');
        }

        if (!session()->has('two_factor_user_id')) {
            return redirect()->route('login');
        }

        $request->validate(['code' => 'required|string|size:6']);

        $userId = session('two_factor_user_id');
        $user = \App\Models\User::find($userId);

        if (!$user || !$user->two_factor_code || !$user->two_factor_expires_at) {
            return redirect()->route('login')->withErrors(['email' => 'Sesi tidak valid. Silakan login ulang.']);
        }

        if (Carbon::now()->gt($user->two_factor_expires_at)) {
            $user->two_factor_code = null;
            $user->two_factor_expires_at = null;
            $user->save();
            session()->forget('two_factor_user_id');
            return redirect()->route('login')->withErrors(['email' => 'Kode verifikasi sudah kadaluwarsa. Silakan login ulang.']);
        }

        if (!Hash::check($request->code, $user->two_factor_code)) {
            return back()->withErrors(['code' => 'Kode verifikasi salah.']);
        }

        $user->two_factor_code = null;
        $user->two_factor_expires_at = null;
        $user->save();

        Auth::login($user);

        session()->forget('two_factor_user_id');
        $request->session()->regenerate();

        return redirect()->intended(route('cms.dashboard'));
    }

    public function showProfile()
    {
        return view('cms.profile');
    }

    public function updatePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:6|confirmed',
        ]);

        $user = Auth::user();

        if (!Hash::check($request->current_password, $user->password)) {
            return back()->withErrors(['current_password' => 'Password saat ini salah.']);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        return back()->with('success', 'Password berhasil diubah.');
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/');
    }
}
