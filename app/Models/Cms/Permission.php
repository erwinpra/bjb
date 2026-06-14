<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Permission extends Model
{
    protected $table = 'cms_permissions';
    public $timestamps = false;

    protected $fillable = ['role_id', 'module', 'action'];
}
