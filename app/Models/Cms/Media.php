<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Media extends Model
{
    protected $table = 'cms_media';

    protected $fillable = [
        'name',
        'file_name',
        'mime_type',
        'size',
        'disk',
        'path',
        'alt_text',
        'uploaded_by',
    ];

    public function uploader()
    {
        return $this->belongsTo(config('cms.auth.model'), 'uploaded_by');
    }

    public function getUrlAttribute()
    {
        return asset("storage/{$this->path}");
    }
}
