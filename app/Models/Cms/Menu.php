<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $table = 'cms_menus';

    protected $fillable = ['name', 'slug', 'description'];

    public function items()
    {
        return $this->hasMany(MenuItem::class)->orderBy('order');
    }

    public function activeItems()
    {
        return $this->items()->where('status', true);
    }
}
