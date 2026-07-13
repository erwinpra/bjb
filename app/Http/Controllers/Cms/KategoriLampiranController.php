<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\KategoriLampiran;
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

    public function index()
    {
        $kategoris = KategoriLampiran::latest()->paginate(15);
        return view('cms::kategori-lampiran.index', compact('kategoris'));
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
        KategoriLampiran::create($data);
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
        return redirect()->route('cms.kategori-lampiran.index')->with('success', 'Kategori updated.');
    }

    public function destroy(KategoriLampiran $kategoriLampiran)
    {
        $kategoriLampiran->delete();
        return redirect()->route('cms.kategori-lampiran.index')->with('success', 'Kategori deleted.');
    }
}
