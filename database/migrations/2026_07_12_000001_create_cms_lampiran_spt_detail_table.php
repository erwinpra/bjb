<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsLampiranSptDetailTable extends Migration
{
    public function up()
    {
        Schema::create('cms_lampiran_spt_detail', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->constrained('cms_data_client')->onDelete('cascade');
            $table->integer('tahun');
            $table->string('kode', 20)->nullable();
            $table->string('deskripsi')->nullable();
            $table->string('nomor_akun', 100)->nullable();
            $table->string('atas_nama')->nullable();
            $table->string('nama_bank_institusi')->nullable();
            $table->string('lokasi_harta')->nullable();
            $table->string('kurs', 10)->nullable();
            $table->integer('tahun_perolehan')->nullable();
            $table->decimal('saldo_saat_ini', 20, 2)->default(0);
            $table->decimal('saldo_bentuk_awal', 20, 2)->default(0);
            $table->decimal('nilai_kurs', 20, 2)->default(0);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_lampiran_spt_detail');
    }
}
