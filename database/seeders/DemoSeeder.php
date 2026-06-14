<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Cms\Pasal;
use App\Models\Cms\DataClient;

class DemoSeeder extends Seeder
{
    public function run()
    {
        $jenis = ['PT', 'CV', 'UD', 'Koperasi', 'Yayasan', 'Firma'];
        foreach ($jenis as $tipe) {
            \App\Models\Cms\Badan::firstOrCreate(['tipe' => $tipe]);
        }

        $pasal = [
            'Pasal 1 - Ketentuan Umum',
            'Pasal 2 - Hak dan Kewajiban',
            'Pasal 3 - Tata Cara Pendaftaran',
            'Pasal 4 - Sanksi Pelanggaran',
            'Pasal 5 - Ketentuan Penutup',
        ];

        foreach ($pasal as $nama) {
            Pasal::firstOrCreate(
                ['nama_pasal' => $nama],
                ['is_active' => true]
            );
        }

        $clients = [
            ['PT. Maju Bersama',      '01.234.567.8-901.000', 'KPP Madya Jakarta',    'Jl. Sudirman No. 123, Jakarta',       '021-12345678'],
            ['CV. Sejahtera Abadi',   '02.345.678.9-012.000', 'KPP Pratama Bandung',  'Jl. Asia Afrika No. 45, Bandung',     '022-87654321'],
            ['UD. Sinar Jaya',        '03.456.789.0-123.000', 'KPP Pratama Surabaya', 'Jl. Tunjungan No. 78, Surabaya',      '031-5555555'],
            ['PT. Karya Mandiri',     null,                   'KPP Madya Semarang',   'Jl. Pandanaran No. 56, Semarang',     '024-3334444'],
            ['CV. Agro Niaga',        '04.567.890.1-234.000', 'KPP Pratama Medan',    'Jl. Balai Kota No. 12, Medan',        '061-7778888'],
        ];

        foreach ($clients as $c) {
            DataClient::firstOrCreate(
                ['nama_client' => $c[0]],
                [
                    'npwp' => $c[1],
                    'kpp' => $c[2],
                    'alamat' => $c[3],
                    'no_telephone' => $c[4],
                ]
            );
        }

        $this->command->info('Demo data seeded: pasal & data client.');
    }
}
