<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - BJP Online</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    @if(config('services.captcha.use'))
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    @endif
</head>
<body class="bg-dark d-flex align-items-center min-vh-100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-primary text-white text-center py-4 border-0">
                        <i class="bi bi-grid-3x3-gap-fill fs-1 mb-2 d-block"></i>
                        <h4 class="fw-bold mb-0">BJP Online</h4>
                    </div>
                    <div class="card-body p-4">
                        @if($errors->any())
                            <div class="alert alert-danger d-flex align-items-center gap-2 py-2 small">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                {{ $errors->first() }}
                            </div>
                        @endif

                        <form method="POST" action="{{ route('login') }}" id="loginForm">
                            @csrf
                            <div class="mb-3">
                                <label class="form-label small fw-semibold">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <input type="email" name="email" value="{{ old('email') }}" required autofocus
                                           class="form-control" placeholder="admin@example.com">
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

                            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold" id="loginBtn">
                                <i class="bi bi-box-arrow-in-right me-1"></i> Login
                            </button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div id="loadingOverlay" class="d-none" style="position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,.5);display:flex;align-items:center;justify-content:center">
        <div class="text-center text-white">
            <div class="spinner-border fs-1" role="status" style="width:3rem;height:3rem"></div>
            <p class="mt-3 fw-semibold">Memproses...</p>
        </div>
    </div>
    <script>
        document.getElementById('loginForm').addEventListener('submit', function() {
            document.getElementById('loadingOverlay').classList.remove('d-none');
            document.getElementById('loginBtn').disabled = true;
        });
    </script>
</body>
</html>
