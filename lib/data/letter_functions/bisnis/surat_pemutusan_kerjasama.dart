import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPemutusanKerjasamaVariables = [
  LetterVariable(key: 'nama_mitra_perusahaan', label: 'Nama Mitra/Perusahaan'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'no_surat', label: 'No. Surat'),
  LetterVariable(
      key: 'tanggal', label: 'Tanggal', type: LetterVariableType.date),
  LetterVariable(
      key: 'alasan', label: 'Alasan', type: LetterVariableType.multiline),
  LetterVariable(
      key: 'tanggal_efektif',
      label: 'Tanggal Efektif',
      type: LetterVariableType.date),
];

String suratPemutusanKerjasama(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_mitra_perusahaan', '... (Nama Mitra/Perusahaan)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Pemutusan Kerjasama</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Menunjuk surat perjanjian kerjasama nomor ${fillVar(vars, 'no_surat', '... (No. Surat)')} tertanggal ${fillVar(vars, 'tanggal', '... (Tanggal)')}, dengan ini kami memberitahukan bahwa kami bermaksud mengakhiri kerjasama yang telah berjalan antara kedua belah pihak.
    </p>
    <p style="text-align: justify; ">
      Adapun alasan pemutusan kerjasama ini adalah ${fillVar(vars, 'alasan', '... (Alasan)')}.
    </p>
    <p style="text-align: justify; ">
      Pemutusan kerjasama ini berlaku efektif pada tanggal ${fillVar(vars, 'tanggal_efektif', '... (Tanggal Efektif)')}. Segala hak dan kewajiban yang belum terselesaikan akan diselesaikan sesuai dengan ketentuan dalam perjanjian kerjasama.
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
