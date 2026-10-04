import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanGolonganDarahVariables = [
  LetterVariable(
      key: 'golongan_darah',
      label: 'Golongan Darah',
      type: LetterVariableType.choice,
      options: ['A', 'B', 'AB', 'O']),
  LetterVariable(
      key: 'hasil_pemeriksaan',
      label: 'Hasil Pemeriksaan',
      type: LetterVariableType.choice,
      options: ['Positif', 'Negatif']),
  LetterVariable(
      key: 'nama_laboratorium_rumah_sakit',
      label: 'Nama Laboratorium / Rumah Sakit'),
  LetterVariable(
      key: 'tanggal_pemeriksaan',
      label: 'Tanggal Pemeriksaan',
      type: LetterVariableType.date),
];

String suratPernyataanGolonganDarah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN GOLONGAN DARAH</b>
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
						<td style="white-space: nowrap">Tempat / Tgl. Lahir</td>
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
      Dengan ini menyatakan bahwa golongan darah saya berdasarkan hasil pemeriksaan adalah sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Golongan Darah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'golongan_darah', '... (A / B / AB / O)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Rhesus</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'hasil_pemeriksaan', '... (Positif / Negatif)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Pemeriksaan golongan darah dilakukan di ${fillVar(vars, 'nama_laboratorium_rumah_sakit', '... (Nama Laboratorium / Rumah Sakit)')} pada tanggal ${fillVar(vars, 'tanggal_pemeriksaan', '... (Tanggal Pemeriksaan)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya untuk dapat digunakan sebagaimana mestinya.
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
