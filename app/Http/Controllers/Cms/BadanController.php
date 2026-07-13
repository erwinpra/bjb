<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;

class BadanController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:badan,view')->only(['index']);
        $this->middleware('cms.permission:badan,create')->only(['create', 'store']);
        $this->middleware('cms.permission:badan,edit')->only(['edit', 'update']);
        $this->middleware('cms.permission:badan,delete')->only(['destroy']);
    }

    public function index()
    {
        $badan = Badan::latest()->paginate(15);
        return view('cms::badan.index', compact('badan'));
    }

    public function create()
    {
        return view('cms::badan.edit', ['badan' => null]);
    }

    public function store(Request $request)
    {
        $data = $request->validate(['tipe' => 'required|max:255']);
        Badan::create($data);
        return redirect()->route('cms.badan.index')->with('success', 'Badan created.');
    }

    public function edit(Badan $badan)
    {
        return view('cms::badan.edit', compact('badan'));
    }

    public function update(Request $request, Badan $badan)
    {
        $data = $request->validate(['tipe' => 'required|max:255']);
        $badan->update($data);
        return redirect()->route('cms.badan.index')->with('success', 'Badan updated.');
    }

    public function destroy(Badan $badan)
    {
        $badan->delete();
        return redirect()->route('cms.badan.index')->with('success', 'Badan deleted.');
    }
}
