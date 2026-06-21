<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddArAndPtkpToCmsDataClient extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->string('AR', 100)->nullable()->after('kpp');
            $table->string('ptkp', 50)->nullable()->after('AR');
        });
    }

    public function down()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->dropColumn(['AR', 'ptkp']);
        });
    }
}
