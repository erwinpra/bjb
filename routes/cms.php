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
use App\Http\Controllers\Cms\KategoriLampiranController;
use App\Http\Controllers\Cms\MasterLampiranSptController;
use App\Http\Controllers\Cms\ActivityLogController;

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
            Route::get('data-client/import/template', [DataClientController::class, 'downloadTemplate'])->name('data-client.import.template');
            Route::get('data-client/import', [DataClientController::class, 'showImport'])->name('data-client.import');
            Route::post('data-client/import/preview', [DataClientController::class, 'previewImport'])->name('data-client.import.preview');
            Route::post('data-client/import/confirm', [DataClientController::class, 'confirmImport'])->name('data-client.import.confirm');
            Route::resource('data-client', DataClientController::class)->names('data-client');
        }

        Route::resource('client-roles', ClientRoleController::class)->except(['show'])->names('client-roles');

        Route::get('dokumentasi', [\App\Http\Controllers\Cms\DokumentasiController::class, 'index'])->name('dokumentasi.index');
        Route::get('dokumentasi/{file}', [\App\Http\Controllers\Cms\DokumentasiController::class, 'show'])->name('dokumentasi.show')->where('file', '.*');

        if (config('cms.modules.badan.enabled', true)) {
            Route::get('badan', [BadanController::class, 'index'])->name('badan.index');
            Route::get('badan/create', [BadanController::class, 'create'])->name('badan.create');
            Route::post('badan', [BadanController::class, 'store'])->name('badan.store');
            Route::get('badan/{badan}/edit', [BadanController::class, 'edit'])->name('badan.edit');
            Route::put('badan/{badan}', [BadanController::class, 'update'])->name('badan.update');
            Route::delete('badan/{badan}', [BadanController::class, 'destroy'])->name('badan.destroy');
        }

        if (config('cms.modules.master_rumus.enabled', true)) {
            Route::get('master-rumus', [MasterRumusController::class, 'index'])->name('master-rumus.index');
            Route::get('master-rumus/create', [MasterRumusController::class, 'create'])->name('master-rumus.create');
            Route::post('master-rumus', [MasterRumusController::class, 'store'])->name('master-rumus.store');
            Route::get('master-rumus/{masterRumus}/edit', [MasterRumusController::class, 'edit'])->name('master-rumus.edit');
            Route::put('master-rumus/{masterRumus}', [MasterRumusController::class, 'update'])->name('master-rumus.update');
        }

        if (config('cms.modules.lampiran_spt.enabled', true)) {
            Route::get('lampiran-spt', [LampiranSptController::class, 'index'])->name('lampiran-spt.index');
            Route::post('lampiran-spt', [LampiranSptController::class, 'store'])->name('lampiran-spt.store');
            Route::get('lampiran-spt/master', [LampiranSptController::class, 'editMaster'])->name('lampiran-spt.master');
            Route::get('lampiran-spt/import/template', [LampiranSptController::class, 'downloadTemplate'])->name('lampiran-spt.import.template');
            Route::post('lampiran-spt/import/preview', [LampiranSptController::class, 'previewImport'])->name('lampiran-spt.import.preview');
            Route::post('lampiran-spt/import/confirm', [LampiranSptController::class, 'confirmImport'])->name('lampiran-spt.import.confirm');
            Route::post('lampiran-spt/row', [LampiranSptController::class, 'saveRow'])->name('lampiran-spt.row.save');
            Route::delete('lampiran-spt/row/{id}', [LampiranSptController::class, 'destroyRow'])->name('lampiran-spt.row.destroy');
        }

        if (config('cms.modules.transaksi.enabled', true)) {
            Route::get('transaksi', [\App\Http\Controllers\Cms\TransaksiController::class, 'create'])->name('transaksi.index');
            Route::get('transaksi/create', [\App\Http\Controllers\Cms\TransaksiController::class, 'create'])->name('transaksi.create');
            Route::post('transaksi/preview', [\App\Http\Controllers\Cms\TransaksiController::class, 'preview'])->name('transaksi.preview');
            Route::post('transaksi', [\App\Http\Controllers\Cms\TransaksiController::class, 'store'])->name('transaksi.store');
            Route::post('transaksi/export-pdf', [\App\Http\Controllers\Cms\TransaksiController::class, 'exportPdf'])->name('transaksi.export-pdf');
            Route::post('transaksi/export-excel', [\App\Http\Controllers\Cms\TransaksiController::class, 'exportExcel'])->name('transaksi.export-excel');
            Route::get('transaksi/load-data', [\App\Http\Controllers\Cms\TransaksiController::class, 'loadData'])->name('transaksi.load-data');
            Route::get('transaksi/check-harta', [\App\Http\Controllers\Cms\TransaksiController::class, 'checkHarta'])->name('transaksi.check-harta');
            Route::post('transaksi/save-harta-ajax', [\App\Http\Controllers\Cms\TransaksiController::class, 'saveHartaAjax'])->name('transaksi.save-harta-ajax');
            Route::get('transaksi/cabangs/{client}', [\App\Http\Controllers\Cms\TransaksiController::class, 'getCabangs'])->name('transaksi.cabangs');
            Route::get('transaksi/import/template', [\App\Http\Controllers\Cms\TransaksiController::class, 'downloadTemplate'])->name('transaksi.import.template');
            Route::get('transaksi/import', [\App\Http\Controllers\Cms\TransaksiController::class, 'showImport'])->name('transaksi.import');
            Route::post('transaksi/import/preview', [\App\Http\Controllers\Cms\TransaksiController::class, 'previewImport'])->name('transaksi.import.preview');
            Route::post('transaksi/import/confirm', [\App\Http\Controllers\Cms\TransaksiController::class, 'confirmImport'])->name('transaksi.import.confirm');
        }

        if (config('cms.modules.kategori_lampiran.enabled', true)) {
            Route::resource('kategori-lampiran', KategoriLampiranController::class)->names('kategori-lampiran');
        }
        if (config('cms.modules.master_lampiran_spt.enabled', true)) {
            Route::resource('master-lampiran-spt', MasterLampiranSptController::class)->names('master-lampiran-spt');
        }
        if (config('cms.modules.activity_log.enabled', true)) {
            Route::get('activity-logs', [ActivityLogController::class, 'index'])->name('activity-logs.index');
            Route::get('activity-logs/{activityLog}', [ActivityLogController::class, 'show'])->name('activity-logs.show');
            Route::delete('activity-logs/{activityLog}', [ActivityLogController::class, 'destroy'])->name('activity-logs.destroy');
            Route::post('activity-logs/clear', [ActivityLogController::class, 'clear'])->name('activity-logs.clear')->middleware('cms.permission:activity_log,delete');
        }
    });
