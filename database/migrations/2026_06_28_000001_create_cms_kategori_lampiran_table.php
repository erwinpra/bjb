<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsKategoriLampiranTable extends Migration
{
    public function up()
    {
        Schema::create('cms_kategori_lampiran', function (Blueprint $table) {
            $table->id();
            $table->string('label');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_kategori_lampiran');
    }
}
