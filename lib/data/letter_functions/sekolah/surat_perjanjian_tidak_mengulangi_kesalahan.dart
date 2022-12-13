import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPerjanjianTidakMengulangiKesalahan(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERJANJIAN</b>
      <br>
      <b>TIDAK MENGULANGI KESALAHAN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan dibawah ini:
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
						<td style="white-space: nowrap">Nomor Induk</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationNumber ?? ''}</td>
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
      Dengan ini saya berjanji untuk tidak mengulangi kesalahan yang telah saya perbuat yaitu <b>... (Kesalahan)</b>. Apabila dikemudian hari saya melakukan kesalahan yang sama, maka saya bersedia menerima sanksi dari pihak sekolah sesuai tata tertib yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Demikian surat Perjanjian ini saya buat dengan sebenarnya tanpa paksaan dari manapun.
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
              <span style="white-space: nowrap">Yang menyatakan,</span>
            </p>
            $image
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
