<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddIsActiveToCmsMasterLampiranSptTable extends Migration
{
    public function up()
    {
        Schema::table('cms_master_lampiran_spt', function (Blueprint $table) {
            $table->boolean('is_active')->default(true)->after('nama');
        });
    }

    public function down()
    {
        Schema::table('cms_master_lampiran_spt', function (Blueprint $table) {
            $table->dropColumn('is_active');
        });
    }
}
