<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login Client - BJP Online</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    @if(config('services.captcha.use'))
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    @endif
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-success text-white text-center py-4 border-0">
                        <i class="bi bi-person-badge fs-1 mb-2 d-block"></i>
                        <h4 class="fw-bold mb-0">Client Portal</h4>
                        <p class="small mb-0 opacity-75">BJP Online</p>
                    </div>
                    <div class="card-body p-4">
                        @if($errors->any())
                            <div class="alert alert-danger d-flex align-items-center gap-2 py-2 small">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                {{ $errors->first() }}
                            </div>
                        @endif

                        <form method="POST" action="{{ route('client.login') }}">
                            @csrf
                            <div class="mb-3">
                                <label class="form-label small fw-semibold">NIK / NPWP</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person-vcard"></i></span>
                                    <input type="text" name="nik_npwp" value="{{ old('nik_npwp') }}" required autofocus
                                           class="form-control" placeholder="Masukkan NIK atau NPWP">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-semibold">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <input type="password" name="password" required class="form-control" placeholder="password">
                                </div>
                            </div>

                            @if(config('services.captcha.use'))
                                <div class="mb-3 d-flex justify-content-center">
                                    <div class="g-recaptcha" data-sitekey="{{ config('services.captcha.site') }}"></div>
                                </div>
                            @endif

                            <button type="submit" class="btn btn-success w-100 py-2 fw-semibold">
                                <i class="bi bi-box-arrow-in-right me-1"></i> Login
                            </button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
