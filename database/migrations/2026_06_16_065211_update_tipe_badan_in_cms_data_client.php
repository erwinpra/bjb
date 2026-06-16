<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class UpdateTipeBadanInCmsDataClient extends Migration
{
    public function up()
    {
        $badan = DB::table('cms_badan')->pluck('id', 'tipe');

        DB::table('cms_data_client')
            ->whereNotNull('tipe_badan')
            ->where('tipe_badan', '!=', '')
            ->orderBy('id')
            ->chunk(100, function ($clients) use ($badan) {
                foreach ($clients as $c) {
                    $tipe = $c->tipe_badan;

                    if (is_numeric($tipe)) {
                        continue;
                    }

                    $id = $badan->get($tipe);

                    if ($id) {
                        DB::table('cms_data_client')
                            ->where('id', $c->id)
                            ->update(['tipe_badan' => $id]);
                    }
                }
            });
    }

    public function down()
    {
    }
}
