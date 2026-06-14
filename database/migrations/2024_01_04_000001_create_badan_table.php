<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBadanTable extends Migration
{
    public function up()
    {
        Schema::create('cms_badan', function (Blueprint $table) {
            $table->id();
            $table->string('tipe');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_badan');
    }
}
