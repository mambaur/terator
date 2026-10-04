import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable>
    suratPernyataanBersediaMengikutiPeraturanPerusahaanVariables = [
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(key: 'jabatan_yang_dilamar', label: 'Jabatan yang Dilamar'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
];

String suratPernyataanBersediaMengikutiPeraturanPerusahaan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN BERSEDIA MENGIKUTI PERATURAN PERUSAHAAN</b>
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
            <td style="white-space: nowrap">Jenis Kelamin</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.gender ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Agama</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.religion ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Pendidikan Terakhir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.lastEducation ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik', '... (Nomor KTP/NIK)')}</td>
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
      Dengan ini menyatakan dengan sesungguhnya bahwa apabila saya diterima bekerja sebagai ${fillVar(vars, 'jabatan_yang_dilamar', '... (Jabatan yang Dilamar)')} di ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}, maka saya bersedia:
    </p>
    <p style="text-align: justify; ">
      1. <b>Mematuhi seluruh peraturan dan tata tertib</b> yang berlaku di perusahaan, baik yang telah ada saat ini maupun yang akan ditetapkan kemudian;
    </p>
    <p style="text-align: justify; ">
      2. <b>Menjalankan tugas dan tanggung jawab</b> dengan penuh disiplin, jujur, loyal, dan profesional;
    </p>
    <p style="text-align: justify; ">
      3. <b>Menjaga nama baik perusahaan</b> serta tidak melakukan tindakan yang dapat merugikan perusahaan baik secara materiil maupun non-materiil;
    </p>
    <p style="text-align: justify; ">
      4. <b>Tidak akan melakukan</b> tindakan indisipliner, korupsi, kolusi, nepotisme, maupun pelanggaran kode etik lainnya yang berlaku di perusahaan;
    </p>
    <p style="text-align: justify; ">
      5. <b>Bersedia menerima sanksi</b> sesuai dengan peraturan perusahaan apabila terbukti melakukan pelanggaran.
    </p>
    <p style="text-align: justify; ">
      Apabila di kemudian hari saya melanggar pernyataan ini, maka saya bersedia menerima konsekuensi sesuai dengan ketentuan yang berlaku di perusahaan, termasuk pemutusan hubungan kerja tanpa syarat.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya, dalam keadaan sadar dan tanpa paksaan dari pihak manapun, untuk dapat dipergunakan sebagaimana mestinya.
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
