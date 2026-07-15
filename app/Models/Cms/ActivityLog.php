<?php

namespace App\Models\Cms;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class ActivityLog extends Model
{
    protected $table = 'cms_activity_logs';

    protected $fillable = [
        'user_id', 'action', 'module', 'target_id', 'description', 'ip_address', 'user_agent',
    ];

    public function user()
    {
        return $this->belongsTo(config('cms.auth.model'), 'user_id');
    }

    public static function log(string $action, string $module, ?string $description = null, ?string $targetId = null): self
    {
        $request = request();

        return static::create([
            'user_id' => auth()->id(),
            'action' => $action,
            'module' => $module,
            'target_id' => $targetId,
            'description' => $description,
            'ip_address' => $request ? $request->ip() : null,
            'user_agent' => $request ? $request->userAgent() : null,
        ]);
    }
}
