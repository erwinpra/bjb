<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDataClientTable extends Migration
{
    public function up()
    {
        Schema::create('cms_data_client', function (Blueprint $table) {
            $table->id();
            $table->string('nama_client');
            $table->string('npwp', 50)->nullable();
            $table->string('kpp', 50)->nullable();
            $table->text('alamat')->nullable();
            $table->string('no_telephone', 30)->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_data_client');
    }
}
