import 'package:terator/data/letter_functions/bisnis/surat_kesepakatan_kerja.dart';
import 'package:terator/data/letter_functions/bisnis/surat_keterangan_tempat_usaha.dart';
import 'package:terator/data/letter_functions/bisnis/surat_penawaran_barang.dart';
import 'package:terator/data/letter_functions/bisnis/surat_pesanan_barang.dart';
import 'package:terator/data/letter_functions/bisnis/surat_perjanjian_kerjasama.dart';
import 'package:terator/data/letter_functions/bisnis/surat_komplain_barang.dart';
import 'package:terator/data/letter_functions/bisnis/surat_permohonan_izin_usaha.dart';
import 'package:terator/data/letter_functions/bisnis/surat_pemutusan_kerjasama.dart';
import 'package:terator/data/letter_functions/bisnis/surat_kuasa_bisnis.dart';
import 'package:terator/data/letter_functions/bisnis/surat_peringatan_pembayaran.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_domisili.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_tidak_mampu.dart';
import 'package:terator/data/letter_functions/desa/surat_pengantar_ktp.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_usaha.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_belum_memiliki_rumah.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_kelahiran.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_kematian.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_pindah.dart';
import 'package:terator/data/letter_functions/desa/surat_pengantar_nikah.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_berkelakuan_baik.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_ahli_waris.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_pernyataan_sehat_jasmani_rohani.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_izin_sakit.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_keterangan_bebas_narkoba.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_persetujuan_tindakan_medis.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_permohonan_rujukan_medis.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_pernyataan_riwayat_penyakit.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_pernyataan_tidak_buta_warna.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_pernyataan_tidak_hamil.dart';
import 'package:terator/data/letter_functions/kesehatan/surat_permohonan_bantuan_biaya_pengobatan.dart';
import 'package:terator/data/letter_functions/keuangan/surat_pernyataan_kepemilikan_harta.dart';
import 'package:terator/data/letter_functions/keuangan/surat_kwitansi_pembayaran.dart';
import 'package:terator/data/letter_functions/keuangan/surat_permohonan_pinjaman.dart';
import 'package:terator/data/letter_functions/keuangan/surat_pernyataan_hutang.dart';
import 'package:terator/data/letter_functions/keuangan/surat_pernyataan_pelunasan_hutang.dart';
import 'package:terator/data/letter_functions/keuangan/surat_kuasa_pengurusan_keuangan.dart';
import 'package:terator/data/letter_functions/keuangan/surat_permohonan_pengembalian_dana.dart';
import 'package:terator/data/letter_functions/keuangan/surat_pernyataan_penghasilan.dart';
import 'package:terator/data/letter_functions/keuangan/surat_perjanjian_sewa_rumah.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_izin_tidak_masuk_kerja.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_lamaran_pekerjaan.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_pengunduran_diri.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_permohonan_izin_cuti_kerja.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_permohonan_magang_kerja.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_pernyataan_kesediaan_bekerja_penuh_waktu.dart';
import 'package:terator/data/letter_functions/pribadi/surat_pernyataan_kehilangan_ijazah.dart';
import 'package:terator/data/letter_functions/pribadi/surat_pernyataan_kesanggupan_membayar_ukt.dart';
import 'package:terator/data/letter_functions/pribadi/surat_pernyataan_pemilik_tempat_tinggal.dart';
import 'package:terator/data/letter_functions/pribadi/surat_persetujuan_suami_istri.dart';
import 'package:terator/data/letter_functions/sekolah/surat_izin_tidak_masuk_sekolah.dart';
import 'package:terator/data/letter_functions/sekolah/surat_keterangan_penghasilan_orang_tua.dart';
import 'package:terator/data/letter_functions/sekolah/surat_perjanjian_tidak_mengulangi_kesalahan.dart';
import 'package:terator/data/letter_functions/sekolah/surat_permohonan_beasiswa.dart';
import 'package:terator/data/letter_functions/sekolah/surat_permohonan_pindah_sekolah.dart';
import 'package:terator/data/letter_functions/sekolah/surat_pernyataan_tidak_menerima_beasiswa.dart';
import 'package:terator/data/letter_functions/sekolah/surat_persetujuan_orang_tua.dart';
import 'package:terator/data/letter_functions/umum/surat_permohonan_maaf.dart';
import 'package:terator/data/letter_functions/umum/surat_pernyataan_belum_menikah.dart';
import 'package:terator/data/letter_functions/umum/surat_pernyataan_cerai.dart';
import 'package:terator/data/letter_functions/umum/surat_pernyataan_kebenaran_dokumen.dart';
import 'package:terator/data/letter_functions/umum/surat_pernyataan_keluarga_tentang_kematian.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

// Letter key => Premium true/false
final premiumLetterMap = {
  'surat_permohonan_beasiswa': true,
  'surat_permohonan_pindah_sekolah': true,
  'surat_pernyataan_kesediaan_bekerja_paruh_waktu': true,
  'surat_pengantar_nikah': true,
  'surat_keterangan_ahli_waris': true,
  'surat_keterangan_usaha': true,
  'surat_permohonan_izin_usaha': true,
  'surat_kuasa_bisnis': true,
  'surat_penawaran_barang': true,
  'surat_pernyataan_cerai': true,
  'surat_perjanjian_sewa_rumah': true,
  'surat_kuasa_pengurusan_keuangan': true,
  'surat_pernyataan_penghasilan': true,
  'surat_keterangan_bebas_narkoba': true,
};

class LetterData {
  static String html(String key,
      {String? image, LetterModel? letter, AccountModel? account}) {
    List<Map<String, dynamic>> data =
        letterDataMap(image, letter: letter, account: account)
            .where((element) => element['key'] == key)
            .toList();
    if (data.isEmpty) return '';
    return data[0]['html'];
  }

  static List<Map<String, dynamic>> listLetters({String q = ''}) {
    List<Map<String, dynamic>> result = [
      {
        "id": 1,
        "title": "Surat Sekolah",
        "letters": [
          {
            "key": "surat_izin_tidak_masuk_sekolah",
            "title": "Surat Izin Tidak Masuk Sekolah",
            "subtitle": "SMP/SMA"
          },
          {
            "key": "surat_permohonan_pindah_sekolah",
            "title": "Surat Permohonan Pindah Sekolah",
            "subtitle": "SMP/SMA"
          },
          {
            "key": "surat_permohonan_beasiswa",
            "title": "Surat Permohonan Beasiswa",
            "subtitle": "SMP/SMA",
          },
          {
            "key": "surat_pernyataan_tidak_menerima_beasiswa",
            "title": "Surat Pernyataan Tidak Menerima Beasiswa",
            "subtitle": "Kuliah/Kampus"
          },
          {
            "key": "surat_keterangan_penghasilan_orang_tua",
            "title": "Surat Keterangan Penghasilan Orang Tua",
            "subtitle": "Kuliah/Kampus"
          },
          {
            "key": "surat_persetujuan_orang_tua",
            "title": "Surat Persetujuan Orang Tua",
            "subtitle": "SMP/SMA"
          },
          {
            "key": "surat_perjanjian_tidak_mengulangi_kesalahan",
            "title": "Surat Perjanjian Tidak Mengulangi Kesalahan",
            "subtitle": "SMP/SMA"
          },
        ]
      },
      {
        "id": 2,
        "title": "Surat Pekerjaan",
        "letters": [
          {
            "key": "surat_permohonan_magang_kerja",
            "title": "Surat Permohonan Magang Kerja"
          },
          {
            "key": "surat_izin_tidak_masuk_kerja",
            "title": "Surat Izin Tidak Masuk Kerja"
          },
          {
            "key": "surat_permohonan_izin_cuti_kerja",
            "title": "Surat Permohonan Izin Cuti Kerja"
          },
          {"key": "surat_pengunduran_diri", "title": "Surat Pengunduran Diri"},
          {
            "key": "surat_pernyataan_kesediaan_bekerja_paruh_waktu",
            "title": "Surat Pernyataan Kesediaan Bekerja Paruh Waktu"
          },
          {
            "key": "surat_lamaran_pekerjaan",
            "title": "Surat Lamaran Pekerjaan"
          },
        ]
      },
      {
        "id": 3,
        "title": "Surat Desa",
        "letters": [
          {
            "key": "surat_keterangan_tidak_mampu",
            "title": "Surat Keterangan Tidak Mampu"
          },
          {
            "key": "surat_keterangan_domisili",
            "title": "Surat Keterangan Domisili"
          },
          // ─── 8 Surat Desa Baru ───
          {
            "key": "surat_pengantar_ktp",
            "title": "Surat Pengantar Pembuatan KTP"
          },
          {"key": "surat_keterangan_usaha", "title": "Surat Keterangan Usaha"},
          {
            "key": "surat_keterangan_belum_memiliki_rumah",
            "title": "Surat Keterangan Belum Memiliki Rumah"
          },
          {
            "key": "surat_keterangan_kelahiran",
            "title": "Surat Keterangan Kelahiran"
          },
          {
            "key": "surat_keterangan_kematian",
            "title": "Surat Keterangan Kematian"
          },
          {
            "key": "surat_keterangan_pindah",
            "title": "Surat Keterangan Pindah"
          },
          {"key": "surat_pengantar_nikah", "title": "Surat Pengantar Nikah"},
          {
            "key": "surat_keterangan_berkelakuan_baik",
            "title": "Surat Keterangan Berkelakuan Baik"
          },
          {
            "key": "surat_keterangan_ahli_waris",
            "title": "Surat Keterangan Ahli Waris"
          },
        ]
      },
      {
        "id": 4,
        "title": "Surat Bisnis",
        "letters": [
          {
            "key": "surat_kesepakatan_kerjasama",
            "title": "Surat Kesepakatan Kerjasama"
          },
          {
            "key": "surat_keterangan_tempat_usaha",
            "title": "Surat Keterangan Tempat Usaha"
          },
          // ─── 8 Surat Bisnis Baru ───
          {
            "key": "surat_penawaran_barang",
            "title": "Surat Penawaran Barang/Jasa"
          },
          {"key": "surat_pesanan_barang", "title": "Surat Pesanan Barang"},
          {
            "key": "surat_perjanjian_kerjasama_bisnis",
            "title": "Surat Perjanjian Kerjasama Bisnis"
          },
          {
            "key": "surat_komplain_barang",
            "title": "Surat Komplain Barang/Jasa"
          },
          {
            "key": "surat_permohonan_izin_usaha",
            "title": "Surat Permohonan Izin Usaha"
          },
          {
            "key": "surat_pemutusan_kerjasama",
            "title": "Surat Pemutusan Kerjasama"
          },
          {"key": "surat_kuasa_bisnis", "title": "Surat Kuasa Bisnis"},
          {
            "key": "surat_peringatan_pembayaran",
            "title": "Surat Peringatan Pembayaran"
          },
        ]
      },
      {
        "id": 5,
        "title": "Surat Umum",
        "letters": [
          {
            "key": "surat_pernyataan_kebenaran_dokumen",
            "title": "Surat Pernyataan Kebenaran Dokumen"
          },
          {
            "key": "surat_pernyataan_belum_menikah",
            "title": "Surat Pernyataan Belum Menikah"
          },
          {"key": "surat_pernyataan_cerai", "title": "Surat Pernyataan Cerai"},
          {
            "key": "surat_pernyataan_keluarga_tentang_kematian",
            "title": "Surat Pernyataan Keluarga Tentang Kematian"
          },
          {"key": "surat_permohonan_maaf", "title": "Surat Permohonan Maaf"},
        ]
      },
      {
        "id": 6,
        "title": "Surat Pribadi",
        "letters": [
          {
            "key": "surat_pernyataan_pemilik_tempat_tinggal",
            "title": "Surat Pernyataan Pemilik Tempat Tinggal"
          },
          {
            "key": "surat_persetujuan_suami_istri",
            "title": "Surat Persetujuan Suami Istri"
          },
          {
            "key": "surat_pernyataan_kehilangan_ijazah",
            "title": "Surat Pernyataan Kehilangan Ijazah",
          },
        ]
      },
      {
        "id": 7,
        "title": "Surat Keuangan",
        "letters": [
          {
            "key": "surat_pernyataan_kepemilikan_harta",
            "title": "Surat Pernyataan Kepemilikan Harta"
          },
          // ─── 8 Surat Keuangan Baru ───
          {"key": "surat_kwitansi_pembayaran", "title": "Kwitansi Pembayaran"},
          {
            "key": "surat_permohonan_pinjaman",
            "title": "Surat Permohonan Pinjaman"
          },
          {
            "key": "surat_pernyataan_hutang",
            "title": "Surat Pernyataan Hutang"
          },
          {
            "key": "surat_pernyataan_pelunasan_hutang",
            "title": "Surat Pernyataan Pelunasan Hutang"
          },
          {
            "key": "surat_kuasa_pengurusan_keuangan",
            "title": "Surat Kuasa Pengurusan Keuangan"
          },
          {
            "key": "surat_permohonan_pengembalian_dana",
            "title": "Surat Permohonan Pengembalian Dana"
          },
          {
            "key": "surat_pernyataan_penghasilan",
            "title": "Surat Pernyataan Penghasilan"
          },
          {
            "key": "surat_perjanjian_sewa_rumah",
            "title": "Surat Perjanjian Sewa Rumah"
          },
        ]
      },
      {
        "id": 8,
        "title": "Surat Kesehatan",
        "letters": [
          {
            "key": "surat_pernyataan_sehat_jasmani_rohani",
            "title": "Surat Pernyataan Sehat Jasmani dan Rohani",
          },
          // ─── 8 Surat Kesehatan Baru ───
          {"key": "surat_izin_sakit", "title": "Surat Izin Sakit"},
          {
            "key": "surat_keterangan_bebas_narkoba",
            "title": "Surat Pernyataan Bebas Narkoba"
          },
          {
            "key": "surat_persetujuan_tindakan_medis",
            "title": "Surat Persetujuan Tindakan Medis"
          },
          {
            "key": "surat_permohonan_rujukan_medis",
            "title": "Surat Permohonan Rujukan Medis"
          },
          {
            "key": "surat_pernyataan_riwayat_penyakit",
            "title": "Surat Pernyataan Riwayat Penyakit"
          },
          {
            "key": "surat_pernyataan_tidak_buta_warna",
            "title": "Surat Pernyataan Tidak Buta Warna"
          },
          {
            "key": "surat_pernyataan_tidak_hamil",
            "title": "Surat Pernyataan Tidak Hamil"
          },
          {
            "key": "surat_permohonan_bantuan_biaya_pengobatan",
            "title": "Surat Permohonan Bantuan Biaya Pengobatan"
          },
        ]
      },
    ];

    return result;
  }
}

List<Map<String, dynamic>> letterDataMap(String? image,
    {LetterModel? letter, AccountModel? account}) {
  return [
    // ─── Sekolah ───
    {
      "key": "surat_izin_tidak_masuk_sekolah",
      "title": "Surat Izin Tidak Masuk Sekolah",
      "html": suratIzinTidakMasukSekolah(letter, image, account)
    },
    {
      "key": "surat_permohonan_pindah_sekolah",
      "title": "Surat Permohonan Pindah Sekolah",
      "html": suratPermohonanPindahSekolah(letter, image, account)
    },
    {
      "key": "surat_permohonan_beasiswa",
      "title": "Surat Permohonan Beasiswa",
      "html": suratPermohonanBeaSiswa(letter, image, account)
    },
    {
      "key": "surat_pernyataan_tidak_menerima_beasiswa",
      "title": "Surat Pernyataan Tidak Menerima Beasiswa",
      "html": suratPernyataanTidakMenerimaBeasiswa(letter, image, account)
    },
    {
      "key": "surat_keterangan_penghasilan_orang_tua",
      "title": "Surat Keterangan Penghasilan Orang Tua",
      "html": suratKeteranganPenghasilanOrangTua(letter, image, account)
    },
    {
      "key": "surat_persetujuan_orang_tua",
      "title": "Surat Persetujuan Orang Tua",
      "html": suratPersetujuanOrangTua(letter, image, account)
    },
    {
      "key": "surat_perjanjian_tidak_mengulangi_kesalahan",
      "title": "Surat Perjanjian Tidak Mengulangi Kesalahan",
      "html": suratPerjanjianTidakMengulangiKesalahan(letter, image, account)
    },
    // ─── Pekerjaan ───
    {
      "key": "surat_permohonan_magang_kerja",
      "title": "Surat Permohonan Magang Kerja",
      "html": suratPermohonanMagangKerja(letter, image, account)
    },
    {
      "key": "surat_keterangan_tempat_usaha",
      "title": "Surat Keterangan Tempat Usaha",
      "html": suratKeteranganTempatUsaha(letter, image, account)
    },
    {
      "key": "surat_kesepakatan_kerjasama",
      "title": "Surat Kesepakatan Kerjasama",
      "html": suratKesepakatanKerjasama(letter, image, account)
    },
    {
      "key": "surat_izin_tidak_masuk_kerja",
      "title": "Surat Izin Tidak Masuk Kerja",
      "html": suratIzinTidakMasukKerja(letter, image, account)
    },
    {
      "key": "surat_permohonan_izin_cuti_kerja",
      "title": "Surat Permohonan Izin Cuti Kerja",
      "html": suratPermohonanIzinCutiKerja(letter, image, account)
    },
    {
      "key": "surat_pengunduran_diri",
      "title": "Surat Pengunduran Diri",
      "html": suratPengunduranDiri(letter, image, account)
    },
    {
      "key": "surat_pernyataan_kesediaan_bekerja_paruh_waktu",
      "title": "Surat Pernyataan Kesediaan Bekerja Paruh Waktu",
      "html": suratPernyataanKesediaanBekerjaPenuhWaktu(letter, image, account)
    },
    {
      "key": "surat_lamaran_pekerjaan",
      "title": "Surat Lamaran Pekerjaan",
      "html": suratLamaranPekerjaan(letter, image, account)
    },
    // ─── Umum ───
    {
      "key": "surat_pernyataan_belum_menikah",
      "title": "Surat Pernyataan Belum Menikah",
      "html": suratPernyataanBelumMenikah(letter, image, account)
    },
    {
      "key": "surat_pernyataan_cerai",
      "title": "Surat Pernyataan Cerai",
      "html": suratPernyataanCerai(letter, image, account)
    },
    {
      "key": "surat_pernyataan_keluarga_tentang_kematian",
      "title": "Surat Pernyataan Keluarga Tentang Kematian",
      "html": suratPernyataanKeluargaTentangKematian(letter, image, account)
    },
    {
      "key": "surat_permohonan_maaf",
      "title": "Surat Permohonan Maaf",
      "html": suratPermohonanMaaf(letter, image, account)
    },
    // ─── Desa ───
    {
      "key": "surat_keterangan_tidak_mampu",
      "title": "Surat Keterangan Tidak Mampu",
      "html": suratKeteranganTidakMampu(letter, image, account)
    },
    {
      "key": "surat_keterangan_domisili",
      "title": "Surat Keterangan Domisili",
      "html": suratKeteranganDomisili(letter, image, account)
    },
    // ─── Pribadi ───
    {
      "key": "surat_pernyataan_pemilik_tempat_tinggal",
      "title": "Surat Pernyataan Pemilik Tempat Tinggal",
      "html": suratPernyataanPemilikTempatTinggal(letter, image, account)
    },
    {
      "key": "surat_pernyataan_kebenaran_dokumen",
      "title": "Surat Pernyataan Kebenaran Dokumen",
      "html": suratPernyataanKebenaranDokumen(letter, image, account)
    },
    {
      "key": "surat_persetujuan_suami_istri",
      "title": "Surat Persetujuan Suami Istri",
      "html": suratPersetujuanSuamiIstri(letter, image, account)
    },
    {
      "key": "surat_pernyataan_kesanggupan_membayar_ukt",
      "title": "Surat Pernyataan Kesanggupan Membayar UKT",
      "html": suratPernyataanKesanggupanMembayarUkt(letter, image, account)
    },
    {
      "key": "surat_pernyataan_kehilangan_ijazah",
      "title": "Surat Pernyataan Kehilangan Ijazah",
      "html": suratPernyataanKehilanganIjazah(letter, image, account)
    },
    // ─── Keuangan (existing + 8 new) ───
    {
      "key": "surat_pernyataan_kepemilikan_harta",
      "title": "Surat Pernyataan Kepemilikan Harta",
      "html": suratPernyataanKepemilikanHarta(letter, image, account)
    },
    {
      "key": "surat_kwitansi_pembayaran",
      "title": "Kwitansi Pembayaran",
      "html": suratKwitansiPembayaran(letter, image, account)
    },
    {
      "key": "surat_permohonan_pinjaman",
      "title": "Surat Permohonan Pinjaman",
      "html": suratPermohonanPinjaman(letter, image, account)
    },
    {
      "key": "surat_pernyataan_hutang",
      "title": "Surat Pernyataan Hutang",
      "html": suratPernyataanHutang(letter, image, account)
    },
    {
      "key": "surat_pernyataan_pelunasan_hutang",
      "title": "Surat Pernyataan Pelunasan Hutang",
      "html": suratPernyataanPelunasanHutang(letter, image, account)
    },
    {
      "key": "surat_kuasa_pengurusan_keuangan",
      "title": "Surat Kuasa Pengurusan Keuangan",
      "html": suratKuasaPengurusanKeuangan(letter, image, account)
    },
    {
      "key": "surat_permohonan_pengembalian_dana",
      "title": "Surat Permohonan Pengembalian Dana",
      "html": suratPermohonanPengembalianDana(letter, image, account)
    },
    {
      "key": "surat_pernyataan_penghasilan",
      "title": "Surat Pernyataan Penghasilan",
      "html": suratPernyataanPenghasilan(letter, image, account)
    },
    {
      "key": "surat_perjanjian_sewa_rumah",
      "title": "Surat Perjanjian Sewa Rumah",
      "html": suratPerjanjianSewaRumah(letter, image, account)
    },
    // ─── Kesehatan (existing + 8 new) ───
    {
      "key": "surat_pernyataan_sehat_jasmani_rohani",
      "title": "Surat Pernyataan Sehat Jasmani dan Rohani",
      "html": suratPernyataanSehatJasmaniRohani(letter, image, account)
    },
    {
      "key": "surat_izin_sakit",
      "title": "Surat Izin Sakit",
      "html": suratIzinSakit(letter, image, account)
    },
    {
      "key": "surat_keterangan_bebas_narkoba",
      "title": "Surat Pernyataan Bebas Narkoba",
      "html": suratKeteranganBebasNarkoba(letter, image, account)
    },
    {
      "key": "surat_persetujuan_tindakan_medis",
      "title": "Surat Persetujuan Tindakan Medis",
      "html": suratPersetujuanTindakanMedis(letter, image, account)
    },
    {
      "key": "surat_permohonan_rujukan_medis",
      "title": "Surat Permohonan Rujukan Medis",
      "html": suratPermohonanRujukanMedis(letter, image, account)
    },
    {
      "key": "surat_pernyataan_riwayat_penyakit",
      "title": "Surat Pernyataan Riwayat Penyakit",
      "html": suratPernyataanRiwayatPenyakit(letter, image, account)
    },
    {
      "key": "surat_pernyataan_tidak_buta_warna",
      "title": "Surat Pernyataan Tidak Buta Warna",
      "html": suratPernyataanTidakButaWarna(letter, image, account)
    },
    {
      "key": "surat_pernyataan_tidak_hamil",
      "title": "Surat Pernyataan Tidak Hamil",
      "html": suratPernyataanTidakHamil(letter, image, account)
    },
    {
      "key": "surat_permohonan_bantuan_biaya_pengobatan",
      "title": "Surat Permohonan Bantuan Biaya Pengobatan",
      "html": suratPermohonanBantuanBiayaPengobatan(letter, image, account)
    },
    // ─── Bisnis (8 new) ───
    {
      "key": "surat_penawaran_barang",
      "title": "Surat Penawaran Barang/Jasa",
      "html": suratPenawaranBarang(letter, image, account)
    },
    {
      "key": "surat_pesanan_barang",
      "title": "Surat Pesanan Barang",
      "html": suratPesananBarang(letter, image, account)
    },
    {
      "key": "surat_perjanjian_kerjasama_bisnis",
      "title": "Surat Perjanjian Kerjasama Bisnis",
      "html": suratPerjanjianKerjasama(letter, image, account)
    },
    {
      "key": "surat_komplain_barang",
      "title": "Surat Komplain Barang/Jasa",
      "html": suratKomplainBarang(letter, image, account)
    },
    {
      "key": "surat_permohonan_izin_usaha",
      "title": "Surat Permohonan Izin Usaha",
      "html": suratPermohonanIzinUsaha(letter, image, account)
    },
    {
      "key": "surat_pemutusan_kerjasama",
      "title": "Surat Pemutusan Kerjasama",
      "html": suratPemutusanKerjasama(letter, image, account)
    },
    {
      "key": "surat_kuasa_bisnis",
      "title": "Surat Kuasa Bisnis",
      "html": suratKuasaBisnis(letter, image, account)
    },
    {
      "key": "surat_peringatan_pembayaran",
      "title": "Surat Peringatan Pembayaran",
      "html": suratPeringatanPembayaran(letter, image, account)
    },
    // ─── Desa (8 new) ───
    {
      "key": "surat_pengantar_ktp",
      "title": "Surat Pengantar Pembuatan KTP",
      "html": suratPengantarKtp(letter, image, account)
    },
    {
      "key": "surat_keterangan_usaha",
      "title": "Surat Keterangan Usaha",
      "html": suratKeteranganUsaha(letter, image, account)
    },
    {
      "key": "surat_keterangan_belum_memiliki_rumah",
      "title": "Surat Keterangan Belum Memiliki Rumah",
      "html": suratKeteranganBelumMemilikiRumah(letter, image, account)
    },
    {
      "key": "surat_keterangan_kelahiran",
      "title": "Surat Keterangan Kelahiran",
      "html": suratKeteranganKelahiran(letter, image, account)
    },
    {
      "key": "surat_keterangan_kematian",
      "title": "Surat Keterangan Kematian",
      "html": suratKeteranganKematian(letter, image, account)
    },
    {
      "key": "surat_keterangan_pindah",
      "title": "Surat Keterangan Pindah",
      "html": suratKeteranganPindah(letter, image, account)
    },
    {
      "key": "surat_pengantar_nikah",
      "title": "Surat Pengantar Nikah",
      "html": suratPengantarNikah(letter, image, account)
    },
    {
      "key": "surat_keterangan_berkelakuan_baik",
      "title": "Surat Keterangan Berkelakuan Baik",
      "html": suratKeteranganBerkelakuanBaik(letter, image, account)
    },
    {
      "key": "surat_keterangan_ahli_waris",
      "title": "Surat Keterangan Ahli Waris",
      "html": suratKeteranganAhliWaris(letter, image, account)
    },
  ];
}
