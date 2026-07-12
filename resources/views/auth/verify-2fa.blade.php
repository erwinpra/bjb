<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Verifikasi - {{ config('app.name') }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body { background: #198754; min-height: 100vh; display: flex; align-items: center; }
        .card { border: none; border-radius: 12px; }
        .code-input { font-size: 2rem; letter-spacing: 12px; text-align: center; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <div class="bg-success bg-opacity-10 d-inline-flex p-3 rounded-circle mb-3">
                                <i class="bi bi-shield-lock fs-1 text-success"></i>
                            </div>
                            <h5 class="fw-bold">Verifikasi Dua Langkah</h5>
                            <p class="text-muted small mb-0">
                                Kode verifikasi telah dikirim ke email <strong>{{ $email }}</strong>.
                            </p>
                            <p class="text-muted small">Masukkan kode untuk melanjutkan.</p>
                        </div>

                        @if(session('error'))
                            <div class="alert alert-danger py-2 small">{{ session('error') }}</div>
                        @endif

                        <form method="POST" action="{{ route('verify-2fa') }}">
                            @csrf
                            <div class="mb-4">
                                <label class="form-label fw-semibold small">Kode Verifikasi</label>
                                <input type="text" name="code" class="form-control code-input @error('code') is-invalid @enderror"
                                    placeholder="000000" maxlength="6" inputmode="numeric" autocomplete="off" autofocus>
                                @error('code') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>

                            <button type="submit" class="btn btn-success w-100 py-2 fw-semibold">
                                <i class="bi bi-check-lg me-1"></i> Verifikasi
                            </button>
                        </form>

                        <div class="text-center mt-3">
                            <a href="{{ route('login') }}" class="text-decoration-none small text-muted">
                                <i class="bi bi-arrow-left me-1"></i> Kembali ke Login
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
