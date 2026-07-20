<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddMasterEcommerceIdToCmsNpwpCabangTable extends Migration
{
    public function up()
    {
        Schema::table('cms_npwp_cabang', function (Blueprint $table) {
            $table->unsignedBigInteger('master_ecommerce_id')->nullable()->after('data_client_id');
            $table->foreign('master_ecommerce_id')->references('id')->on('cms_master_ecommerce')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('cms_npwp_cabang', function (Blueprint $table) {
            $table->dropForeign(['master_ecommerce_id']);
            $table->dropColumn('master_ecommerce_id');
        });
    }
}
