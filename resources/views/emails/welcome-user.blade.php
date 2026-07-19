<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Informasi Login</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; background: #f4f4f4; margin: 0; padding: 0;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background: #f4f4f4; padding: 40px 0;">
        <tr>
            <td align="center">
                <table role="presentation" width="480" cellpadding="0" cellspacing="0" style="background: #ffffff; border-radius: 8px; overflow: hidden;">
                    <tr>
                        <td style="background: #0d6efd; padding: 24px; text-align: center;">
                            <h1 style="color: #ffffff; margin: 0; font-size: 20px;">{{ config('app.name') }}</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 32px 24px;">
                            <h2 style="margin: 0 0 16px; font-size: 18px; color: #333;">Akun Berhasil Dibuat</h2>
                            <p style="margin: 0 0 8px; font-size: 14px; color: #555; line-height: 1.6;">Halo <strong>{{ $name }}</strong>,</p>
                            <p style="margin: 0 0 20px; font-size: 14px; color: #555; line-height: 1.6;">
                                Akun Anda untuk <strong>{{ config('app.name') }}</strong> telah berhasil dibuat. Silakan gunakan kredensial di bawah ini untuk login:
                            </p>
                            <div style="background: #f0f6ff; border: 2px dashed #0d6efd; border-radius: 8px; padding: 20px; margin-bottom: 20px;">
                                <table width="100%" cellpadding="6" cellspacing="0">
                                    <tr>
                                        <td style="font-size: 13px; color: #555; font-weight: bold; width: 80px;">Email</td>
                                        <td style="font-size: 14px; color: #333;">{{ $email }}</td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 13px; color: #555; font-weight: bold;">Password</td>
                                        <td style="font-size: 14px; color: #333; font-family: monospace; letter-spacing: 1px;">{{ $password }}</td>
                                    </tr>
                                </table>
                            </div>
                            <p style="margin: 0 0 12px; font-size: 14px; color: #333; line-height: 1.6; text-align: center;">
                                <a href="{{ request()->getSchemeAndHttpHost() }}/login" style="background: #0d6efd; color: #ffffff; padding: 12px 32px; border-radius: 6px; text-decoration: none; display: inline-block; font-weight: bold;">Login ke {{ config('app.name') }}</a>
                            </p>
                            <p style="margin: 0 0 12px; font-size: 13px; color: #888; line-height: 1.5;">
                                Sebaiknya segera ganti password Anda setelah login pertama.
                            </p>
                            <p style="margin: 0; font-size: 13px; color: #888; line-height: 1.5;">
                                Jika Anda tidak merasa mendaftar, abaikan email ini.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td style="background: #f8f9fa; padding: 16px 24px; text-align: center; font-size: 12px; color: #aaa;">
                            &copy; {{ date('Y') }} {{ config('app.name') }}. All rights reserved.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
