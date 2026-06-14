<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $table = 'cms_roles';

    protected $fillable = ['name', 'slug', 'description'];

    public function permissions()
    {
        return $this->hasMany(Permission::class);
    }

    public function users()
    {
        return $this->belongsToMany(config('cms.auth.model'), 'cms_role_user', 'role_id', 'user_id');
    }

    public function hasPermission(string $module, string $action): bool
    {
        return $this->permissions()
            ->where('module', $module)
            ->where('action', $action)
            ->exists();
    }
}
