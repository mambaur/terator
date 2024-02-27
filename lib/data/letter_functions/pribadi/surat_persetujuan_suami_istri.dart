import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPersetujuanSuamiIstri(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN PERSETUJUAN SUAMI/ISTRI</b>
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
						<td style="white-space: nowrap">No. KTP</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Pekerjaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
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
      Dengan ini menyatakan tidak keberatan/ memberikan persetujuan sepenuhnya kepada suami/istri saya:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">NIP</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Pangkat / Gol</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Unit Kerja</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Untuk mengikuti <b>... (Tujuan Persetujuan)<b/>.
    </p>
    <p style="text-align: justify; ">
      Demikian persetujuan ini diberikan untuk dipergunakan sebagaimana mestinya.
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Yang membuat pernyataan,</span>
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
