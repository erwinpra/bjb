<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNpwpCabangIdToCmsTransaksi extends Migration
{
    public function up()
    {
        Schema::table('cms_transaksi', function (Blueprint $table) {
            $table->foreignId('npwp_cabang_id')->nullable()->constrained('cms_npwp_cabang')->onDelete('cascade');
            $table->unique(['client_id', 'npwp_cabang_id', 'tahun'], 'transaksi_client_cabang_tahun_unique');
        });
    }

    public function down()
    {
        Schema::table('cms_transaksi', function (Blueprint $table) {
            $table->dropForeign(['npwp_cabang_id']);
            $table->dropColumn('npwp_cabang_id');
            $table->dropUnique('transaksi_client_cabang_tahun_unique');
        });
    }
}
