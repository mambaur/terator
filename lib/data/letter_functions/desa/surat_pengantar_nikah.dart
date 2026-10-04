import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPengantarNikahVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_calon_pasangan', label: 'Nama Calon Pasangan'),
  LetterVariable(key: 'tempat_tgl_lahir', label: 'Tempat, tgl lahir'),
  LetterVariable(
      key: 'alamat_calon',
      label: 'Alamat Calon',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_kepala_desa', label: 'Nama Kepala Desa'),
];

String suratPengantarNikah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PENGANTAR NIKAH</b>
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
						<td style="white-space: nowrap">Agama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.religion ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Status</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.maritalStatus ?? ''}</td>
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
      Adalah benar warga kami yang bermaksud melangsungkan pernikahan dengan:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_calon_pasangan', '... (Nama Calon Pasangan)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat, tgl lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tempat_tgl_lahir', '... (TTL Calon)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_calon', '... (Alamat Calon)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengantar nikah ini dibuat untuk keperluan pendaftaran nikah di KUA/Catatan Sipil setempat.
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
