<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Cms\Role;
use App\Models\Cms\Permission;
use App\Models\Cms\Setting;
use App\Models\User;

class CmsSeeder extends Seeder
{
    public function run()
    {
        $adminRole = Role::create([
            'name' => 'Administrator',
            'slug' => 'administrator',
            'description' => 'Full CMS access',
        ]);

        $modules = ['page', 'media', 'menu', 'setting', 'role', 'user'];
        $actions = ['view', 'create', 'edit', 'delete'];

        foreach ($modules as $module) {
            foreach ($actions as $action) {
                $adminRole->permissions()->create([
                    'module' => $module,
                    'action' => $action,
                ]);
            }
        }

        Setting::setValue('site_name', 'My Website', 'general', 'text');
        Setting::setValue('site_description', 'Powered by Laravel CMS', 'general', 'textarea');
        Setting::setValue('contact_email', 'admin@example.com', 'contact', 'text');

        $admin = User::firstOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Admin',
                'password' => bcrypt('password'),
            ]
        );

        $admin->roles()->attach($adminRole);

        $this->command->info('CMS seeded: admin@example.com / password');
    }
}
