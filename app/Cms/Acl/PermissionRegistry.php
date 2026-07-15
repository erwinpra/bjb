<?php

namespace App\Cms\Acl;

class PermissionRegistry
{
    protected static $permissions = [];

    public static function register(string $module, string $action, string $label = null): void
    {
        static::$permissions[$module][$action] = $label ?? ucfirst($action);
    }

    public static function all()
    {
        return static::$permissions;
    }

    public static function modulePermissions(string $module)
    {
        return static::$permissions[$module] ?? [];
    }

    public static function registerDefaults()
    {
        $modules = ['role', 'user', 'pasal', 'badan', 'data_client', 'transaksi', 'master_rumus', 'lampiran_spt', 'kategori_lampiran', 'master_lampiran_spt'];
        foreach ($modules as $module) {
            static::register($module, 'view');
            static::register($module, 'create');
            static::register($module, 'edit');
            static::register($module, 'delete');
        }
    }
}
