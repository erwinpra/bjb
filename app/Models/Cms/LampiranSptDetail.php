<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class LampiranSptDetail extends Model
{
    protected $table = 'cms_lampiran_spt_detail';

    protected $fillable = [
        'client_id',
        'tahun',
        'kode',
        'deskripsi',
        'nomor_akun',
        'atas_nama',
        'nama_bank_institusi',
        'lokasi_harta',
        'kurs',
        'tahun_perolehan',
        'saldo_saat_ini',
        'saldo_bentuk_awal',
        'nilai_kurs',
    ];

    public function client()
    {
        return $this->belongsTo(DataClient::class, 'client_id');
    }
}
