import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganAhliWaris(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN AHLI WARIS</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah <b>... (Nama Desa/Kelurahan)</b>, menerangkan bahwa:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Almarhum/ah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Almarhum/ah)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (NIK)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Terakhir</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alamat)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tanggal Meninggal</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tanggal)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Berdasarkan data yang ada, maka ahli waris yang sah dari almarhum/ah tersebut adalah:
    </p>
    <p>
      <ol>
        <li><b>... (Nama Ahli Waris 1)</b> — <b>... (Hubungan)</b></li>
        <li><b>... (Nama Ahli Waris 2)</b> — <b>... (Hubungan)</b></li>
        <li><b>... (Tambahkan jika ada)</b></li>
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
              <span style="white-space: nowrap"><b>... (Nama Kepala Desa)</b></span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
