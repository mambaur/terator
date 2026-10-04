import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanRiwayatPenyakitVariables = [
  LetterVariable(key: 'nama_penyakit_1', label: 'Nama Penyakit 1'),
  LetterVariable(
      key: 'tahun_penyakit_1',
      label: 'Tahun Penyakit 1',
      type: LetterVariableType.number),
  LetterVariable(key: 'nama_penyakit_2', label: 'Nama Penyakit 2'),
  LetterVariable(
      key: 'tahun_penyakit_2',
      label: 'Tahun Penyakit 2',
      type: LetterVariableType.number),
  LetterVariable(
      key: 'riwayat_penyakit_lainnya', label: 'Riwayat Penyakit Lainnya'),
  LetterVariable(key: 'tujuan_surat', label: 'Tujuan Surat'),
];

String suratPernyataanRiwayatPenyakit(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN RIWAYAT PENYAKIT</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini:
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
						<td style="white-space: nowrap">Tempat, tgl lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
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
      Dengan ini menyatakan bahwa saya memiliki/tidak memiliki riwayat penyakit sebagai berikut:
    </p>
    <p>
      <ol>
        <li>${fillVar(vars, 'nama_penyakit_1', '... (Nama Penyakit 1)')} — Tahun ${fillVar(vars, 'tahun_penyakit_1', '... (Tahun)')}</li>
        <li>${fillVar(vars, 'nama_penyakit_2', '... (Nama Penyakit 2)')} — Tahun ${fillVar(vars, 'tahun_penyakit_2', '... (Tahun)')}</li>
        <li>${fillVar(vars, 'riwayat_penyakit_lainnya', '... (Tambahkan jika ada)')}</li>
      </ol>
    </p>
    <p style="text-align: justify; ">
      Surat pernyataan ini dibuat untuk keperluan ${fillVar(vars, 'tujuan_surat', '... (Tujuan Surat)')} dan dapat dipertanggungjawabkan kebenarannya.
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
