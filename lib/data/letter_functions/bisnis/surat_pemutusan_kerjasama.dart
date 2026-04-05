import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPemutusanKerjasama(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Mitra/Perusahaan)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Pemutusan Kerjasama</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Menunjuk surat perjanjian kerjasama nomor <b>... (No. Surat)</b> tertanggal <b>... (Tanggal)</b>, dengan ini kami memberitahukan bahwa kami bermaksud mengakhiri kerjasama yang telah berjalan antara kedua belah pihak.
    </p>
    <p style="text-align: justify; ">
      Adapun alasan pemutusan kerjasama ini adalah <b>... (Alasan)</b>.
    </p>
    <p style="text-align: justify; ">
      Pemutusan kerjasama ini berlaku efektif pada tanggal <b>... (Tanggal Efektif)</b>. Segala hak dan kewajiban yang belum terselesaikan akan diselesaikan sesuai dengan ketentuan dalam perjanjian kerjasama.
    </p>
    <p style="text-align: justify; ">
      Demikian surat ini kami sampaikan. Atas perhatian dan pengertiannya kami ucapkan terima kasih.
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
              <span style="white-space: nowrap">${account?.name ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
