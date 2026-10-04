import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKuasaPengambilanDokumenVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(key: 'nama_penerima_kuasa', label: 'Nama Penerima Kuasa'),
  LetterVariable(
      key: 'tempat_tgl_lahir_penerima_kuasa',
      label: 'Tempat/Tgl. Lahir Penerima Kuasa'),
  LetterVariable(
      key: 'pekerjaan_penerima_kuasa', label: 'Pekerjaan Penerima Kuasa'),
  LetterVariable(
      key: 'nomor_ktp_nik_penerima_kuasa',
      label: 'Nomor KTP/NIK Penerima Kuasa'),
  LetterVariable(
      key: 'hubungan_dengan_pemberi_kuasa',
      label: 'Hubungan dengan Pemberi Kuasa'),
  LetterVariable(
      key: 'alamat_penerima_kuasa',
      label: 'Alamat Penerima Kuasa',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'no_telp_penerima_kuasa', label: 'No. Telp Penerima Kuasa'),
  LetterVariable(
      key: 'jenis_dokumen_yang_diambil', label: 'Jenis Dokumen yang Diambil'),
  LetterVariable(
      key: 'nama_instansi_tempat_pengambilan',
      label: 'Nama Instansi/Tempat Pengambilan'),
  LetterVariable(
      key: 'alamat_instansi',
      label: 'Alamat Instansi',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'alasan_tidak_dapat_mengambil_sendiri',
      label: 'Alasan Tidak Dapat Mengambil Sendiri',
      type: LetterVariableType.multiline),
];

String suratKuasaPengambilanDokumen(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KUASA PENGAMBILAN DOKUMEN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini, selaku <b>Pemberi Kuasa</b>:
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
    </p>
    <p style="text-align: justify; ">
      Dengan ini memberikan kuasa kepada, selaku <b>Penerima Kuasa</b>:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_penerima_kuasa', '... (Nama Penerima Kuasa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tempat_tgl_lahir_penerima_kuasa', '... (Tempat/Tgl. Lahir Penerima Kuasa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Pekerjaan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'pekerjaan_penerima_kuasa', '... (Pekerjaan Penerima Kuasa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik_penerima_kuasa', '... (Nomor KTP/NIK Penerima Kuasa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hubungan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hubungan_dengan_pemberi_kuasa', '... (Hubungan dengan Pemberi Kuasa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_penerima_kuasa', '... (Alamat Penerima Kuasa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Telp</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'no_telp_penerima_kuasa', '... (No. Telp Penerima Kuasa)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      <b>--------------------------------------- KHUSUS ---------------------------------------</b>
    </p>
    <p style="text-align: justify; ">
      Untuk dan atas nama Pemberi Kuasa mengambil dokumen berupa ${fillVar(vars, 'jenis_dokumen_yang_diambil', '... (Jenis Dokumen yang Diambil)')} di ${fillVar(vars, 'nama_instansi_tempat_pengambilan', '... (Nama Instansi/Tempat Pengambilan)')} yang beralamat di ${fillVar(vars, 'alamat_instansi', '... (Alamat Instansi)')}.
    </p>
    <p style="text-align: justify; ">
      Surat kuasa ini diberikan karena Pemberi Kuasa berhalangan untuk mengambil dokumen tersebut secara langsung, dengan alasan ${fillVar(vars, 'alasan_tidak_dapat_mengambil_sendiri', '... (Alasan Tidak Dapat Mengambil Sendiri)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat kuasa ini dibuat dengan sebenar-benarnya untuk dapat dipergunakan sebagaimana mestinya. Segala akibat yang timbul dari penggunaan surat kuasa ini menjadi tanggung jawab bersama.
    </p>
    <p><br></p>
    <p style="text-align: center;">
      ${account?.letterCityWritten ?? ''}, $dateNow2
    </p>
    <table border="0" style="width:100%">
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Penerima Kuasa,</span>
            <br><br><br><br><br>
            <p>
              <span style="white-space: nowrap">( ${fillVar(vars, 'nama_penerima_kuasa', '... (Nama Penerima Kuasa)')} )</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Pemberi Kuasa,</span>
            <br>
            ${img ?? '<br><br><br><br><br>'}
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
