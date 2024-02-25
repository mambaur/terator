import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganTempatUsaha(
    LetterModel? letter, String? img, AccountModel? account) {
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
      Yang bertanda tangan dibawah ini Kepala Desa <b>... (Nama Desa)</b> Kecamatan <b>... (Nama Kecamatan)</b> Kabupaten <b>... (Nama Kabupaten)</b> menerangkan bahwa:
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
      Orang tersebut diatas adalah benar- benar mempunyai usaha <b>... (Usaha anda)</b> Yang terletak di Jln/Dsn <b>... (Nama Jalan)</b> Kelurahan/Desa <b>... (Nama Desa)</b> Kecamatan <b>... (Nama Kecamatan)</b> Kabupaten <b>... (Nama Kabupaten)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian Surat Keterangan ini kami buat dengan sebenarnya, dan dapat Dipergunakan sebagai <b>... (Kebutuhan)</b>.
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
              <span style="white-space: nowrap"><b>... (Nama Kepala Desa / Lurah)</b></span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
