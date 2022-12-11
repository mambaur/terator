import 'package:terator/data/letter_functions/surat_izin_kampus.dart';
import 'package:terator/data/letter_functions/surat_izin_sekolah.dart';
import 'package:terator/data/letter_functions/surat_permohonan_beasiswa.dart';
import 'package:terator/data/letter_functions/surat_permohonan_pindah_sekolah.dart';
import 'package:terator/data/letter_functions/surat_pernyataan_tidak_menerima_beasiswa.dart';
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
            "key": "surat_izin_sekolah",
            "title": "Surat Izin Sekolah",
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
        ]
      },
      {
        "id": 2,
        "title": "Surat Pekerjaan",
        "letters": [
          {"key": "surat_izin_sekolah", "title": "Surat Lamaran Kerja"},
        ]
      },
      {
        "id": 3,
        "title": "Surat Kantor",
        "letters": [
          {"key": "surat_izin_sekolah", "title": "Surat Lamaran Kerja"},
        ]
      },
      {
        "id": 4,
        "title": "Surat Bisnis",
        "letters": [
          {"key": "surat_izin_sekolah", "title": "Surat Lamaran Kerja"},
        ]
      },
      {
        "id": 5,
        "title": "Surat Pekerjaan",
        "letters": [
          {"key": "surat_izin_sekolah", "title": "Surat Lamaran Kerja"},
        ]
      },
    ];

    if (q != '') {
      result = result
          .where((e) => (e["title"]).toLowerCase().contains(q.toLowerCase()))
          .toList();
    }

    return result;
  }
}

List<Map<String, dynamic>> letterDataMap(String? image,
    {LetterModel? letter, AccountModel? account}) {
  return [
    {
      "key": "surat_izin_sekolah",
      "html": suratIzinSekolah(letter, image, account)
    },
    {
      "key": "surat_permohonan_pindah_sekolah",
      "html": suratPermohonanPindahSekolah(letter, image, account)
    },
    {
      "key": "surat_permohonan_beasiswa",
      "html": suratPermohonanBeaSiswa(letter, image, account)
    },
    {
      "key": "surat_pernyataan_tidak_menerima_beasiswa",
      "html": suratPernyataanTidakMenerimaBeasiswa(letter, image, account)
    },
    {"key": "surat_izin_kampus", "html": suratIzinKampus(letter, image)},
  ];
}
