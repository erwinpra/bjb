<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMasterRumusTable extends Migration
{
    public function up()
    {
        Schema::create('cms_master_rumus', function (Blueprint $table) {
            $table->id();
            $table->string('tipe_badan', 100);
            $table->decimal('max_value', 18, 2)->default(0);
            $table->decimal('potongan_persentase', 5, 2)->default(0);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_master_rumus');
    }
}
