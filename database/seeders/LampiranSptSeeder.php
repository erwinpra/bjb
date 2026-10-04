<?php

namespace Database\Seeders;

use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\MasterLampiranSpt;
use Illuminate\Database\Seeder;

class LampiranSptSeeder extends Seeder
{
    public function run()
    {
        $kategoris = [
            'KAS',
            'PIUTANG',
            'INVESTASI',
            'HARTA BERGERAK',
            'HARTA TIDAK BERGERAK',
            'HARTA LAINNYA',
            'TOTAL HUTANG',
        ];

        // Sumber: master.md (replace total, is_active=1).
        // Catatan master.md:
        // - KAS: 0101 duplikat (UANG TUNAI -> ditimpa UANG TUNAI/BANK NOTE/KOIN),
        //   0109 duplikat (SETARA KAS -> ditimpa SETARA KAS LAINNYA).
        // - INVEST di master.md dipetakan ke kategori INVESTASI.
        // - HUTANG di master.md dipetakan ke kategori TOTAL HUTANG.
        $data = [
            'KAS' => [
                ['0101', 'UANG TUNAI/BANK NOTE/KOIN'],
                ['0102', 'TABUNGAN'],
                ['0103', 'GIRO'],
                ['0104', 'DEPOSITO'],
                ['0105', 'UANG ELEKTRONIK'],
                ['0106', 'CEK'],
                ['0107', 'WESSEL'],
                ['0108', 'KERTAS KOMERSIAL'],
                ['0109', 'SETARA KAS LAINNYA'],
            ],
            'PIUTANG' => [
                ['0201', 'PIUTANG USAHA'],
                ['0202', 'PIUTANG AFILIASI'],
                ['0209', 'PIUTANG LAINNYA'],
            ],
            'INVESTASI' => [
                ['0301', 'SAHAM YANG DIBELI UNTUK DIJUAL KEMBALI'],
                ['0302', 'SAHAM NON BURSA'],
                ['0303', 'SAHAM BURSA'],
                ['0304', 'OBLIGASI PERUSAHAAN'],
                ['0305', 'OBLIGASI PEMERINTAH'],
                ['0306', 'SURAT UTANG LAINNYA'],
                ['0307', 'REKSADANA'],
                ['0309', 'PENYERTAAN MODAL DALAM PERUSAHAAN LAIN YANG BUKAN ATAS SAHAM'],
                ['0310', 'ASURANSI'],
                ['0311', 'UNIT LINK DI ASURANSI'],
                ['0399', 'INVESTASI LAINNYA'],
            ],
            'HARTA BERGERAK' => [
                ['0401', 'SEPEDA'],
                ['0402', 'SEPEDA MOTOR'],
                ['0403', 'MOBIL PENUMPANG'],
                ['0404', 'BUS'],
                ['0405', 'KENDARAAN ANGKUTAN JALAN'],
                ['0406', 'KENDARAAN TUJUAN KHUSUS'],
                ['0407', 'KERETA'],
                ['0408', 'PESAWAT TERBANG'],
                ['0409', 'KAPAL'],
                ['0410', 'MESIN'],
                ['0411', 'GEROBAK'],
                ['0412', 'KAPAL PESIAR'],
                ['0499', 'HARTA BERGERAK LAINNYA'],
            ],
            'HARTA TIDAK BERGERAK' => [
                ['0501', 'TANAH KOSONG'],
                ['0502', 'TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL'],
                ['0503', 'APARTEMEN'],
                ['0504', 'VESSEL'],
                ['0505', 'TANAH ATAU LAHAN UNTUK USAHA (LAHAN PERTANIAN, PERKEBUNAN, DSB)'],
                ['0506', 'TANAH DAN/ATAU BANGUNAN UNTUK USAHA (TOKO, PABRIK, DSB)'],
                ['0507', 'TANAH DAN/ATAU BANGUNAN YANG DISEWAKAN'],
                ['0509', 'HARTA TIDAK BERGERAK LAINNYA'],
            ],
            'HARTA LAINNYA' => [
                ['0601', 'PATEN'],
                ['0602', 'ROYALTI'],
                ['0603', 'MEREK DAGANG'],
                ['0699', 'HARTA TIDAK BERWUJUD LAINNYA'],
                ['0701', 'EMAS BATANGAN'],
                ['0702', 'EMAS PERHIASAN'],
                ['0703', 'BATANGAN NON EMAS'],
                ['0704', 'PERHIASAN NON EMAS'],
                ['0705', 'PERMATA'],
                ['0706', 'BARANG-BARANG SENI DAN ANTIK'],
                ['0707', 'PERALATAN OLAH RAGA KHUSUS'],
                ['0708', 'PERALATAN ELEKTRONIK'],
                ['0709', 'PERABOT RUMAH TANGGA'],
                ['0710', 'PERALATAN KANTOR'],
                ['0711', 'JET SKI'],
                ['0712', 'PERSEDIAAN USAHA'],
            ],
            'TOTAL HUTANG' => [
                ['101', 'UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK'],
                ['102', 'KARTU KREDIT'],
                ['103', 'UTANG AFILIASI'],
                ['109', 'UTANG LAINNYA'],
            ],
        ];

        foreach ($kategoris as $label) {
            KategoriLampiran::firstOrCreate(['label' => $label]);
        }

        // Replace total: hapus semua master lama (cascade ke cms_lampiran_spt),
        // lalu insert ulang dari master.md dengan is_active=1.
        \DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        MasterLampiranSpt::truncate();
        \DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        foreach ($data as $label => $rows) {
            $kategori = KategoriLampiran::where('label', $label)->firstOrFail();
            foreach ($rows as [$subKode, $nama]) {
                MasterLampiranSpt::create([
                    'kategori_id' => $kategori->id,
                    'sub_kode' => $subKode,
                    'nama' => $nama,
                    'is_active' => true,
                ]);
            }
        }

        $this->command->info('Lampiran SPT master data seeded successfully!');
    }
}
