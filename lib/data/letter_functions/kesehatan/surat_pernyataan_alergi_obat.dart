import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanAlergiObatVariables = [
  LetterVariable(key: 'nama_obat_1', label: 'Nama Obat 1'),
  LetterVariable(key: 'nama_obat_2', label: 'Nama Obat 2'),
  LetterVariable(key: 'nama_obat_3', label: 'Nama Obat 3'),
  LetterVariable(
      key: 'jenis_reaksi_alergi',
      label: 'Jenis Reaksi Alergi',
      hint: 'misal: gatal-gatal, sesak napas, bengkak'),
];

String suratPernyataanAlergiObat(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN ALERGI OBAT</b>
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
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyatakan bahwa saya memiliki riwayat alergi terhadap obat-obatan berikut:
    </p>
    <ul>
      <li>${fillVar(vars, 'nama_obat_1', '... (Nama Obat 1)')}</li>
      <li>${fillVar(vars, 'nama_obat_2', '... (Nama Obat 2)')}</li>
      <li>${fillVar(vars, 'nama_obat_3', '... (Nama Obat 3)')}</li>
    </ul>
    <p style="text-align: justify; ">
      Reaksi alergi yang pernah saya alami antara lain ${fillVar(vars, 'jenis_reaksi_alergi', '... (Jenis Reaksi Alergi, misal: gatal-gatal, sesak napas, bengkak)')}.
    </p>
    <p style="text-align: justify; ">
      Surat pernyataan ini saya buat agar menjadi perhatian bagi tenaga medis dalam memberikan pengobatan kepada saya.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya dan penuh tanggung jawab.
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
