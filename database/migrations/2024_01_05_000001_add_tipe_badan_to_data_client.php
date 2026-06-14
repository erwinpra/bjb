<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddTipeBadanToDataClient extends Migration
{
    public function up()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->string('tipe_badan', 100)->nullable()->after('nama_client');
        });
    }

    public function down()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->dropColumn('tipe_badan');
        });
    }
}
