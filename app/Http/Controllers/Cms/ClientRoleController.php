<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\ClientRole;
use Illuminate\Http\Request;

class ClientRoleController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:client_roles,view')->only(['index']);
        $this->middleware('cms.permission:client_roles,create')->only(['create', 'store']);
        $this->middleware('cms.permission:client_roles,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:client_roles,delete')->only(['destroy']);
    }

    public function index()
    {
        $roles = ClientRole::withCount('clients')->latest()->get();
        return view('cms::client-roles.index', compact('roles'));
    }

    public function create()
    {
        return view('cms::client-roles.edit', ['role' => null]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_client_roles,slug',
            'description' => 'nullable',
            'permissions' => 'nullable|array',
        ]);

        $data['permissions'] = $request->permissions ?? [];

        ClientRole::create($data);

        return redirect()->route('cms.client-roles.index')
            ->with('success', 'Client role created.');
    }

    public function edit(ClientRole $clientRole)
    {
        return view('cms::client-roles.edit', ['role' => $clientRole]);
    }

    public function update(Request $request, ClientRole $clientRole)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_client_roles,slug,' . $clientRole->id,
            'description' => 'nullable',
            'permissions' => 'nullable|array',
        ]);

        $data['permissions'] = $request->permissions ?? [];

        $clientRole->update($data);

        return redirect()->route('cms.client-roles.index')
            ->with('success', 'Client role updated.');
    }

    public function destroy(ClientRole $clientRole)
    {
        if ($clientRole->clients()->count() > 0) {
            return back()->with('error', 'Cannot delete role that has clients assigned.');
        }

        $clientRole->delete();

        return redirect()->route('cms.client-roles.index')
            ->with('success', 'Client role deleted.');
    }
}
