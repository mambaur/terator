import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanKehilanganIjazah(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN KEHILANGAN IJAZAH</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.parentName ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">No. Telp</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">No. Seri Ijazah yang Hilang</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Menyatakan bahwa telah benar-benar kehilangan ijazah atas nama saya sendiri dan bersedia menanggung konsekuensi hukum apabila pernyataan ini tidak benar. 
    </p>
    <p style="text-align: justify; ">
      Demikian, atas perhatian dan kerjasamanya saya ucapkan terima kasih.
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Hormat saya,</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            ${img ?? '<br><br><br><br><br>'}
          </td>
          <td style="width: 100%">&nbsp;</td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">${account?.name ?? ''}</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
