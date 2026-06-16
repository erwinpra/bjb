@extends('cms::layouts.app')

@section('title', 'Profile')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Profile</li>
@endpush

@section('content')
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-person-circle me-2"></i>Informasi Akun</h6>
                </div>
                <div class="card-body p-4">
                    <table class="table table-sm mb-0">
                        <tr><td class="text-muted" style="width:120px">Nama</td><td class="fw-medium">{{ auth()->user()->name }}</td></tr>
                        <tr><td class="text-muted">Email</td><td>{{ auth()->user()->email }}</td></tr>
                        <tr><td class="text-muted">Bergabung</td><td>{{ auth()->user()->created_at->format('d M Y') }}</td></tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-key me-2"></i>Ganti Password</h6>
                </div>
                <div class="card-body p-4">
                    @if(session('success'))
                        <div class="alert alert-success py-2 small">{{ session('success') }}</div>
                    @endif
                    @if($errors->any())
                        <div class="alert alert-danger py-2 small">{{ $errors->first() }}</div>
                    @endif

                    <form method="POST" action="{{ route('cms.profile.password') }}">
                        @csrf
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Password Saat Ini</label>
                            <input type="password" name="current_password" required class="form-control" placeholder="Masukkan password saat ini">
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Password Baru</label>
                            <input type="password" name="new_password" required class="form-control" placeholder="Minimal 6 karakter" minlength="6">
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Konfirmasi Password Baru</label>
                            <input type="password" name="new_password_confirmation" required class="form-control" placeholder="Ulangi password baru">
                        </div>
                        <button type="submit" class="btn btn-primary px-4"><i class="bi bi-check-lg me-1"></i> Simpan Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
