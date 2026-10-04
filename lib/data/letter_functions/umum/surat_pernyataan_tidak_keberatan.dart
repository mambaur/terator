import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanTidakKeberatanVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(
      key: 'uraian_hal_yang_tidak_dikeberatkan',
      label: 'Uraian Hal yang Tidak Dikeberatkan',
      type: LetterVariableType.multiline,
      hint: 'mis. Penggunaan Lahan/Pembangunan/Pengangkatan/Penggunaan Nama'),
  LetterVariable(
      key: 'nama_pihak_yang_bersangkutan',
      label: 'Nama Pihak yang Bersangkutan'),
  LetterVariable(
      key: 'pertimbangan_alasan_tidak_keberatan',
      label: 'Pertimbangan/Alasan Tidak Keberatan',
      type: LetterVariableType.multiline),
];

String suratPernyataanTidakKeberatan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN TIDAK KEBERATAN</b>
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
            <td style="white-space: nowrap">Pekerjaan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'pekerjaan', '... (Pekerjaan)')}</td>
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
      Dengan ini menyatakan dengan sebenar-benarnya bahwa saya <b>TIDAK KEBERATAN</b> atas ${fillVar(vars, 'uraian_hal_yang_tidak_dikeberatkan', '... (Uraian Hal yang Tidak Dikeberatkan, mis. Penggunaan Lahan/Pembangunan/Pengangkatan/Penggunaan Nama)')} yang dilakukan oleh ${fillVar(vars, 'nama_pihak_yang_bersangkutan', '... (Nama Pihak yang Bersangkutan)')}.
    </p>
    <p style="text-align: justify; ">
      Pernyataan tidak keberatan ini saya berikan secara sukarela, tanpa paksaan dari pihak manapun, serta dalam keadaan sadar dan sehat jasmani maupun rohani.
    </p>
    <p style="text-align: justify; ">
      Sebagai dasar pertimbangan, hal-hal yang saya pertimbangkan adalah: ${fillVar(vars, 'pertimbangan_alasan_tidak_keberatan', '... (Pertimbangan/Alasan Tidak Keberatan)')}.
    </p>
    <p style="text-align: justify; ">
      Saya juga menyatakan bahwa di kemudian hari saya tidak akan mengajukan tuntutan, gugatan, ataupun keberatan dalam bentuk apapun terkait dengan hal yang saya nyatakan di atas. Apabila di kemudian hari pernyataan ini terbukti tidak benar, maka saya bersedia mempertanggungjawabkan sepenuhnya secara hukum.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya untuk dapat dipergunakan sebagaimana mestinya.
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
