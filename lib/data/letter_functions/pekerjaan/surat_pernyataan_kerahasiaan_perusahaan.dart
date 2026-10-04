import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanKerahasiaanPerusahaanVariables = [
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(key: 'nik_nip_karyawan', label: 'NIK/NIP Karyawan'),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'divisi_departemen', label: 'Divisi/Departemen'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
];

String suratPernyataanKerahasiaanPerusahaan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN KERAHASIAAN PERUSAHAAN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.name ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik', '... (Nomor KTP/NIK)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">NIK/NIP Karyawan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nik_nip_karyawan', '... (NIK/NIP Karyawan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jabatan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jabatan', '... (Jabatan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Divisi/Departemen</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'divisi_departemen', '... (Divisi/Departemen)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.address ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Telp</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.telephone ?? ''}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyatakan dengan sesungguhnya bahwa selama bekerja maupun setelah berakhirnya hubungan kerja dengan ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}, saya berkomitmen untuk:
    </p>
    <p style="text-align: justify; ">
      1. <b>Menjaga kerahasiaan</b> seluruh informasi, data, dokumen, strategi bisnis, rahasia dagang, daftar pelanggan, formula, sistem, maupun materi lain yang bersifat rahasia milik perusahaan;
    </p>
    <p style="text-align: justify; ">
      2. <b>Tidak mengungkapkan, menyebarluaskan, atau memberikan</b> informasi rahasia tersebut kepada pihak ketiga manapun, baik secara lisan, tertulis, maupun melalui media elektronik, tanpa izin tertulis dari pimpinan perusahaan;
    </p>
    <p style="text-align: justify; ">
      3. <b>Tidak menggunakan</b> informasi rahasia perusahaan untuk kepentingan pribadi, kepentingan pihak lain, maupun untuk kepentingan perusahaan pesaing;
    </p>
    <p style="text-align: justify; ">
      4. <b>Mengembalikan</b> seluruh dokumen, perangkat, dan materi yang berkaitan dengan informasi rahasia perusahaan pada saat berakhirnya hubungan kerja.
    </p>
    <p style="text-align: justify; ">
      Apabila di kemudian hari saya terbukti melanggar pernyataan ini, maka saya bersedia bertanggung jawab penuh secara hukum dan menerima sanksi sesuai dengan peraturan perusahaan serta peraturan perundang-undangan yang berlaku, termasuk tuntutan ganti rugi atas seluruh kerugian yang ditimbulkan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya, dalam keadaan sadar dan tanpa paksaan dari pihak manapun.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Yang menyatakan,</span>
          </td>
        </tr>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            ${img ?? '<br><br><br><br><br>'}
          </td>
        </tr>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">( ${account?.name ?? ''} )</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
