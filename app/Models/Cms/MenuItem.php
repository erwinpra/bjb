<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class MenuItem extends Model
{
    protected $table = 'cms_menu_items';

    protected $fillable = [
        'menu_id',
        'parent_id',
        'label',
        'url',
        'route',
        'icon',
        'target',
        'order',
        'status',
    ];

    protected $casts = ['status' => 'boolean'];

    public function menu()
    {
        return $this->belongsTo(Menu::class);
    }

    public function children()
    {
        return $this->hasMany(MenuItem::class, 'parent_id')->orderBy('order');
    }

    public function parent()
    {
        return $this->belongsTo(MenuItem::class, 'parent_id');
    }
}
