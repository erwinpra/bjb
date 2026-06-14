<?php

namespace App\Cms\Facades;

use Illuminate\Support\Facades\Facade;

class Cms extends Facade
{
    protected static function getFacadeAccessor()
    {
        return \App\Cms\Modules\ModuleManager::class;
    }
}
