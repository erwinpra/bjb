<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddCortexFieldsToCmsLampiranSptDetailTable extends Migration
{
    public function up()
    {
        Schema::table('cms_lampiran_spt_detail', function (Blueprint $table) {
            $table->unsignedBigInteger('kategori_id')->nullable()->after('client_id');
            $table->string('sheet_code', 10)->nullable()->after('kategori_id');
            $table->decimal('harga_perolehan', 20, 2)->default(0)->after('nilai_kurs');
            // Field spesifik per sheet (semua nullable biar flat)
            $table->string('merk_tipe')->nullable();          // INVEST nama institusi / BERGERAK merk-model-tipe
            $table->string('nopol_sertifikat')->nullable();   // BERGERAK nopol / TDK BERGERAK no sertifikat / LAINNYA bukti akun
            $table->string('kepemilikan')->nullable();        // BERGERAK milik sendiri/orang lain
            $table->string('nik_npwp_pihak', 50)->nullable(); // PIUTANG/HUTANG/BERGERAK nik-npwp pihak
            $table->string('nama_pihak')->nullable();         // PIUTANG/HUTANG/BERGERAK nama pihak
            $table->string('negara_kreditur', 50)->nullable();// HUTANG negara kreditur
            $table->string('ukuran_tanah', 50)->nullable();   // TDK BERGERAK
            $table->string('ukuran_bangunan', 50)->nullable();// TDK BERGERAK
            $table->string('sumber_kepemilikan', 50)->nullable();
            $table->text('detail_info')->nullable();          // detail lokasi / info tambahan / keterangan / NOP
            $table->integer('tahun_mulai')->nullable();       // PIUTANG tahun dimulai / HUTANG tahun peminjaman
            $table->decimal('nilai_2024', 20, 2)->nullable();
            $table->decimal('nilai_2023', 20, 2)->nullable();
            $table->decimal('nilai_2022', 20, 2)->nullable();
            $table->decimal('nilai_2021', 20, 2)->nullable();
            $table->decimal('nilai_2020', 20, 2)->nullable();
        });
    }

    public function down()
    {
        Schema::table('cms_lampiran_spt_detail', function (Blueprint $table) {
            $table->dropColumn([
                'kategori_id', 'sheet_code', 'harga_perolehan',
                'merk_tipe', 'nopol_sertifikat', 'kepemilikan',
                'nik_npwp_pihak', 'nama_pihak', 'negara_kreditur',
                'ukuran_tanah', 'ukuran_bangunan', 'sumber_kepemilikan',
                'detail_info', 'tahun_mulai',
                'nilai_2024', 'nilai_2023', 'nilai_2022', 'nilai_2021', 'nilai_2020',
            ]);
        });
    }
}
