import 'package:terator/data/letter_functions/bisnis/surat_keterangan_tempat_usaha.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_domisili.dart';
import 'package:terator/data/letter_functions/desa/surat_keterangan_tidak_mampu.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_izin_tidak_masuk_kerja.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_lamaran_pekerjaan.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_pengunduran_diri.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_permohonan_izin_cuti_kerja.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_permohonan_magang_kerja.dart';
import 'package:terator/data/letter_functions/pekerjaan/surat_pernyataan_kesediaan_bekerja_penuh_waktu.dart';
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
import 'package:terator/data/letter_functions/umum/surat_pernyataan_keluarga_tentang_kematian.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

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

  static Future<List<Map<String, dynamic>>> listLetters({String q = ''}) async {
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
            "subtitle": "SMP/SMA"
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
            "title": "Surat Permohonan Magang Kerja"
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
        ]
      },
      {
        "id": 4,
        "title": "Surat Bisnis",
        "letters": [
          {
            "key": "surat_keterangan_tempat_usaha",
            "title": "Surat Keterangan Tempat Usaha"
          },
        ]
      },
      {
        "id": 5,
        "title": "Surat Umum",
        "letters": [
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
    ];

    return result;
  }
}

List<Map<String, dynamic>> letterDataMap(String? image,
    {LetterModel? letter, AccountModel? account}) {
  return [
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
      "key": "surat_izin_tidak_masuk_kerja",
      "title": "Surat Izin Tidak Masuk Kerja",
      "html": suratIzinTidakMasukKerja(letter, image, account)
    },
    {
      "key": "surat_permohonan_izin_cuti_kerja",
      "title": " Surat Permohonan Izin Cuti Kerja",
      "html": suratPermohonanIzinCutiKerja(letter, image, account)
    },
    {
      "key": "surat_pengunduran_diri",
      "title": "Surat Pengunduran Diri",
      "html": suratPengunduranDiri(letter, image, account)
    },
    {
      "key": "surat_pernyataan_kesediaan_bekerja_paruh_waktu",
      "title": " Surat Pernyataan Kesediaan Bekerja Paruh Waktu",
      "html": suratPernyataanKesediaanBekerjaPenuhWaktu(letter, image, account)
    },
    {
      "key": "surat_lamaran_pekerjaan",
      "title": "Surat Lamaran Pekerjaan",
      "html": suratLamaranPekerjaan(letter, image, account)
    },
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
  ];
}
