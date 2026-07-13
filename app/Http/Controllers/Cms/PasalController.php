<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Pasal;
use Illuminate\Http\Request;

class PasalController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:pasal,view')->only(['index', 'show']);
        $this->middleware('cms.permission:pasal,create')->only(['create', 'store']);
        $this->middleware('cms.permission:pasal,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:pasal,delete')->only(['destroy']);
    }

    public function index()
    {
        $pasal = Pasal::latest()->paginate(15);
        return view('cms::pasal.index', compact('pasal'));
    }

    public function create()
    {
        return view('cms::pasal.edit', ['pasal' => null]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nama_pasal' => 'required|max:255',
            'is_active' => 'boolean',
        ]);

        $data['is_active'] = $request->boolean('is_active', true);

        Pasal::create($data);

        return redirect()->route('cms.pasal.index')
            ->with('success', 'Pasal created.');
    }

    public function edit(Pasal $pasal)
    {
        return view('cms::pasal.edit', compact('pasal'));
    }

    public function update(Request $request, Pasal $pasal)
    {
        $data = $request->validate([
            'nama_pasal' => 'required|max:255',
            'is_active' => 'boolean',
        ]);

        $data['is_active'] = $request->boolean('is_active', true);

        $pasal->update($data);

        return redirect()->route('cms.pasal.index')
            ->with('success', 'Pasal updated.');
    }

    public function destroy(Pasal $pasal)
    {
        $pasal->delete();
        return redirect()->route('cms.pasal.index')
            ->with('success', 'Pasal deleted.');
    }
}
