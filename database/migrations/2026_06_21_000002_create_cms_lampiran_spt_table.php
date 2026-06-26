<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsLampiranSptTable extends Migration
{
    public function up()
    {
        Schema::create('cms_lampiran_spt', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->nullable()->constrained('cms_data_client')->onDelete('cascade');
            $table->integer('tahun')->nullable();
            $table->string('kategori');
            $table->string('sub_kode');
            $table->string('sub_nama');
            $table->decimal('nilai', 18, 2)->default(0);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_lampiran_spt');
    }
}
