<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class MasterLampiranSpt extends Model
{
    protected $table = 'cms_master_lampiran_spt';

    protected $fillable = [
        'kategori_id',
        'sub_kode',
        'nama',
    ];

    public function kategori()
    {
        return $this->belongsTo(KategoriLampiran::class, 'kategori_id');
    }
}
