<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class MasterEcommerce extends Model
{
    protected $table = 'cms_master_ecommerce';

    protected $fillable = [
        'kode_ecommerce',
        'deskripsi',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];
}
