import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPerjanjianSewaRumahVariables = [
  LetterVariable(key: 'nama_penyewa', label: 'Nama Penyewa'),
  LetterVariable(
      key: 'alamat_penyewa',
      label: 'Alamat Penyewa',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'no_telepon', label: 'No. Telepon'),
  LetterVariable(
      key: 'alamat_rumah',
      label: 'Alamat Rumah',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'durasi', label: 'Durasi'),
  LetterVariable(
      key: 'tanggal_mulai',
      label: 'Tanggal Mulai',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
  LetterVariable(key: 'bulan_tahun', label: 'Bulan/Tahun'),
];

String suratPerjanjianSewaRumah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERJANJIAN SEWA RUMAH</b>
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
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut sebagai <b>PIHAK PERTAMA (Pemilik)</b>.
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_penyewa', '... (Nama Penyewa)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_penyewa', '... (Alamat Penyewa)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'no_telepon', '... (No. Telepon)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut sebagai <b>PIHAK KEDUA (Penyewa)</b>.
    </p>
    <p style="text-align: justify; ">
      Kedua belah pihak sepakat mengadakan perjanjian sewa rumah dengan ketentuan:
    </p>
    <p>
      <ol>
        <li>Objek sewa berupa rumah yang terletak di ${fillVar(vars, 'alamat_rumah', '... (Alamat Rumah)')}</li>
        <li>Jangka waktu sewa selama ${fillVar(vars, 'durasi', '... (Durasi)')} terhitung sejak ${fillVar(vars, 'tanggal_mulai', '... (Tanggal Mulai)')}</li>
        <li>Harga sewa sebesar ${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')} per ${fillVar(vars, 'bulan_tahun', '... (Bulan/Tahun)')}</li>
        <li>Pembayaran dilakukan di muka sebelum masa sewa dimulai</li>
        <li>Penyewa wajib menjaga dan merawat rumah dengan baik</li>
      </ol>
    </p>
    <p style="text-align: justify; ">
      Demikian surat perjanjian sewa rumah ini dibuat dan ditandatangani oleh kedua belah pihak dalam keadaan sadar tanpa paksaan.
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
              <span style="white-space: nowrap">${fillVar(vars, 'nama_penyewa', '... (Nama Penyewa)')}</span>
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
