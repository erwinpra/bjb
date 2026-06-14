<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    protected $table = 'cms_settings';
    public $timestamps = false;

    protected $fillable = ['key', 'value', 'group', 'type'];

    protected $casts = ['value' => 'string'];

    public static function getValue(string $key, $default = null)
    {
        $setting = static::where('key', $key)->first();
        return $setting ? $setting->value : $default;
    }

    public static function setValue(string $key, $value, string $group = 'general', string $type = 'text'): void
    {
        static::updateOrCreate(
            ['key' => $key],
            ['value' => $value, 'group' => $group, 'type' => $type]
        );
    }

    public static function getGroup(string $group): array
    {
        return static::where('group', $group)->pluck('value', 'key')->toArray();
    }
}
