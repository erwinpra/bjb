<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsMasterLampiranSptTable extends Migration
{
    public function up()
    {
        Schema::dropIfExists('cms_master_lampiran_spt');

        Schema::create('cms_master_lampiran_spt', function (Blueprint $table) {
            $table->id();
            $table->foreignId('kategori_id')->constrained('cms_kategori_lampiran')->onDelete('cascade');
            $table->string('sub_kode');
            $table->string('nama');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_master_lampiran_spt');
    }
}
