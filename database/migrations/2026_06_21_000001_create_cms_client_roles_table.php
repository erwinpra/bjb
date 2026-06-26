<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsClientRolesTable extends Migration
{
    public function up()
    {
        Schema::create('cms_client_roles', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug')->unique();
            $table->text('description')->nullable();
            $table->json('permissions')->nullable();
            $table->timestamps();
        });

        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->unsignedBigInteger('client_role_id')->nullable()->after('tipe_badan');
            $table->foreign('client_role_id')->references('id')->on('cms_client_roles')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('cms_data_client', function (Blueprint $table) {
            $table->dropForeign(['client_role_id']);
            $table->dropColumn('client_role_id');
        });
        Schema::dropIfExists('cms_client_roles');
    }
}
