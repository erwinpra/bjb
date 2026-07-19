<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Cms\Role;
use App\Models\Cms\ActivityLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Mail\WelcomeUser;
use Illuminate\Support\Str;

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

    private function generateStrongPassword(): string
    {
        $upper = Str::random(3);
        $lower = Str::random(3);
        $digits = random_int(100, 999);
        $special = str_shuffle('!@#$%^&*');
        $combined = str_shuffle($upper . $lower . $digits . $special[0]);
        return $combined;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'roles' => 'nullable|exists:cms_roles,id',
        ]);

        $plainPassword = $this->generateStrongPassword();
        $data['password'] = Hash::make($plainPassword);

        $user = User::create($data);

        if ($request->roles) {
            $user->roles()->sync([$request->roles]);
        }

        $emailSent = false;
        try {
            Mail::to($user->email)->send(new WelcomeUser($user->name, $user->email, $plainPassword));
            $emailSent = true;
        } catch (\Exception $e) {
            Log::error('Failed to send welcome email to ' . $user->email . ': ' . $e->getMessage());
        }

        ActivityLog::log('create', 'user', 'Created user: ' . $user->email, (string) $user->id);
        if ($emailSent) {
            return redirect()->route('cms.users.index')
                ->with('success', 'User created. Password sent to ' . $user->email . '.');
        } else {
            return redirect()->route('cms.users.index')
                ->with('warning', 'User created but email failed to send. Password: ' . $plainPassword . '. Please share securely.');
        }
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
            'roles' => 'nullable|exists:cms_roles,id',
        ]);

        if ($data['password'] ?? null) {
            $data['password'] = Hash::make($data['password']);
        } else {
            unset($data['password']);
        }

        $user->update($data);

        if ($request->has('roles')) {
            $user->roles()->sync([$request->roles]);
        }

        ActivityLog::log('update', 'user', 'Updated user: ' . $user->email, (string) $user->id);
        return redirect()->route('cms.users.index')
            ->with('success', 'User updated successfully.');
    }

    public function destroy(User $user)
    {
        if ($user->id === auth()->id()) {
            return redirect()->route('cms.users.index')
                ->with('error', 'You cannot delete yourself.');
        }

        ActivityLog::log('delete', 'user', 'Deleted user: ' . $user->email, (string) $user->id);
        $user->roles()->detach();
        $user->delete();

        return redirect()->route('cms.users.index')
            ->with('success', 'User deleted successfully.');
    }
}
