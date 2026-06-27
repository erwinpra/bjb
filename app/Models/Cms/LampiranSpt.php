<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class LampiranSpt extends Model
{
    protected $table = 'cms_lampiran_spt';

    protected $fillable = [
        'client_id',
        'npwp_cabang_id',
        'tahun',
        'lampiran_spt_id',
        'nilai',
    ];

    public function client()
    {
        return $this->belongsTo(DataClient::class, 'client_id');
    }

    public function masterItem()
    {
        return $this->belongsTo(MasterLampiranSpt::class, 'lampiran_spt_id');
    }

    public function scopeForClient($query, $clientId, $tahun)
    {
        return $query->where('client_id', $clientId)->where('tahun', $tahun);
    }
}
