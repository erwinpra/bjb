<?php

return [

    'enabled' => env('CMS_ENABLED', true),

    'prefix' => env('CMS_PREFIX', 'admin'),

    'middleware' => ['web', 'auth', 'cms.auth'],

    'sidebar' => [
        'groups' => [
            'setting' => [
                'label' => 'Setting',
                'icon' => 'gear',
                'order' => 1,
            ],
            'master' => [
                'label' => 'Master',
                'icon' => 'database',
                'order' => 2,
            ],
            'client' => [
                'label' => 'Client',
                'icon' => 'people',
                'order' => 3,
            ],
        ],
    ],

    'modules' => [
        'role' => [
            'enabled' => true,
            'route' => 'roles',
            'icon' => 'shield-check',
            'label' => 'Roles',
            'group' => 'setting',
        ],
        'user' => [
            'enabled' => true,
            'route' => 'users',
            'icon' => 'people',
            'label' => 'Users',
            'group' => 'setting',
        ],
        'pasal' => [
            'enabled' => true,
            'route' => 'pasal',
            'icon' => 'journal-text',
            'label' => 'Pasal',
            'group' => 'master',
        ],
        'badan' => [
            'enabled' => true,
            'route' => 'badan',
            'icon' => 'building',
            'label' => 'Badan',
            'group' => 'master',
        ],
        'master_rumus' => [
            'enabled' => true,
            'route' => 'master-rumus',
            'icon' => 'calculator',
            'label' => 'Master Rumus',
            'group' => 'master',
        ],
        'data_client' => [
            'enabled' => true,
            'route' => 'data-client',
            'icon' => 'person-badge',
            'label' => 'Data Client',
            'group' => 'client',
        ],
        'transaksi' => [
            'enabled' => true,
            'route' => 'transaksi',
            'icon' => 'arrow-left-right',
            'label' => 'Transaksi',
            'group' => 'client',
        ],
        'client_roles' => [
            'enabled' => false,
            'route' => 'client-roles',
            'icon' => 'person-lock',
            'label' => 'Client Roles',
            'group' => 'setting',
        ],
        'dokumentasi' => [
            'enabled' => true,
            'route' => 'dokumentasi',
            'icon' => 'journal-code',
            'label' => 'Dokumentasi',
            'group' => 'setting',
        ],
        'lampiran_spt' => [
            'enabled' => true,
            'route' => 'lampiran-spt',
            'icon' => 'file-earmark-text',
            'label' => 'Lampiran SPT',
            'group' => 'client',
        ],
        'kategori_lampiran' => [
            'enabled' => true,
            'route' => 'kategori-lampiran',
            'icon' => 'tags',
            'label' => 'Kategori Lampiran',
            'group' => 'master',
        ],
        'master_lampiran_spt' => [
            'enabled' => true,
            'route' => 'master-lampiran-spt',
            'icon' => 'list-check',
            'label' => 'Master Lampiran SPT',
            'group' => 'master',
        ],
        'master_ecommerce' => [
            'enabled' => true,
            'route' => 'master-ecommerce',
            'icon' => 'cart',
            'label' => 'Master Ecommerce',
            'group' => 'master',
        ],
        'activity_log' => [
            'enabled' => true,
            'route' => 'activity-logs',
            'icon' => 'activity',
            'label' => 'Activity Logs',
            'group' => 'setting',
        ],
    ],

    'upload' => [
        'max_size' => env('CMS_UPLOAD_MAX_SIZE', 10 * 1024),
        'allowed_types' => ['jpg', 'jpeg', 'png', 'gif', 'svg', 'pdf', 'doc', 'docx', 'zip'],
        'disk' => env('CMS_UPLOAD_DISK', 'public'),
        'path' => env('CMS_UPLOAD_PATH', 'cms/media'),
    ],

    'page' => [
        'default_template' => 'default',
        'templates' => [
            'default' => [
                'label' => 'Default Template',
                'view' => 'cms::templates.default',
            ],
        ],
    ],

    'auth' => [
        'model' => App\Models\User::class,
        'permissions' => \App\Cms\Acl\PermissionRegistry::class,
    ],
];
