import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPersetujuanOrangTua(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERSETUJUAN ORANG TUA / WALI</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan dibawah ini:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.parentName ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat / Tgl. Lahir Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Nomor Telepon Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Yang merupakan orang tua / wali dari:
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
						<td style="white-space: nowrap">Kelas</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationClass ?? ''}</td>
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
      Menerangkan bahwa saya memberikan izin kepada anak saya untuk mengikuti <b>... (Kegiatan)</b> dengan menerapkan protokol kesehatan, seperti menggunakan masker dan mengatur jarak, dan bersedia mengikuti jadwal kegiatan yang sudah diatur oleh pihak panitia atau sekolah.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sadar dan tanpa paksaan dari pihak manapun dan semoga bisa dimanfaatkan dengan sebagaimana mestinya.
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
              <span style="white-space: nowrap">Orang tua / Wali,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap">${account?.parentName ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
