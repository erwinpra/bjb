<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class LampiranSptDetail extends Model
{
    protected $table = 'cms_lampiran_spt_detail';

    protected $fillable = [
        'client_id',
        'kategori_id',
        'sheet_code',
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
        'harga_perolehan',
        'merk_tipe',
        'nopol_sertifikat',
        'kepemilikan',
        'nik_npwp_pihak',
        'nama_pihak',
        'negara_kreditur',
        'ukuran_tanah',
        'ukuran_bangunan',
        'sumber_kepemilikan',
        'detail_info',
        'tahun_mulai',
    ];

    public function client()
    {
        return $this->belongsTo(DataClient::class, 'client_id');
    }

    public function masterItem()
    {
        return $this->belongsTo(MasterLampiranSpt::class, 'kode', 'sub_kode');
    }
}
