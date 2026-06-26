@extends('cms::layouts.app')

@section('title', 'Dokumentasi')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Dokumentasi</li>
@endpush

@push('styles')
<style>
    .dok-content h1 { font-size: 1.6rem; margin-top: 1.5rem; margin-bottom: 0.75rem; padding-bottom: 0.5rem; border-bottom: 2px solid #198754; color: #198754; }
    .dok-content h2 { font-size: 1.3rem; margin-top: 1.5rem; margin-bottom: 0.5rem; color: #333; }
    .dok-content h3 { font-size: 1.1rem; margin-top: 1.2rem; color: #555; }
    .dok-content p { line-height: 1.7; margin-bottom: 0.75rem; }
    .dok-content ul, .dok-content ol { margin-bottom: 1rem; padding-left: 1.5rem; }
    .dok-content li { margin-bottom: 0.25rem; line-height: 1.6; }
    .dok-content table { width: 100%; border-collapse: collapse; margin-bottom: 1rem; font-size: 0.9rem; }
    .dok-content th, .dok-content td { padding: 0.5rem 0.75rem; border: 1px solid #dee2e6; }
    .dok-content th { background: #f8f9fa; font-weight: 600; }
    .dok-content code { background: #f4f4f4; padding: 0.15rem 0.4rem; border-radius: 3px; font-size: 0.85rem; color: #d63384; }
    .dok-content pre { background: #1e1e1e; color: #d4d4d4; padding: 1rem; border-radius: 6px; overflow-x: auto; margin-bottom: 1rem; }
    .dok-content pre code { background: none; color: inherit; padding: 0; }
    .dok-content blockquote { border-left: 4px solid #198754; padding-left: 1rem; margin-left: 0; color: #666; }
    .dok-content a { color: #198754; }
    .dok-content hr { margin: 1.5rem 0; }
    .dok-content img { max-width: 100%; }
</style>
@endpush

@section('content')
<div class="row g-4">
    <div class="col-md-3">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3 border-bottom">
                <h6 class="fw-semibold mb-0"><i class="bi bi-list-ul me-2"></i>Dokumen</h6>
            </div>
            <div class="list-group list-group-flush">
                @forelse($files as $file)
                    <a href="{{ route('cms.dokumentasi.show', $file['path']) }}"
                       class="list-group-item list-group-item-action d-flex align-items-center gap-2 py-2 px-3
                              {{ $activeFile === $file['path'] ? 'active' : '' }}">
                        <i class="bi bi-file-earmark-text"></i>
                        <span class="small">{{ $file['label'] }}</span>
                    </a>
                @empty
                    <div class="list-group-item text-muted small py-3 text-center">
                        <i class="bi bi-inbox fs-4 d-block mb-1"></i>
                        Tidak ada file dokumentasi.
                    </div>
                @endforelse
            </div>
        </div>
    </div>
    <div class="col-md-9">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4 dok-content">
                @if($activeFile && $content)
                    {!! $content !!}
                @elseif($activeFile && !$content)
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-file-earmark-x fs-1 d-block mb-2"></i>
                        <p>File tidak ditemukan.</p>
                    </div>
                @else
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-journal-text fs-1 d-block mb-2"></i>
                        <p>Pilih file dokumentasi dari menu di samping.</p>
                    </div>
                @endif
            </div>
        </div>
    </div>
</div>
@endsection
