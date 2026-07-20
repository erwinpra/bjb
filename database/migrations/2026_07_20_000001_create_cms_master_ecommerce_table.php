<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsMasterEcommerceTable extends Migration
{
    public function up()
    {
        Schema::create('cms_master_ecommerce', function (Blueprint $table) {
            $table->id();
            $table->string('kode_ecommerce', 100)->unique();
            $table->string('deskripsi')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_master_ecommerce');
    }
}
