<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Cms\DashboardController;
use App\Http\Controllers\Cms\RoleController;
use App\Http\Controllers\Cms\UserController;
use App\Http\Controllers\Cms\PasalController;
use App\Http\Controllers\Cms\DataClientController;
use App\Http\Controllers\Cms\BadanController;
use App\Http\Controllers\Cms\MasterRumusController;
use App\Http\Controllers\Cms\ClientRoleController;
use App\Http\Controllers\Cms\LampiranSptController;

$prefix = config('cms.prefix', 'admin');
$middleware = config('cms.middleware', ['web', 'auth']);

Route::prefix($prefix)
    ->middleware($middleware)
    ->name('cms.')
    ->group(function () {

        Route::get('/', [DashboardController::class, 'index'])->name('dashboard');
        Route::get('profile', [\App\Http\Controllers\AuthController::class, 'showProfile'])->name('profile');
        Route::post('profile/password', [\App\Http\Controllers\AuthController::class, 'updatePassword'])->name('profile.password');

        if (config('cms.modules.role.enabled', true)) {
            Route::resource('roles', RoleController::class)->names('roles');
        }

        if (config('cms.modules.user.enabled', true)) {
            Route::resource('users', UserController::class)->names('users');
        }

        if (config('cms.modules.pasal.enabled', true)) {
            Route::resource('pasal', PasalController::class)->names('pasal');
        }

        if (config('cms.modules.data_client.enabled', true)) {
            Route::resource('data-client', DataClientController::class)->except(['show'])->names('data-client');
            Route::get('data-client/import/template', [DataClientController::class, 'downloadTemplate'])->name('data-client.import.template');
            Route::get('data-client/import', [DataClientController::class, 'showImport'])->name('data-client.import');
            Route::post('data-client/import/preview', [DataClientController::class, 'previewImport'])->name('data-client.import.preview');
            Route::post('data-client/import/confirm', [DataClientController::class, 'confirmImport'])->name('data-client.import.confirm');
        }

        Route::resource('client-roles', ClientRoleController::class)->except(['show'])->names('client-roles');

        Route::get('dokumentasi', [\App\Http\Controllers\Cms\DokumentasiController::class, 'index'])->name('dokumentasi.index');
        Route::get('dokumentasi/{file}', [\App\Http\Controllers\Cms\DokumentasiController::class, 'show'])->name('dokumentasi.show')->where('file', '.*');

        if (config('cms.modules.badan.enabled', true)) {
            Route::get('badan', [BadanController::class, 'index'])->name('badan.index');
            Route::get('badan/{badan}/edit', [BadanController::class, 'edit'])->name('badan.edit');
            Route::put('badan/{badan}', [BadanController::class, 'update'])->name('badan.update');
        }

        if (config('cms.modules.master_rumus.enabled', true)) {
            Route::get('master-rumus', [MasterRumusController::class, 'index'])->name('master-rumus.index');
            Route::get('master-rumus/{masterRumus}/edit', [MasterRumusController::class, 'edit'])->name('master-rumus.edit');
            Route::put('master-rumus/{masterRumus}', [MasterRumusController::class, 'update'])->name('master-rumus.update');
        }

        if (config('cms.modules.lampiran_spt.enabled', true)) {
            Route::get('lampiran-spt', [LampiranSptController::class, 'index'])->name('lampiran-spt.index');
            Route::post('lampiran-spt', [LampiranSptController::class, 'store'])->name('lampiran-spt.store');
            Route::get('lampiran-spt/master', [LampiranSptController::class, 'editMaster'])->name('lampiran-spt.master');
            Route::get('lampiran-spt/dashboard', [LampiranSptController::class, 'dashboard'])->name('lampiran-spt.dashboard');
        }

        if (config('cms.modules.transaksi.enabled', true)) {
            Route::get('transaksi', [\App\Http\Controllers\Cms\TransaksiController::class, 'create'])->name('transaksi.index');
            Route::get('transaksi/create', [\App\Http\Controllers\Cms\TransaksiController::class, 'create'])->name('transaksi.create');
            Route::post('transaksi/preview', [\App\Http\Controllers\Cms\TransaksiController::class, 'preview'])->name('transaksi.preview');
            Route::post('transaksi', [\App\Http\Controllers\Cms\TransaksiController::class, 'store'])->name('transaksi.store');
            Route::post('transaksi/export-pdf', [\App\Http\Controllers\Cms\TransaksiController::class, 'exportPdf'])->name('transaksi.export-pdf');
            Route::post('transaksi/export-excel', [\App\Http\Controllers\Cms\TransaksiController::class, 'exportExcel'])->name('transaksi.export-excel');
            Route::get('transaksi/load-data', [\App\Http\Controllers\Cms\TransaksiController::class, 'loadData'])->name('transaksi.load-data');
        }
    });
