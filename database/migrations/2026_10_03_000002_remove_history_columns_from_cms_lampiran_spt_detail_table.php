<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveHistoryColumnsFromCmsLampiranSptDetailTable extends Migration
{
    public function up()
    {
        Schema::table('cms_lampiran_spt_detail', function (Blueprint $table) {
            $table->dropColumn(['nilai_2024', 'nilai_2023', 'nilai_2022', 'nilai_2021', 'nilai_2020']);
        });
    }

    public function down()
    {
        Schema::table('cms_lampiran_spt_detail', function (Blueprint $table) {
            $table->decimal('nilai_2024', 20, 2)->nullable();
            $table->decimal('nilai_2023', 20, 2)->nullable();
            $table->decimal('nilai_2022', 20, 2)->nullable();
            $table->decimal('nilai_2021', 20, 2)->nullable();
            $table->decimal('nilai_2020', 20, 2)->nullable();
        });
    }
}
