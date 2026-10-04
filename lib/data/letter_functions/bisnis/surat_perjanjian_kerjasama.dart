import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPerjanjianKerjasamaVariables = [
  LetterVariable(key: 'jabatan_pihak_pertama', label: 'Jabatan Pihak Pertama'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nama_mitra', label: 'Nama Mitra'),
  LetterVariable(key: 'jabatan_pihak_kedua', label: 'Jabatan Pihak Kedua'),
  LetterVariable(key: 'nama_perusahaan_mitra', label: 'Nama Perusahaan Mitra'),
  LetterVariable(
      key: 'alamat_mitra',
      label: 'Alamat Mitra',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'detail_kerjasama',
      label: 'Detail Kerjasama',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'durasi_kerjasama', label: 'Durasi Kerjasama'),
  LetterVariable(
      key: 'detail_hak_dan_kewajiban',
      label: 'Detail Hak dan Kewajiban',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'persentase_detail_pembagian', label: 'Persentase/Detail Pembagian'),
];

String suratPerjanjianKerjasama(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERJANJIAN KERJASAMA BISNIS</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Pada hari ini, $dateNow2, yang bertanda tangan di bawah ini:
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jabatan_pihak_pertama', '... (Jabatan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut <b>PIHAK PERTAMA</b>, dan:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_mitra', '... (Nama Mitra)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jabatan_pihak_kedua', '... (Jabatan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan_mitra', '... (Nama Perusahaan Mitra)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_mitra', '... (Alamat Mitra)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut <b>PIHAK KEDUA</b>, sepakat mengadakan perjanjian kerjasama dengan ketentuan:
    </p>
    <p>
      <ol>
        <li><b>Ruang Lingkup:</b> ${fillVar(vars, 'detail_kerjasama', '... (Detail Kerjasama)')}</li>
        <li><b>Jangka Waktu:</b> ${fillVar(vars, 'durasi_kerjasama', '... (Durasi Kerjasama)')}</li>
        <li><b>Hak dan Kewajiban:</b> ${fillVar(vars, 'detail_hak_dan_kewajiban', '... (Detail Hak dan Kewajiban)')}</li>
        <li><b>Pembagian Keuntungan:</b> ${fillVar(vars, 'persentase_detail_pembagian', '... (Persentase/Detail Pembagian)')}</li>
        <li><b>Penyelesaian Perselisihan:</b> Diselesaikan secara musyawarah</li>
      </ol>
    </p>
    <p style="text-align: justify; ">
      Demikian surat perjanjian ini dibuat dalam rangkap dua yang memiliki kekuatan hukum yang sama.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pihak Kedua</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Pihak Pertama,</span>
          </td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            ${img == null ? '<br><br><br><br><br>' : ''}
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            ${img ?? ''}
          </td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">${fillVar(vars, 'nama_mitra', '... (Nama Mitra)')}</span>
            </p>
          </td>
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
