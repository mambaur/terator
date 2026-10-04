import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganKematianVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_almarhum_ah', label: 'Nama Almarhum/ah'),
  LetterVariable(key: 'nik', label: 'NIK'),
  LetterVariable(
      key: 'jenis_kelamin',
      label: 'Jenis Kelamin',
      type: LetterVariableType.choice,
      options: ['Laki-laki', 'Perempuan']),
  LetterVariable(
      key: 'alamat_terakhir',
      label: 'Alamat Terakhir',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'hari_tanggal',
      label: 'Hari, Tanggal',
      type: LetterVariableType.dateWithDay),
  LetterVariable(key: 'tempat', label: 'Tempat'),
  LetterVariable(key: 'penyebab', label: 'Penyebab'),
  LetterVariable(key: 'hubungan_keluarga', label: 'Hubungan Keluarga'),
  LetterVariable(key: 'nama_kepala_desa', label: 'Nama Kepala Desa'),
];

String suratKeteranganKematian(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN KEMATIAN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah ${fillVar(vars, 'nama_desa_kelurahan', '... (Nama Desa/Kelurahan)')}, menerangkan bahwa:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_almarhum_ah', '... (Nama Almarhum/ah)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nik', '... (NIK)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_kelamin', '... (Jenis Kelamin)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Terakhir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_terakhir', '... (Alamat)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Telah meninggal dunia pada:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Hari/Tanggal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'hari_tanggal', '... (Hari, Tanggal)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tempat', '... (Tempat)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Penyebab</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'penyebab', '... (Penyebab)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Surat keterangan ini dibuat berdasarkan laporan dari keluarga yang bersangkutan yaitu ${account?.name ?? ''} selaku ${fillVar(vars, 'hubungan_keluarga', '... (Hubungan Keluarga)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ini dibuat untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pelapor</span>
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
