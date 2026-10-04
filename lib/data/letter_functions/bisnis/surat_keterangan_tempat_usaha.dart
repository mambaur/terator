import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganTempatUsahaVariables = [
  LetterVariable(key: 'nama_desa', label: 'Nama Desa'),
  LetterVariable(key: 'nama_kecamatan', label: 'Nama Kecamatan'),
  LetterVariable(key: 'nama_kabupaten', label: 'Nama Kabupaten'),
  LetterVariable(key: 'jenis_usaha', label: 'Jenis Usaha'),
  LetterVariable(key: 'nama_jalan', label: 'Nama Jalan'),
  LetterVariable(key: 'kebutuhan', label: 'Kebutuhan'),
  LetterVariable(
      key: 'nama_kepala_desa_lurah', label: 'Nama Kepala Desa / Lurah'),
];

String suratKeteranganTempatUsaha(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN TEMPAT USAHA</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan dibawah ini Kepala Desa ${fillVar(vars, 'nama_desa', '... (Nama Desa)')} Kecamatan ${fillVar(vars, 'nama_kecamatan', '... (Nama Kecamatan)')} Kabupaten ${fillVar(vars, 'nama_kabupaten', '... (Nama Kabupaten)')} menerangkan bahwa:
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
						<td style="white-space: nowrap">Pekerjaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Orang tersebut diatas adalah benar- benar mempunyai usaha ${fillVar(vars, 'jenis_usaha', '... (Usaha anda)')} Yang terletak di Jln/Dsn ${fillVar(vars, 'nama_jalan', '... (Nama Jalan)')} Kelurahan/Desa ${fillVar(vars, 'nama_desa', '... (Nama Desa)')} Kecamatan ${fillVar(vars, 'nama_kecamatan', '... (Nama Kecamatan)')} Kabupaten ${fillVar(vars, 'nama_kabupaten', '... (Nama Kabupaten)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian Surat Keterangan ini kami buat dengan sebenarnya, dan dapat Dipergunakan sebagai ${fillVar(vars, 'kebutuhan', '... (Kebutuhan)')}.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
              <br>
              <span style="white-space: nowrap">Kepala Desa / Lurah,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap">${fillVar(vars, 'nama_kepala_desa_lurah', '... (Nama Kepala Desa / Lurah)')}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
