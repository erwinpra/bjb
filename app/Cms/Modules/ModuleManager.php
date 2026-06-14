<?php

namespace App\Cms\Modules;

use App\Cms\Contracts\ModuleInterface;
use Illuminate\Support\Collection;

class ModuleManager
{
    protected $modules = [];

    public function register(ModuleInterface $module)
    {
        $this->modules[$module->getName()] = $module;
    }

    public function get($name)
    {
        return $this->modules[$name] ?? null;
    }

    public function all()
    {
        return $this->modules;
    }

    public function enabled()
    {
        return array_filter($this->modules, function ($m) { return $m->isEnabled(); });
    }

    public function loadFromConfig()
    {
        $config = config('cms.modules', []);
        $map = [
            'role' => RoleModule::class,
            'user' => UserModule::class,
            'pasal' => PasalModule::class,
            'data_client' => DataClientModule::class,
            'transaksi' => TransaksiModule::class,
            'badan' => BadanModule::class,
            'master_rumus' => MasterRumusModule::class,
        ];

        foreach ($config as $key => $cfg) {
            if (isset($map[$key]) && ($cfg['enabled'] ?? false)) {
                $module = app($map[$key]);
                $this->register($module);
            }
        }
    }

    public function menuItems()
    {
        $items = [];
        foreach ($this->enabled() as $module) {
            $menu = $module->getMenu();
            if ($menu) {
                $items[] = $menu;
            }
        }
        return $items;
    }
}
