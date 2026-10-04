import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganAhliWarisVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_almarhum_ah', label: 'Nama Almarhum/ah'),
  LetterVariable(key: 'nik', label: 'NIK'),
  LetterVariable(
      key: 'alamat_terakhir',
      label: 'Alamat Terakhir',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'tanggal_meninggal',
      label: 'Tanggal Meninggal',
      type: LetterVariableType.date),
  LetterVariable(key: 'nama_ahli_waris_1', label: 'Nama Ahli Waris 1'),
  LetterVariable(key: 'hubungan_ahli_waris_1', label: 'Hubungan Ahli Waris 1'),
  LetterVariable(key: 'nama_ahli_waris_2', label: 'Nama Ahli Waris 2'),
  LetterVariable(key: 'hubungan_ahli_waris_2', label: 'Hubungan Ahli Waris 2'),
  LetterVariable(key: 'ahli_waris_lainnya', label: 'Ahli Waris Lainnya'),
  LetterVariable(key: 'nama_kepala_desa', label: 'Nama Kepala Desa'),
];

String suratKeteranganAhliWaris(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN AHLI WARIS</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah ${fillVar(vars, 'nama_desa_kelurahan', '... (Nama Desa/Kelurahan)')}, menerangkan bahwa:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Almarhum/ah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_almarhum_ah', '... (Nama Almarhum/ah)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nik', '... (NIK)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Terakhir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_terakhir', '... (Alamat)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tanggal Meninggal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tanggal_meninggal', '... (Tanggal)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Berdasarkan data yang ada, maka ahli waris yang sah dari almarhum/ah tersebut adalah:
    </p>
    <p>
      <ol>
        <li>${fillVar(vars, 'nama_ahli_waris_1', '... (Nama Ahli Waris 1)')} — ${fillVar(vars, 'hubungan_ahli_waris_1', '... (Hubungan)')}</li>
        <li>${fillVar(vars, 'nama_ahli_waris_2', '... (Nama Ahli Waris 2)')} — ${fillVar(vars, 'hubungan_ahli_waris_2', '... (Hubungan)')}</li>
        <li>${fillVar(vars, 'ahli_waris_lainnya', '... (Tambahkan jika ada)')}</li>
      </ol>
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ahli waris ini dibuat untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pemohon</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Kepala Desa/Lurah,</span>
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
              <span style="white-space: nowrap">${account?.name ?? ''}</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">${fillVar(vars, 'nama_kepala_desa', '... (Nama Kepala Desa)')}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
