<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use App\Models\Cms\Role;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function roles()
    {
        return $this->belongsToMany(Role::class, 'cms_role_user', 'user_id', 'role_id');
    }

    public function canAccessCms(): bool
    {
        return $this->roles()->exists();
    }

    public function hasCmsPermission(string $module, string $action): bool
    {
        foreach ($this->roles as $role) {
            if ($role->hasPermission($module, $action)) {
                return true;
            }
        }
        return false;
    }
}
