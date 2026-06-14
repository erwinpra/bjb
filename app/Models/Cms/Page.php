<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;

class Page extends Model
{
    protected $table = 'cms_pages';

    protected $fillable = [
        'title',
        'slug',
        'content',
        'meta_title',
        'meta_description',
        'template',
        'status',
        'published_at',
        'author_id',
    ];

    protected $casts = [
        'published_at' => 'datetime',
        'status' => 'boolean',
    ];

    public function author()
    {
        return $this->belongsTo(config('cms.auth.model'), 'author_id');
    }

    public function scopePublished($query)
    {
        return $query->where('status', true);
    }
}
