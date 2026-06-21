<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddEmailPasswordToCmsDataClient extends Migration
{
    public function up()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->string('email')->nullable()->unique()->after('no_telephone');
            $table->string('password')->nullable()->after('email');
        });
    }

    public function down()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->dropColumn(['email', 'password']);
        });
    }
}
