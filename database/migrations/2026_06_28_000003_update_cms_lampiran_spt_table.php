<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateCmsLampiranSptTable extends Migration
{
    public function up()
    {
        Schema::table('cms_lampiran_spt', function (Blueprint $table) {
            $table->dropColumn(['kategori', 'sub_kode', 'sub_nama']);
            $table->foreignId('lampiran_spt_id')->nullable()->after('tahun')
                ->constrained('cms_master_lampiran_spt')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::table('cms_lampiran_spt', function (Blueprint $table) {
            $table->dropForeign(['lampiran_spt_id']);
            $table->dropColumn('lampiran_spt_id');
            $table->string('kategori');
            $table->string('sub_kode');
            $table->string('sub_nama');
        });
    }
}
