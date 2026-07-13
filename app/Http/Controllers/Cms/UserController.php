<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Cms\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:user,view')->only(['index', 'show']);
        $this->middleware('cms.permission:user,create')->only(['create', 'store']);
        $this->middleware('cms.permission:user,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:user,delete')->only(['destroy']);
    }

    public function index()
    {
        $users = User::with('roles')->paginate(15);
        return view('cms::users.index', compact('users'));
    }

    public function create()
    {
        $roles = Role::all();
        return view('cms::users.edit', ['user' => null, 'roles' => $roles]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|min:6',
            'roles' => 'nullable|array',
            'roles.*' => 'exists:cms_roles,id',
        ]);

        $data['password'] = Hash::make($data['password']);

        $user = User::create($data);

        if ($request->roles) {
            $user->roles()->sync($request->roles);
        }

        return redirect()->route('cms.users.index')
            ->with('success', 'User created successfully.');
    }

    public function edit(User $user)
    {
        $user->load('roles');
        $roles = Role::all();
        return view('cms::users.edit', compact('user', 'roles'));
    }

    public function update(Request $request, User $user)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:users,email,' . $user->id,
            'password' => 'nullable|min:6',
            'roles' => 'nullable|array',
            'roles.*' => 'exists:cms_roles,id',
        ]);

        if ($data['password'] ?? null) {
            $data['password'] = Hash::make($data['password']);
        } else {
            unset($data['password']);
        }

        $user->update($data);

        if ($request->has('roles')) {
            $user->roles()->sync($request->roles);
        }

        return redirect()->route('cms.users.index')
            ->with('success', 'User updated successfully.');
    }

    public function destroy(User $user)
    {
        if ($user->id === auth()->id()) {
            return redirect()->route('cms.users.index')
                ->with('error', 'You cannot delete yourself.');
        }

        $user->roles()->detach();
        $user->delete();

        return redirect()->route('cms.users.index')
            ->with('success', 'User deleted successfully.');
    }
}
