<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Pasal extends Model
{
    protected $table = 'cms_pasal';

    protected $fillable = ['nama_pasal', 'is_active'];

    protected $casts = ['is_active' => 'boolean'];
}
