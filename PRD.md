1. Pada fitur import/upload di menu Data Client tambahkan instruksi dan eksekusi khusus yaitu, ketika data pada file excel yang di upload memiliki NPWP yang sama dengan data yang sudah ada, maka berikan pilihan pada user untuk update/replace data yang sama. Dan jika terdapat data baru/yang tidak ada maka tambahkan data baru. Dan pastikan kolom NPWP/NIK sudah divalidasi 16 digit.
2. Pada menu dashboard, tambahkan dashboard khusus client. 
POINT	                    2024	            2025 DJP	        2025 CTX
KAS	                        14,579,487,152 	    11,475,827,934 	    11,475,827,934 
PIUTANG	                     -   	            -   	            -   
INVEST	                    211,977,076,543 	229,892,184,504 	230,091,984,504 
HARTA BERGERAK	            2,287,500,000 	    1,858,000,000 	    1,251,300,000 
HARTA TIDAK BERGERAK	    21,454,481,063 	    21,454,481,063 	    57,938,723,564 
HARTA LAINNYA	            7,113,010,000 	    6,964,760,000 	    20,319,280,000 
TOTAL HARTA	                257,411,554,758 	271,645,253,501 	321,077,116,002 
TOTAL HUTANG	            -   	            -   	            -   
NET	                        257,411,554,758 	271,645,253,501 	321,077,116,002 

3. Buatkan 1 master lagi yaitu lampiran_spt_tahunan dengan 7 kategori seperti pada contoh data berikut:
    a. KAS :
        - 0101	UANG TUNAI
        - 0102	TABUNGAN
        - 0103	GIRO
        - 0104	DEPOSITO
        - 0105	UANG ELEKTRONIK
        - 0106	CEK
        - 0107	WESSEL
        - 0108	KERTAS KOMERSIAL
        - 0109	SETARA KAS
        - 0110	UANG TUNAI/BANK NOTE/KOIN
        - 0111	SETARA KAS LAINNYA
    b. PIUTANG:
        - 0201	PIUTANG USAHA
        - 0202	PIUTANG AFILIASI
        - 0209	PIUTANG LAINNYA
    c. INVESTASI:
        - 0310	ASURANSI
        - 0311	REKSA DANA
        - 0312	OBLIGASI PEMERINTAH/PENGURUSAN PEMERINTAH
        - 0313	OBLIGASI SW
        - 0314	SAHAM
        - 0315	OBLIGASI
        - 0316	REKSA SAHAM
        - 0317	REKSA CAMPURAN
        - 0318	REKSA OBLIGASI
        - 0319	REKSA PENDAPATAN TETAP
        - 0320	REKSA TERPROTEKSI
        - 0321	PENYERTAAN MODAL PADA BADAN USAHA YANG DIVIDENDENDENDENYA DIKENAKAN PEMOTONGAN PAJAK
        - 0322	KAS PENJUALAN/PEMBELIAN REKSA DANA
        - 0323	PERSEKUTUAN/FIRMA/CV
        - 0324	INVESTASI LAINNYA
    d. HARTA BERGERAK:
        - 0401	SEPEDA
        - 0402	SEPEDA MOTOR
        - 0403	MOBIL PENUMPANG
        - 0404	BUS
        - 0405	KENDARAAN ANGKUTAN JALAN
        - 0406	KENDARAAN TUJUAN KHUSUS
        - 0407	KERETA
        - 0408	PESAWAT TERBANG
        - 0409	KAPAL
        - 0410	MESIN
        - 0411	GEROBAK
        - 0412	KAPAL PESIAR
        - 0499	HARTA BERGERAK LAINNYA
    e. HARTA TIDAK BERGERAK:
        - 0501	TANAH KOSONG
        - 0502	TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL
        - 0503	APARTEMEN
        - 0504	VESSEL
        - 0505	TANAH ATAU LAHAN UNTUK USAHA (LAHAN PERTANIAN, PERKEBUNAN, DSB)
        - 0506	TANAH DAN/ATAU BANGUNAN UNTUK USAHA (TOKO, PABRIK, DSB)
        - 0507	TANAH DAN/ATAU BANGUNAN YANG DISEWAKAN
        - 0509	HARTA TIDAK BERGERAK LAINNYA
    f. HARTA LAINNYA:
        - 0601	PATEN
        - 0602	ROYALTI
        - 0603	MEREK DAGANG
        - 0699	HARTA TIDAK BERWUJUD LAINNYA
        - 0701	EMAS BATANGAN
        - 0702	EMAS PERHIASAN
        - 0703	BATANGAN NON EMAS
        - 0704	PERHIASAN NON EMAS
        - 0705	PERMATA
        - 0706	BARANG-BARANG SENI DAN ANTIK
        - 0707	PERALATAN OLAH RAGA KHUSUS
        - 0708	PERALATAN ELEKTRONIK
        - 0709	PERABOT RUMAH TANGGA
        - 0710	PERALATAN KANTOR
        - 0711	JET SKI
        - 0712	PERSEDIAAN USAHA
    g. TOTAL HUTANG:
        - 101   UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK
        - 102   KARTU KREDIT
        - 103   UTANG AFILIASI
        - 109   UTANG LAINNYA

4. pada menu client -> transaksi hilangkan inputan harta, tetapi tetap ada tombol untuk update/import harta yang akan mengarah ke lampiran spt tahunan yang sudah di sediakan.
5. hilangkan Omset Per Bulan, tetapi tabel Hasil Perhitungan Per Bulan dibuat juga di halaman transaksi dengan fitur hide/show begitu user isi setiap bulan maka otomatis terisi dengan langsung melakukan kalkulasi. untuk layout/design nya mengikuti Preview Transaksi
6. Validasi ketika input omset jika diatas 400 juta setiap bulan, harus ada notifikasi/label di kolom omset atau ada warna di tabel
7. Validasi ketika omset menyentuh angka 4 Milyar (secara akumulasi). ada notifikasi/label di kolom omset atau ada warna di tabel