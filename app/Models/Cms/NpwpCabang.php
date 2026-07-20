<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class NpwpCabang extends Model
{
    protected $table = 'cms_npwp_cabang';

    protected $fillable = [
        'data_client_id',
        'master_ecommerce_id',
        'nama_client',
        'tipe_badan',
        'client_role_id',
        'npwp',
        'kpp',
        'AR',
        'ptkp',
        'alamat_npwp',
        'alamat_tagihan',
        'no_telephone',
        'email',
        'password',
    ];

    public function masterEcommerce()
    {
        return $this->belongsTo(MasterEcommerce::class, 'master_ecommerce_id');
    }

    protected $hidden = [
        'password',
    ];

    public function dataClient()
    {
        return $this->belongsTo(DataClient::class, 'data_client_id');
    }
}
