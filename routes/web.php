<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::middleware('guest')->group(function () {
    Route::get('login', [App\Http\Controllers\AuthController::class, 'showLogin'])->name('login');
    Route::post('login', [App\Http\Controllers\AuthController::class, 'login']);
});

Route::post('logout', [App\Http\Controllers\AuthController::class, 'logout'])->name('logout');

// Client area
Route::prefix('client')->name('client.')->group(function () {
    Route::middleware('guest:client')->group(function () {
        Route::get('login', [App\Http\Controllers\Client\AuthController::class, 'showLogin'])->name('login');
        Route::post('login', [App\Http\Controllers\Client\AuthController::class, 'login'])->name('login');
    });

    Route::middleware('auth:client')->group(function () {
        Route::post('logout', [App\Http\Controllers\Client\AuthController::class, 'logout'])->name('logout');
        Route::post('change-password', [App\Http\Controllers\Client\AuthController::class, 'changePassword'])->name('change-password');
        Route::get('dashboard', [App\Http\Controllers\Client\DashboardController::class, 'index'])->name('dashboard');
        Route::get('dashboard/data', [App\Http\Controllers\Client\DashboardController::class, 'data'])->name('dashboard.data');
        Route::get('dashboard/export-pdf', [App\Http\Controllers\Client\DashboardController::class, 'exportPdf'])->name('dashboard.export-pdf');
        Route::get('dashboard/export-excel', [App\Http\Controllers\Client\DashboardController::class, 'exportExcel'])->name('dashboard.export-excel');
    });
});
