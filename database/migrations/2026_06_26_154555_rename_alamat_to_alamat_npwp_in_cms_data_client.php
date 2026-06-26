<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class RenameAlamatToAlamatNpwpInCmsDataClient extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('ALTER TABLE cms_data_client CHANGE alamat alamat_npwp TEXT NULL');
    }

    public function down()
    {
        DB::statement('ALTER TABLE cms_data_client CHANGE alamat_npwp alamat TEXT NULL');
    }
}
