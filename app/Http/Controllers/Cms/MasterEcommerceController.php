<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\MasterEcommerce;
use App\Models\Cms\ActivityLog;
use Illuminate\Http\Request;

class MasterEcommerceController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:master_ecommerce,view')->only(['index']);
        $this->middleware('cms.permission:master_ecommerce,create')->only(['create', 'store']);
        $this->middleware('cms.permission:master_ecommerce,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:master_ecommerce,delete')->only(['destroy']);
    }

    public function index(Request $request)
    {
        $search = $request->get('search');

        $items = MasterEcommerce::when($search, function ($q) use ($search) {
            $q->where('kode_ecommerce', 'like', "%{$search}%")
              ->orWhere('deskripsi', 'like', "%{$search}%");
        })->latest()->paginate(15);

        return view('cms::master-ecommerce.index', compact('items', 'search'));
    }

    public function create()
    {
        return view('cms::master-ecommerce.edit', ['item' => null]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'kode_ecommerce' => 'required|max:100|unique:cms_master_ecommerce,kode_ecommerce',
            'deskripsi' => 'nullable|max:255',
        ]);
        $data['is_active'] = true;
        $item = MasterEcommerce::create($data);
        ActivityLog::log('create', 'master_ecommerce', 'Created ecommerce: ' . $item->kode_ecommerce, (string) $item->id);
        return redirect()->route('cms.master-ecommerce.index')->with('success', 'Master ecommerce created.');
    }

    public function edit(MasterEcommerce $masterEcommerce)
    {
        return view('cms::master-ecommerce.edit', ['item' => $masterEcommerce]);
    }

    public function update(Request $request, MasterEcommerce $masterEcommerce)
    {
        $data = $request->validate([
            'kode_ecommerce' => 'required|max:100|unique:cms_master_ecommerce,kode_ecommerce,' . $masterEcommerce->id,
            'deskripsi' => 'nullable|max:255',
        ]);
        $masterEcommerce->update($data);
        ActivityLog::log('update', 'master_ecommerce', 'Updated ecommerce: ' . $masterEcommerce->kode_ecommerce, (string) $masterEcommerce->id);
        return redirect()->route('cms.master-ecommerce.index')->with('success', 'Master ecommerce updated.');
    }

    public function destroy(MasterEcommerce $masterEcommerce)
    {
        $newStatus = !$masterEcommerce->is_active;
        $masterEcommerce->update(['is_active' => $newStatus]);
        $status = $newStatus ? 'activated' : 'deactivated';
        ActivityLog::log('update', 'master_ecommerce', $status . ' ecommerce: ' . $masterEcommerce->kode_ecommerce, (string) $masterEcommerce->id);
        return redirect()->route('cms.master-ecommerce.index')->with('success', "Master ecommerce {$status}.");
    }
}
