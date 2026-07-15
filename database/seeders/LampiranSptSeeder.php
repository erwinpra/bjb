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

        $data = [
            'KAS' => [
                ['0101', 'UANG TUNAI'],
                ['0102', 'TABUNGAN'],
                ['0103', 'GIRO'],
                ['0104', 'DEPOSITO'],
                ['0105', 'UANG ELEKTRONIK'],
                ['0106', 'CEK'],
                ['0107', 'WESSEL'],
                ['0108', 'KERTAS KOMERSIAL'],
                ['0109', 'SETARA KAS'],
                ['0110', 'UANG TUNAI/BANK NOTE/KOIN'],
                ['0111', 'SETARA KAS LAINNYA'],
            ],
            'PIUTANG' => [
                ['0201', 'PIUTANG USAHA'],
                ['0202', 'PIUTANG AFILIASI'],
                ['0209', 'PIUTANG LAINNYA'],
            ],
            'INVESTASI' => [
                ['0310', 'ASURANSI'],
                ['0311', 'REKSA DANA'],
                ['0312', 'OBLIGASI PEMERINTAH/PENGURUSAN PEMERINTAH'],
                ['0313', 'OBLIGASI SW'],
                ['0314', 'SAHAM'],
                ['0315', 'OBLIGASI'],
                ['0316', 'REKSA SAHAM'],
                ['0317', 'REKSA CAMPURAN'],
                ['0318', 'REKSA OBLIGASI'],
                ['0319', 'REKSA PENDAPATAN TETAP'],
                ['0320', 'REKSA TERPROTEKSI'],
                ['0321', 'PENYERTAAN MODAL PADA BADAN USAHA YANG DIVIDENDENDENDENYA DIKENAKAN PEMOTONGAN PAJAK'],
                ['0322', 'KAS PENJUALAN/PEMBELIAN REKSA DANA'],
                ['0323', 'PERSEKUTUAN/FIRMA/CV'],
                ['0324', 'INVESTASI LAINNYA'],
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
            $kategori = KategoriLampiran::firstOrCreate(['label' => $label]);

            if (isset($data[$label])) {
                foreach ($data[$label] as [$subKode, $nama]) {
                    MasterLampiranSpt::firstOrCreate(
                        ['kategori_id' => $kategori->id, 'sub_kode' => $subKode],
                        ['nama' => $nama, 'is_active' => true],
                    );
                }
            }
        }

        $this->command->info('Lampiran SPT master data seeded successfully!');
    }
}
