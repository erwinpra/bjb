<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNpwpCabangToCmsDataClient extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->string('npwp_cabang', 50)->nullable()->after('npwp');
        });
    }

    public function down()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->dropColumn('npwp_cabang');
        });
    }
}
