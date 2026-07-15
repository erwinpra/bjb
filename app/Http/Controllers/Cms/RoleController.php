<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Role;
use App\Models\Cms\Permission;
use App\Models\Cms\ActivityLog;
use App\Cms\Acl\PermissionRegistry;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:role,view')->only(['index', 'show']);
        $this->middleware('cms.permission:role,create')->only(['create', 'store']);
        $this->middleware('cms.permission:role,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:role,delete')->only(['destroy']);
    }

    public function index()
    {
        $roles = Role::withCount('users')->get();
        return view('cms::roles.index', compact('roles'));
    }

    public function create()
    {
        $permissions = PermissionRegistry::all();
        return view('cms::roles.edit', ['role' => null, 'permissions' => $permissions]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_roles,slug',
            'description' => 'nullable',
            'permissions' => 'nullable|array',
        ]);

        $role = Role::create($data);

        if ($request->permissions) {
            $this->syncPermissions($role, $request->permissions);
        }

        ActivityLog::log('create', 'role', 'Created role: ' . $role->name, (string) $role->id);
        return redirect()->route('cms.roles.index')
            ->with('success', 'Role created.');
    }

    public function edit(Role $role)
    {
        $permissions = PermissionRegistry::all();
        $role->load('permissions');
        return view('cms::roles.edit', compact('role', 'permissions'));
    }

    public function update(Request $request, Role $role)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_roles,slug,' . $role->id,
            'description' => 'nullable',
            'permissions' => 'nullable|array',
        ]);

        $role->update($data);
        $this->syncPermissions($role, $request->permissions ?? []);

        ActivityLog::log('update', 'role', 'Updated role: ' . $role->name, (string) $role->id);
        return redirect()->route('cms.roles.index')
            ->with('success', 'Role updated.');
    }

    public function destroy(Role $role)
    {
        ActivityLog::log('delete', 'role', 'Deleted role: ' . $role->name, (string) $role->id);
        $role->delete();
        return redirect()->route('cms.roles.index')
            ->with('success', 'Role deleted.');
    }

    protected function syncPermissions(Role $role, array $perms): void
    {
        $role->permissions()->delete();
        foreach ($perms as $module => $actions) {
            foreach ($actions as $action => $value) {
                if ($value) {
                    $role->permissions()->create([
                        'module' => $module,
                        'action' => $action,
                    ]);
                }
            }
        }
    }
}
