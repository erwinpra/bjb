<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class KategoriLampiran extends Model
{
    protected $table = 'cms_kategori_lampiran';

    protected $fillable = [
        'label',
    ];

    public function masterLampiranSpts()
    {
        return $this->hasMany(MasterLampiranSpt::class, 'kategori_id');
    }
}
