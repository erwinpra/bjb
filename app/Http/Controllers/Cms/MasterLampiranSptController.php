<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\MasterLampiranSpt;
use App\Models\Cms\KategoriLampiran;
use Illuminate\Http\Request;

class MasterLampiranSptController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:master_lampiran_spt,view')->only(['index', 'show']);
        $this->middleware('cms.permission:master_lampiran_spt,create')->only(['create', 'store']);
        $this->middleware('cms.permission:master_lampiran_spt,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:master_lampiran_spt,delete')->only(['destroy']);
    }

    public function index()
    {
        $items = MasterLampiranSpt::with('kategori')->latest()->paginate(15);
        return view('cms::master-lampiran-spt.index', compact('items'));
    }

    public function create()
    {
        $kategoris = KategoriLampiran::orderBy('label')->get();
        return view('cms::master-lampiran-spt.edit', ['item' => null, 'kategoris' => $kategoris]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'kategori_id' => 'required|exists:cms_kategori_lampiran,id',
            'sub_kode' => 'required|max:255',
            'nama' => 'required|max:255',
        ]);
        $data['is_active'] = true;
        MasterLampiranSpt::create($data);
        return redirect()->route('cms.master-lampiran-spt.index')->with('success', 'Master item created.');
    }

    public function edit(MasterLampiranSpt $masterLampiranSpt)
    {
        $kategoris = KategoriLampiran::orderBy('label')->get();
        return view('cms::master-lampiran-spt.edit', ['item' => $masterLampiranSpt, 'kategoris' => $kategoris]);
    }

    public function update(Request $request, MasterLampiranSpt $masterLampiranSpt)
    {
        $data = $request->validate([
            'kategori_id' => 'required|exists:cms_kategori_lampiran,id',
            'nama' => 'required|max:255',
        ]);
        $masterLampiranSpt->update($data);
        return redirect()->route('cms.master-lampiran-spt.index')->with('success', 'Master item updated.');
    }

    public function destroy(MasterLampiranSpt $masterLampiranSpt)
    {
        $newStatus = !$masterLampiranSpt->is_active;
        $masterLampiranSpt->update(['is_active' => $newStatus]);
        $status = $newStatus ? 'activated' : 'deactivated';
        return redirect()->route('cms.master-lampiran-spt.index')->with('success', "Master item {$status}.");
    }
}
