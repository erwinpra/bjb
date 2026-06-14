<?php

namespace App\Cms\Contracts;

interface ModuleInterface
{
    public function getName();
    public function getLabel();
    public function getIcon();
    public function getRoute();
    public function getGroup();
    public function isEnabled();
    public function register();
    public function getPermissions();
    public function getMenu();
}
