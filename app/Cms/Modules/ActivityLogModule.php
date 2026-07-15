<?php

namespace App\Cms\Modules;

use App\Cms\Acl\PermissionRegistry;

class ActivityLogModule extends BaseModule
{
    public function getName(): string
    {
        return 'activity_log';
    }

    public function register()
    {
        PermissionRegistry::register($this->getName(), 'view', "View {$this->getLabel()}");
        PermissionRegistry::register($this->getName(), 'delete', "Delete {$this->getLabel()}");
    }
}
