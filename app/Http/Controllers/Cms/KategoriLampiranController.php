<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\ActivityLog;
use Illuminate\Http\Request;

class KategoriLampiranController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:kategori_lampiran,view')->only(['index', 'show']);
        $this->middleware('cms.permission:kategori_lampiran,create')->only(['create', 'store']);
        $this->middleware('cms.permission:kategori_lampiran,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:kategori_lampiran,delete')->only(['destroy']);
    }

    public function index(Request $request)
    {
        $search = $request->get('search');
        $kategoris = KategoriLampiran::when($search, function ($q) use ($search) {
                $q->where('label', 'like', "%{$search}%");
            })->latest()->paginate(15);
        return view('cms::kategori-lampiran.index', compact('kategoris', 'search'));
    }

    public function create()
    {
        return view('cms::kategori-lampiran.edit', ['kategori' => null]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'label' => 'required|max:255|unique:cms_kategori_lampiran,label',
        ]);
        $kategori = KategoriLampiran::create($data);
        ActivityLog::log('create', 'kategori_lampiran', 'Created kategori: ' . $kategori->label, (string) $kategori->id);
        return redirect()->route('cms.kategori-lampiran.index')->with('success', 'Kategori created.');
    }

    public function edit(KategoriLampiran $kategoriLampiran)
    {
        return view('cms::kategori-lampiran.edit', ['kategori' => $kategoriLampiran]);
    }

    public function update(Request $request, KategoriLampiran $kategoriLampiran)
    {
        $data = $request->validate([
            'label' => 'required|max:255|unique:cms_kategori_lampiran,label,' . $kategoriLampiran->id,
        ]);
        $kategoriLampiran->update($data);
        ActivityLog::log('update', 'kategori_lampiran', 'Updated kategori: ' . $kategoriLampiran->label, (string) $kategoriLampiran->id);
        return redirect()->route('cms.kategori-lampiran.index')->with('success', 'Kategori updated.');
    }

    public function destroy(KategoriLampiran $kategoriLampiran)
    {
        ActivityLog::log('delete', 'kategori_lampiran', 'Deleted kategori: ' . $kategoriLampiran->label, (string) $kategoriLampiran->id);
        $kategoriLampiran->delete();
        return redirect()->route('cms.kategori-lampiran.index')->with('success', 'Kategori deleted.');
    }
}
