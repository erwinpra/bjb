<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Transaksi extends Model
{
    protected $table = 'cms_transaksi';

    protected $fillable = [
        'client_id',
        'tahun',
        'tipe_badan_id',
        'npwp_cabang_id',
        'total_omset',
        'total_harta',
        'total_pph',
    ];

    public function client()
    {
        return $this->belongsTo(DataClient::class, 'client_id');
    }

    public function harta()
    {
        return $this->hasMany(TransaksiHarta::class, 'transaksi_id');
    }

    public function omset()
    {
        return $this->hasMany(TransaksiOmset::class, 'transaksi_id');
    }
}

class TransaksiHarta extends Model
{
    protected $table = 'cms_transaksi_harta';
    public $timestamps = false;

    protected $fillable = ['transaksi_id', 'nama', 'nilai'];

    public function transaksi()
    {
        return $this->belongsTo(Transaksi::class, 'transaksi_id');
    }
}

class TransaksiOmset extends Model
{
    protected $table = 'cms_transaksi_omset';
    public $timestamps = false;

    protected $fillable = ['transaksi_id', 'bulan', 'nominal'];

    public function transaksi()
    {
        return $this->belongsTo(Transaksi::class, 'transaksi_id');
    }
}
