<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsNpwpCabangTable extends Migration
{
    public function up()
    {
        Schema::create('cms_npwp_cabang', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('data_client_id')->nullable();
            $table->string('nama_client');
            $table->string('tipe_badan', 100)->nullable();
            $table->unsignedBigInteger('client_role_id')->nullable();
            $table->string('npwp', 50)->nullable();
            $table->string('kpp', 50)->nullable();
            $table->string('AR', 100)->nullable();
            $table->string('ptkp', 50)->nullable();
            $table->text('alamat_npwp')->nullable();
            $table->text('alamat_tagihan')->nullable();
            $table->string('no_telephone', 30)->nullable();
            $table->string('email')->nullable();
            $table->string('password')->nullable();
            $table->timestamps();

            $table->foreign('data_client_id')->references('id')->on('cms_data_client')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_npwp_cabang');
    }
}
