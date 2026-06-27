<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNpwpCabangIdToCmsLampiranSpt extends Migration
{
    public function up()
    {
        Schema::table('cms_lampiran_spt', function (Blueprint $table) {
            $table->unsignedBigInteger('npwp_cabang_id')->nullable()->after('client_id');
            $table->foreign('npwp_cabang_id')->references('id')->on('cms_npwp_cabang')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::table('cms_lampiran_spt', function (Blueprint $table) {
            $table->dropForeign(['npwp_cabang_id']);
            $table->dropColumn('npwp_cabang_id');
        });
    }
}
