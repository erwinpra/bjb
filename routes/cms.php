<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Cms\DashboardController;
use App\Http\Controllers\Cms\RoleController;
use App\Http\Controllers\Cms\UserController;
use App\Http\Controllers\Cms\PasalController;
use App\Http\Controllers\Cms\DataClientController;
use App\Http\Controllers\Cms\BadanController;
use App\Http\Controllers\Cms\MasterRumusController;

$prefix = config('cms.prefix', 'admin');
$middleware = config('cms.middleware', ['web', 'auth']);

Route::prefix($prefix)
    ->middleware($middleware)
    ->name('cms.')
    ->group(function () {

        Route::get('/', [DashboardController::class, 'index'])->name('dashboard');

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
            Route::resource('data-client', DataClientController::class)->names('data-client');
        }

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

        if (config('cms.modules.transaksi.enabled', true)) {
            Route::get('transaksi', [\App\Http\Controllers\Cms\TransaksiController::class, 'create'])->name('transaksi.index');
            Route::get('transaksi/create', [\App\Http\Controllers\Cms\TransaksiController::class, 'create'])->name('transaksi.create');
            Route::post('transaksi/preview', [\App\Http\Controllers\Cms\TransaksiController::class, 'preview'])->name('transaksi.preview');
        }
    });
