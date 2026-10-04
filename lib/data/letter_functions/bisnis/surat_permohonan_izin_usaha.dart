import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanIzinUsahaVariables = [
  LetterVariable(key: 'nama_kabupaten_kota', label: 'Nama Kabupaten/Kota'),
  LetterVariable(key: 'nama_usaha', label: 'Nama Usaha'),
  LetterVariable(key: 'jenis_usaha', label: 'Jenis Usaha'),
  LetterVariable(
      key: 'alamat_usaha',
      label: 'Alamat Usaha',
      type: LetterVariableType.multiline),
];

String suratPermohonanIzinUsaha(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      Kepala Dinas Perizinan
      <br>
      ${fillVar(vars, 'nama_kabupaten_kota', '... (Nama Kabupaten/Kota)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Izin Usaha</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini:
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
      Dengan ini mengajukan permohonan izin usaha untuk:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_usaha', '... (Nama Usaha)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_usaha', '... (Jenis)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Lokasi Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_usaha', '... (Alamat Usaha)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, bersama ini saya lampirkan berkas persyaratan yang diperlukan.
    </p>
    <p style="text-align: justify; ">
      Demikian permohonan ini saya buat. Atas perhatiannya saya ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat saya,</span>
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
