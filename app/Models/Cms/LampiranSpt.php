<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class LampiranSpt extends Model
{
    protected $table = 'cms_lampiran_spt';

    protected $fillable = [
        'client_id',
        'tahun',
        'kategori',
        'sub_kode',
        'sub_nama',
        'nilai',
    ];

    public function client()
    {
        return $this->belongsTo(DataClient::class, 'client_id');
    }

    public function scopeMaster($query)
    {
        return $query->whereNull('client_id')->whereNull('tahun');
    }

    public function scopeForClient($query, $clientId, $tahun)
    {
        return $query->where('client_id', $clientId)->where('tahun', $tahun);
    }
}
