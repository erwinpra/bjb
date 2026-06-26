<?php

namespace Database\Seeders;

use App\Models\Cms\ClientRole;
use Illuminate\Database\Seeder;

class ClientRolesSeeder extends Seeder
{
    public function run()
    {
        $roles = [
            [
                'name' => 'Super Admin Kantor',
                'slug' => 'super_admin',
                'description' => 'Pimpinan KKP - dapat melihat semua client & transaksi staff',
                'permissions' => ['dashboard.view', 'dashboard.export', 'dashboard.change-password', 'client.view-all', 'client.manage-staff'],
            ],
            [
                'name' => 'Staff/Operator',
                'slug' => 'staff',
                'description' => 'Staff admin - input/edit transaksi, tidak bisa hapus client',
                'permissions' => ['dashboard.view', 'dashboard.export', 'dashboard.change-password', 'client.view-all'],
            ],
            [
                'name' => 'Viewer',
                'slug' => 'viewer',
                'description' => 'Pemilik usaha - hanya lihat dashboard sendiri, tidak bisa export',
                'permissions' => ['dashboard.view'],
            ],
            [
                'name' => 'Client',
                'slug' => 'client',
                'description' => 'Wajib Pajak - akses dashboard standar dengan export',
                'permissions' => ['dashboard.view', 'dashboard.export', 'dashboard.change-password'],
            ],
        ];

        foreach ($roles as $role) {
            ClientRole::updateOrCreate(
                ['slug' => $role['slug']],
                $role
            );
        }
    }
}
