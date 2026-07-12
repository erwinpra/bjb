<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kode Verifikasi Login</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; background: #f4f4f4; margin: 0; padding: 0;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background: #f4f4f4; padding: 40px 0;">
        <tr>
            <td align="center">
                <table role="presentation" width="480" cellpadding="0" cellspacing="0" style="background: #ffffff; border-radius: 8px; overflow: hidden;">
                    <tr>
                        <td style="background: #198754; padding: 24px; text-align: center;">
                            <h1 style="color: #ffffff; margin: 0; font-size: 20px;">{{ config('app.name') }}</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 32px 24px;">
                            <h2 style="margin: 0 0 16px; font-size: 18px; color: #333;">Kode Verifikasi Login</h2>
                            <p style="margin: 0 0 20px; font-size: 14px; color: #555; line-height: 1.6;">
                                Anda telah melakukan login. Gunakan kode verifikasi di bawah ini untuk melanjutkan:
                            </p>
                            <div style="background: #f0fdf4; border: 2px dashed #198754; border-radius: 8px; padding: 20px; text-align: center; margin-bottom: 20px;">
                                <span style="font-size: 36px; font-weight: bold; letter-spacing: 8px; color: #198754;">{{ $code }}</span>
                            </div>
                            <p style="margin: 0 0 12px; font-size: 13px; color: #888;line-height: 1.5;">
                                Kode ini berlaku selama <strong>5 menit</strong>. Jangan bagikan kode ini kepada siapa pun.
                            </p>
                            <p style="margin: 0; font-size: 13px; color: #888; line-height: 1.5;">
                                Jika Anda tidak merasa melakukan login, abaikan email ini.
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
