import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganKelahiranVariables = [
  LetterVariable(
      key: 'hari_tanggal_lahir',
      label: 'Hari, Tanggal Lahir',
      type: LetterVariableType.dateWithDay),
  LetterVariable(key: 'jam_lahir', label: 'Jam Lahir'),
  LetterVariable(key: 'tempat_lahir', label: 'Tempat Lahir'),
  LetterVariable(key: 'nama_bayi', label: 'Nama Bayi'),
  LetterVariable(
      key: 'jenis_kelamin',
      label: 'Jenis Kelamin',
      type: LetterVariableType.choice,
      options: ['Laki-laki', 'Perempuan']),
  LetterVariable(key: 'anak_ke', label: 'Anak ke'),
  LetterVariable(key: 'nama_ibu', label: 'Nama Ibu'),
];

String suratKeteranganKelahiran(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN KELAHIRAN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini menerangkan bahwa pada:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Hari/Tanggal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'hari_tanggal_lahir', '... (Hari, Tanggal Lahir)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Pukul</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jam_lahir', '... (Jam Lahir)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tempat_lahir', '... (Tempat Lahir)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Telah lahir seorang anak:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_bayi', '... (Nama Bayi)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_kelamin', '... (Laki-laki/Perempuan)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Anak ke</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'anak_ke', '... (Urutan)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dari pasangan:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Ayah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.name ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Nama Ibu</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_ibu', '... (Nama Ibu)')}</td>
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
      Demikian surat keterangan kelahiran ini dibuat untuk dapat dipergunakan sebagaimana mestinya.
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
