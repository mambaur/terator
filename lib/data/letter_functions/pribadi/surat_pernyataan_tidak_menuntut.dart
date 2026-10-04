import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanTidakMenuntutVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(
      key: 'uraian_peristiwa_kejadian',
      label: 'Uraian Peristiwa/Kejadian',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'tanggal_kejadian',
      label: 'Tanggal Kejadian',
      type: LetterVariableType.date),
  LetterVariable(key: 'lokasi_kejadian', label: 'Lokasi Kejadian'),
  LetterVariable(key: 'nama_pihak_kedua', label: 'Nama Pihak Kedua'),
];

String suratPernyataanTidakMenuntut(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN TIDAK MENUNTUT</b>
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
      Selanjutnya disebut sebagai <b>PIHAK PERTAMA</b>.
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyatakan dengan sesungguhnya bahwa sehubungan dengan peristiwa ${fillVar(vars, 'uraian_peristiwa_kejadian', '... (Uraian Peristiwa/Kejadian)')} yang terjadi pada tanggal ${fillVar(vars, 'tanggal_kejadian', '... (Tanggal Kejadian)')} di ${fillVar(vars, 'lokasi_kejadian', '... (Lokasi Kejadian)')} yang melibatkan saya dengan ${fillVar(vars, 'nama_pihak_kedua', '... (Nama Pihak Kedua)')}, maka:
    </p>
    <p style="text-align: justify; ">
      1. Saya selaku PIHAK PERTAMA <b>TIDAK AKAN MENUNTUT</b> baik secara pidana maupun perdata kepada PIHAK KEDUA atas peristiwa tersebut, karena permasalahan telah diselesaikan secara kekeluargaan dengan baik dan damai.
    </p>
    <p style="text-align: justify; ">
      2. Saya bersedia mencabut segala bentuk pengaduan, laporan, maupun tuntutan yang telah atau akan diajukan terkait peristiwa tersebut.
    </p>
    <p style="text-align: justify; ">
      3. Pernyataan ini dibuat tanpa adanya tekanan, paksaan, ataupun pengaruh dari pihak manapun.
    </p>
    <p style="text-align: justify; ">
      Apabila di kemudian hari saya melanggar pernyataan ini, maka saya bersedia menerima sanksi sesuai dengan peraturan perundang-undangan yang berlaku.
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
