<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;

class BadanController extends Controller
{
    public function index()
    {
        $badan = Badan::latest()->paginate(15);
        return view('cms::badan.index', compact('badan'));
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
}
