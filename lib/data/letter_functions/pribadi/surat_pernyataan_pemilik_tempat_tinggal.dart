import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanPemilikTempatTinggal(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN PEMILIK TEMPAT TINGGAL</b>
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
						<td style="white-space: nowrap">No. KK</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat, Tgl Lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
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
      Menyatakan dengan sebenarnya bahwa saya tidak keberatan alamat rumah / rumah kos / rumah kontrakan milik saya digunakan oleh :
    </p>
    <p>
      <ol>
        <li>............................... NIK:</li>
        <li>............................... NIK:</li>
        <li>............................... NIK:</li>
        <li>............................... NIK:</li>
      </ol>
    </p>
    <p style="text-align: justify; ">
      <b>untuk pencantuman alamat dalam Dokumen Kependudukannya.</b>
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya. Data yang saya laporkan dan sampaikan semua adalah benar dan tidak ada kepalsuan data, serta menjadi tanggung jawab saya. Apabila yang saya sampaikan, laporkan dan nyatakan tidak benar / palsu, maka saya bersedia dikenai sanksi pidana, perdata dan/atau sesuai dengan peraturan perundang-undangan yang berlaku, serta dokumen yang diterbitkan dari pernyataan ini menjadi tidak berlaku dan tidak sah. 
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
