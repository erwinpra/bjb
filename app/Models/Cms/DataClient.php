<?php

namespace App\Models\Cms;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Model;

class DataClient extends Model implements AuthenticatableContract
{
    use Authenticatable;

    protected $table = 'cms_data_client';

    protected $fillable = [
        'nama_client',
        'tipe_badan',
        'client_role_id',
        'npwp',
        'npwp_cabang',
        'npwp_cabang_id',
        'kpp',
        'AR',
        'ptkp',
        'alamat_npwp',
        'alamat_tagihan',
        'no_telephone',
        'email',
        'password',
    ];

    protected $hidden = [
        'password',
    ];

    public function badan()
    {
        return $this->belongsTo(Badan::class, 'tipe_badan', 'id');
    }

    public function transaksi()
    {
        return $this->hasMany(Transaksi::class, 'client_id');
    }

    public function clientRole()
    {
        return $this->belongsTo(ClientRole::class, 'client_role_id');
    }

    public function npwpCabangRel()
    {
        return $this->belongsTo(NpwpCabang::class, 'npwp_cabang_id');
    }

    public function cabangs()
    {
        return $this->hasMany(NpwpCabang::class, 'data_client_id');
    }

    public function hasClientPermission($permission)
    {
        return $this->clientRole && $this->clientRole->hasPermission($permission);
    }

    public function isClientRole($slug)
    {
        return $this->clientRole && $this->clientRole->slug === $slug;
    }
}
