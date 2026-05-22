import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratUndanganAcara(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Nomor&nbsp;&nbsp;&nbsp;&nbsp;: <b>... (Nomor Surat)</b>
      <br>
      Lampiran&nbsp;: -
      <br>
      Perihal&nbsp;&nbsp;&nbsp;: <b>Undangan ... (Nama Acara)</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama yang Diundang)</b>
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
      Sehubungan dengan akan diadakannya <b>... (Nama Acara)</b>, dengan ini kami selaku panitia/penyelenggara bermaksud mengundang Bapak/Ibu/Saudara/i untuk hadir pada:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Hari, Tanggal Pelaksanaan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Pukul, mis. 09.00 WIB s/d Selesai)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Tempat)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Alamat Lengkap)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Acara</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Rincian/Tema Acara)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Dress Code</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Dress Code, mis. Rapi/Batik/Bebas Sopan)</b></td>
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
              <span style="white-space: nowrap"><b>... (Jabatan, mis. Ketua Panitia)</b></span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
