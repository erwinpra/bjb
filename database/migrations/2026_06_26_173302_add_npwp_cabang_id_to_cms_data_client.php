<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNpwpCabangIdToCmsDataClient extends Migration
{
    public function up()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->unsignedBigInteger('npwp_cabang_id')->nullable()->after('npwp_cabang');

            $table->foreign('npwp_cabang_id')->references('id')->on('cms_npwp_cabang')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->dropForeign(['npwp_cabang_id']);
            $table->dropColumn('npwp_cabang_id');
        });
    }
}
