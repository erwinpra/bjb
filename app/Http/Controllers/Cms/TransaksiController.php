<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use App\Models\Cms\MasterRumus;
use Illuminate\Http\Request;

class TransaksiController extends Controller
{
    public function create()
    {
        $clients = DataClient::all();
        $rumus = MasterRumus::all();
        return view('cms::transaksi.form', compact('clients', 'rumus'));
    }

    public function preview(Request $request)
    {
        $data = $request->all();
        $client = DataClient::find($request->client_id);

        return view('cms::transaksi.preview', compact('data', 'client'));
    }
}
