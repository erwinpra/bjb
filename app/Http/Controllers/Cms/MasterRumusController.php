<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\MasterRumus;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;

class MasterRumusController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:master_rumus,view')->only(['index']);
        $this->middleware('cms.permission:master_rumus,create')->only(['create', 'store']);
        $this->middleware('cms.permission:master_rumus,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:master_rumus,delete')->only([]);
    }

    public function index()
    {
        $rumus = MasterRumus::with('badan')->latest()->paginate(15);
        return view('cms::master-rumus.index', compact('rumus'));
    }

    public function create()
    {
        $badan = Badan::all();
        return view('cms::master-rumus.edit', ['rumus' => null, 'badan' => $badan]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'tipe_badan' => 'required|exists:cms_badan,id',
            'max_value' => 'required|numeric|min:0',
            'potongan_persentase' => 'required|numeric|min:0|max:100',
        ]);

        MasterRumus::create($data);

        return redirect()->route('cms.master-rumus.index')
            ->with('success', 'Master rumus created.');
    }

    public function edit(MasterRumus $masterRumus)
    {
        $badan = Badan::all();
        return view('cms::master-rumus.edit', ['rumus' => $masterRumus, 'badan' => $badan]);
    }

    public function update(Request $request, MasterRumus $masterRumus)
    {
        $data = $request->validate([
            'tipe_badan' => 'required|exists:cms_badan,id',
            'max_value' => 'required|numeric|min:0',
            'potongan_persentase' => 'required|numeric|min:0|max:100',
        ]);

        $masterRumus->update($data);

        return redirect()->route('cms.master-rumus.index')
            ->with('success', 'Master rumus updated.');
    }

    public function destroy(MasterRumus $masterRumus)
    {
        $masterRumus->delete();
        return redirect()->route('cms.master-rumus.index')
            ->with('success', 'Master rumus deleted.');
    }
}
