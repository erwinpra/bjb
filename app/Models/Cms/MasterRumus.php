<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class MasterRumus extends Model
{
    protected $table = 'cms_master_rumus';

    protected $fillable = [
        'tipe_badan',
        'max_value',
        'potongan_persentase',
    ];

    public function badan()
    {
        return $this->belongsTo(Badan::class, 'tipe_badan', 'id');
    }
}
