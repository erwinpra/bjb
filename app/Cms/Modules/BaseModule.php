<?php

namespace App\Cms\Modules;

use App\Cms\Contracts\ModuleInterface;
use App\Cms\Acl\PermissionRegistry;

abstract class BaseModule implements ModuleInterface
{
    protected $config;

    public function __construct()
    {
        $this->config = config("cms.modules.{$this->getName()}", []);
    }

    public function isEnabled()
    {
        return $this->config['enabled'] ?? true;
    }

    public function getLabel()
    {
        return $this->config['label'] ?? ucfirst($this->getName());
    }

    public function getIcon()
    {
        return $this->config['icon'] ?? 'circle';
    }

    public function getGroup()
    {
        return $this->config['group'] ?? null;
    }

    public function getRoute()
    {
        return $this->config['route'] ?? $this->getName();
    }

    public function register()
    {
        PermissionRegistry::register($this->getName(), 'view', "View {$this->getLabel()}");
        PermissionRegistry::register($this->getName(), 'create', "Create {$this->getLabel()}");
        PermissionRegistry::register($this->getName(), 'edit', "Edit {$this->getLabel()}");
        PermissionRegistry::register($this->getName(), 'delete', "Delete {$this->getLabel()}");
    }

    public function getMenu()
    {
        if (!$this->isEnabled()) {
            return null;
        }
        return [
            'label' => $this->getLabel(),
            'icon' => $this->getIcon(),
            'route' => "cms.{$this->getRoute()}.index",
            'active' => "cms.{$this->getRoute()}.*",
        ];
    }

    public function getPermissions()
    {
        return PermissionRegistry::modulePermissions($this->getName());
    }
}
