<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;

class DataClientController extends Controller
{
    public function index()
    {
        $dataClients = DataClient::latest()->paginate(15);
        return view('cms::data-client.index', compact('dataClients'));
    }

    public function create()
    {
        $badan = Badan::all();
        return view('cms::data-client.edit', ['dataClient' => null, 'badan' => $badan]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nama_client' => 'required|max:255',
            'tipe_badan' => 'nullable',
            'npwp' => 'nullable|digits:16',
            'kpp' => 'nullable|max:50',
            'alamat' => 'nullable',
            'no_telephone' => 'nullable|max:30',
        ]);

        $data['tipe_badan'] = $this->resolveTipeBadan($request->tipe_badan);

        DataClient::create($data);

        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client created.');
    }

    public function edit(DataClient $dataClient)
    {
        $badan = Badan::all();
        return view('cms::data-client.edit', compact('dataClient', 'badan'));
    }

    public function update(Request $request, DataClient $dataClient)
    {
        $data = $request->validate([
            'nama_client' => 'required|max:255',
            'tipe_badan' => 'nullable',
            'npwp' => 'nullable|digits:16',
            'kpp' => 'nullable|max:50',
            'alamat' => 'nullable',
            'no_telephone' => 'nullable|max:30',
        ]);

        $data['tipe_badan'] = $this->resolveTipeBadan($request->tipe_badan);

        $dataClient->update($data);

        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client updated.');
    }

    public function destroy(DataClient $dataClient)
    {
        $dataClient->delete();
        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client deleted.');
    }

    protected function resolveTipeBadan($value)
    {
        if (!$value) return null;

        $badan = Badan::find($value);
        return $badan ? $badan->tipe : $value;
    }
}
