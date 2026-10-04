import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganPindahVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(
      key: 'alamat_tujuan',
      label: 'Alamat Tujuan',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'kelurahan_desa', label: 'Kelurahan/Desa'),
  LetterVariable(key: 'kecamatan', label: 'Kecamatan'),
  LetterVariable(key: 'kabupaten', label: 'Kabupaten'),
  LetterVariable(
      key: 'alasan_pindah',
      label: 'Alasan Pindah',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_kepala_desa', label: 'Nama Kepala Desa'),
];

String suratKeteranganPindah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN PINDAH</b>
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
						<td style="width: 100%">${account?.name ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">No. KK</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Asal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Bermaksud pindah ke alamat:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Alamat Tujuan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_tujuan', '... (Alamat Tujuan)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Kelurahan/Desa</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'kelurahan_desa', '... (Kelurahan/Desa)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Kecamatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'kecamatan', '... (Kecamatan)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Kabupaten/Kota</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'kabupaten', '... (Kabupaten)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alasan Pindah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alasan_pindah', '... (Alasan)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan pindah ini dibuat untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Kepala Desa/Lurah,</span>
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
