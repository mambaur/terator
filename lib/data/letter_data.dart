import 'package:intl/intl.dart';
import 'package:terator/models/letter_model.dart';

class LetterData {
  static String html(String key, {String? image, LetterModel? letter}) {
    List<Map<String, dynamic>> data = letterDataMap(image, letter: letter)
        .where((element) => element['key'] == key)
        .toList();
    if (data.isEmpty) return '';
    return data[0]['html'];
  }
}

List<Map<String, dynamic>> letterDataMap(String? image, {LetterModel? letter}) {
  return [
    {"key": "surat_izin_sekolah", "html": suratIzinSekolah(letter, image)},
    {"key": "surat_izin_kampus", "html": suratIzinKamus(letter, image)},
  ];
}

String suratIzinSekolah(LetterModel? letter, String? img) {
  String dateNow =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  // String image = img != null
  //     ? "<p style='margin-top:10px;margin-bottom:10px'><img width='35%' src='$img'></p>"
  //     : '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html =
      '<p style="text-align: right; ">$dateNow</p><p>Kepada Yth.<br>Bapak/Ibu Guru Wali Kelas C IPS 3<br>SMA Negeri 1 Jakarta</p><p><br></p><p>Dengan Hormat,</p><p>Yang bertanda tangan dibawah ini:</p><p>Nama : Achmad Suryana Adibrata<br>Alamat : Jl. Jenderal Soedirman</p><p>Orange tua/Wali murid dari:</p><p>Name : Maulidia Anindita Prameswari<br>Kelas: X IPS 3</p><p>Memberitahukan bahwa siswa tersebut tidak dapat mengikuti proses belajar did sekolah pada hari Senin, 15 February 2021 dikarenakan mengikuti acara pernikahan kakak.</p><p>Demikian Surat ini saya sampaikan. Atas perhatian Bapak/Ibu saya ucapkan terimakasih.</p><p><br></p><p style="text-align: right; ">Hormat saya,</p>$image<p style="text-align: right; ">Achmad Suryana Adibrata</p>';

  return html;
}

String suratIzinKamus(LetterModel? letter, String? img) {
  String dateNow =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String html =
      '<p style="text-align: right; ">$dateNow</p><p>Kepada Yth.</p><p>Bapak/Ibu Guru Wali Kelas C IPS 3</p><p>SMA Negeri 1 Jakarta</p><p><br></p><p>Dengan Hormat,</p><p>Yang bertanda tangan dibawah ini:</p><p>Nama : Achmad Suryana Adibrata</p><p>Alamat : Jl. Jenderal Soedirman</p><p>Orange tua/Wali murid dari:</p><p>Name : Maulidia Anindita Prameswari</p><p>Kelas: X IPS 3</p><p>Memberitahukan bahwa siswa tersebut tidak dapat mengikuti proses belajar did sekolah pada hari Senin, 15 February 2021 dikarenakan mengikuti acara pernikahan kakak.</p><p><br></p><p>Demikian Surat ini saya sampaikan. Atas perhatian Bapak/Ibu saya ucapkan terimakasih.</p><p><br></p><p style="text-align: right; ">Hormat saya,</p><p style="text-align: right; "><br></p><p style="text-align: right; "><br></p><p style="text-align: right; ">Achmad Suryana Adibrata</p>';

  return html;
}
