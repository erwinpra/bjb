<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class DataClient extends Model
{
    protected $table = 'cms_data_client';

    protected $fillable = [
        'nama_client',
        'tipe_badan',
        'npwp',
        'kpp',
        'alamat',
        'no_telephone',
    ];
}
