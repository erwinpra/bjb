<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePasalTable extends Migration
{
    public function up()
    {
        Schema::create('cms_pasal', function (Blueprint $table) {
            $table->id();
            $table->string('nama_pasal');
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_pasal');
    }
}
