<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\MasterRumus;
use App\Models\Cms\Badan;
use App\Models\Cms\ActivityLog;
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

        $rumus = MasterRumus::create($data);
        ActivityLog::log('create', 'master_rumus', 'Created master rumus ID: ' . $rumus->id, (string) $rumus->id);
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
        ActivityLog::log('update', 'master_rumus', 'Updated master rumus ID: ' . $masterRumus->id, (string) $masterRumus->id);
        return redirect()->route('cms.master-rumus.index')
            ->with('success', 'Master rumus updated.');
    }

    public function destroy(MasterRumus $masterRumus)
    {
        ActivityLog::log('delete', 'master_rumus', 'Deleted master rumus ID: ' . $masterRumus->id, (string) $masterRumus->id);
        $masterRumus->delete();
        return redirect()->route('cms.master-rumus.index')
            ->with('success', 'Master rumus deleted.');
    }
}
