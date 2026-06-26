<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class ClientRole extends Model
{
    protected $table = 'cms_client_roles';

    protected $fillable = [
        'name',
        'slug',
        'description',
        'permissions',
    ];

    protected $casts = [
        'permissions' => 'array',
    ];

    public function clients()
    {
        return $this->hasMany(DataClient::class, 'client_role_id');
    }

    public function hasPermission($permission)
    {
        $perms = $this->permissions ?? [];
        return in_array($permission, $perms);
    }
}
