<?php

namespace App\Cms;

use Illuminate\Support\ServiceProvider;
use App\Cms\Modules\ModuleManager;
use App\Cms\Acl\PermissionRegistry;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\View;

class CmsServiceProvider extends ServiceProvider
{
    public function register()
    {
        if (!config('cms.enabled')) {
            return;
        }

        $this->mergeConfigFrom(config_path('cms.php'), 'cms');

        $this->app->singleton(ModuleManager::class, function () {
            return new ModuleManager();
        });

        PermissionRegistry::registerDefaults();
    }

    public function boot()
    {
        if (!config('cms.enabled')) {
            return;
        }

        $this->loadMigrations();
        $this->loadViews();
        $this->loadRoutes();
        $this->loadBladeDirectives();
        $this->registerModules();
        $this->shareViewData();
    }

    protected function loadMigrations()
    {
        $this->loadMigrationsFrom(database_path('migrations'));
    }

    protected function loadViews()
    {
        $this->loadViewsFrom(resource_path('views/cms'), 'cms');
    }

    protected function loadRoutes()
    {
        $this->loadRoutesFrom(base_path('routes/cms.php'));
    }

    protected function loadBladeDirectives()
    {
        Blade::directive('cmsModule', function ($expression) {
            return "<?php if(app('\\App\\Cms\\Modules\\ModuleManager')->get($expression)?->isEnabled()): ?>";
        });

        Blade::directive('endCmsModule', function () {
            return '<?php endif; ?>';
        });

        Blade::directive('cmsSetting', function ($expression) {
            return "<?php echo \\App\\Models\\Cms\\Setting::getValue($expression); ?>";
        });

        Blade::directive('cmsCan', function ($expression) {
            return "<?php if(auth()->check() && auth()->user()->hasCmsPermission({$expression})): ?>";
        });

        Blade::directive('endCmsCan', function () {
            return '<?php endif; ?>';
        });
    }

    protected function registerModules()
    {
        $manager = app(ModuleManager::class);
        $manager->loadFromConfig();

        foreach ($manager->enabled() as $module) {
            $module->register();
        }
    }

    protected function shareViewData()
    {
        View::composer('cms::*', function ($view) {
            $manager = app(ModuleManager::class);
            $view->with('cmsModules', $manager->enabled());
            $view->with('cmsMenu', $manager->menuItems());
        });
    }
}
