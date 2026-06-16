<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsTransaksiTables extends Migration
{
    public function up()
    {
        Schema::create('cms_transaksi', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->constrained('cms_data_client')->onDelete('cascade');
            $table->integer('tahun');
            $table->unsignedBigInteger('tipe_badan_id')->nullable();
            $table->decimal('total_omset', 18, 2)->default(0);
            $table->decimal('total_harta', 18, 2)->default(0);
            $table->decimal('total_pph', 18, 2)->default(0);
            $table->timestamps();
        });

        Schema::create('cms_transaksi_harta', function (Blueprint $table) {
            $table->id();
            $table->foreignId('transaksi_id')->constrained('cms_transaksi')->onDelete('cascade');
            $table->string('nama');
            $table->decimal('nilai', 18, 2)->default(0);
        });

        Schema::create('cms_transaksi_omset', function (Blueprint $table) {
            $table->id();
            $table->foreignId('transaksi_id')->constrained('cms_transaksi')->onDelete('cascade');
            $table->unsignedTinyInteger('bulan');
            $table->decimal('nominal', 18, 2)->default(0);
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_transaksi_omset');
        Schema::dropIfExists('cms_transaksi_harta');
        Schema::dropIfExists('cms_transaksi');
    }
}
