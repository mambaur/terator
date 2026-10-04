import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratUndanganAcaraVariables = [
  LetterVariable(key: 'nomor_surat', label: 'Nomor Surat'),
  LetterVariable(key: 'nama_acara', label: 'Nama Acara'),
  LetterVariable(key: 'nama_yang_diundang', label: 'Nama yang Diundang'),
  LetterVariable(
      key: 'hari_tanggal_pelaksanaan',
      label: 'Hari, Tanggal Pelaksanaan',
      type: LetterVariableType.dateWithDay),
  LetterVariable(
      key: 'pukul', label: 'Pukul', hint: 'mis. 09.00 WIB s/d Selesai'),
  LetterVariable(key: 'nama_tempat', label: 'Nama Tempat'),
  LetterVariable(
      key: 'alamat_lengkap',
      label: 'Alamat Lengkap',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'rincian_tema_acara',
      label: 'Rincian/Tema Acara',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'dress_code',
      label: 'Dress Code',
      hint: 'mis. Rapi/Batik/Bebas Sopan'),
  LetterVariable(key: 'jabatan', label: 'Jabatan', hint: 'mis. Ketua Panitia'),
];

String suratUndanganAcara(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Nomor&nbsp;&nbsp;&nbsp;&nbsp;: ${fillVar(vars, 'nomor_surat', '... (Nomor Surat)')}
      <br>
      Lampiran&nbsp;: -
      <br>
      Perihal&nbsp;&nbsp;&nbsp;: ${fillVar(vars, 'nama_acara', 'Undangan ... (Nama Acara)', prefix: 'Undangan ')}
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_yang_diundang', '... (Nama yang Diundang)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Assalamu'alaikum Warahmatullahi Wabarakatuh,
    </p>
    <p style="text-align: justify; ">
      Salam sejahtera kami sampaikan, semoga Bapak/Ibu/Saudara/i senantiasa dalam keadaan sehat dan dilimpahkan rahmat oleh Tuhan Yang Maha Esa.
    </p>
    <p style="text-align: justify; ">
      Sehubungan dengan akan diadakannya ${fillVar(vars, 'nama_acara', '... (Nama Acara)')}, dengan ini kami selaku panitia/penyelenggara bermaksud mengundang Bapak/Ibu/Saudara/i untuk hadir pada:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hari_tanggal_pelaksanaan', '... (Hari, Tanggal Pelaksanaan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'pukul', '... (Pukul, mis. 09.00 WIB s/d Selesai)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_tempat', '... (Nama Tempat)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_lengkap', '... (Alamat Lengkap)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Acara</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'rincian_tema_acara', '... (Rincian/Tema Acara)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Dress Code</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'dress_code', '... (Dress Code, mis. Rapi/Batik/Bebas Sopan)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Mengingat pentingnya acara ini, kami sangat mengharapkan kehadiran Bapak/Ibu/Saudara/i tepat pada waktu yang telah ditentukan.
    </p>
    <p style="text-align: justify; ">
      Demikian undangan ini kami sampaikan. Atas perhatian dan kehadirannya, kami ucapkan terima kasih.
    </p>
    <p style="text-align: justify; ">
      Wassalamu'alaikum Warahmatullahi Wabarakatuh.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat kami,</span>
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
              <br>
              <span style="white-space: nowrap">${fillVar(vars, 'jabatan', '... (Jabatan, mis. Ketua Panitia)')}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
