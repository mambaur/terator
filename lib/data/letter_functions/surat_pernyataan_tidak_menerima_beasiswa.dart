import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanTidakMenerimaBeasiswa(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN</b>
      <br>
      <b>TIDAK SEDANG MENERIMA BEASISWA</b>
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
						<td style="white-space: nowrap">Tempat / Tgl. Lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">NIM</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationNumber ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Fakultas</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationFaculty ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Program Studi</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationStudyProgram ?? ''}</td>
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
      Dengan ini menyatakan bahwa saya tidak sedang menerima beasiswa dari Sumber/Lembaga/Instansi/Yayasan manapun.
    </p>
    <p style="text-align: justify; ">
      Surat pernyataan ini saya buat dengan sebenar-benarnya dengan penuh kesabaran, tanpa paksaan dan tekanan dari pihak manapun. Saya bersedia menerima sanksi sesuai hukum yang berlaku apabila saya terbukti sedang menerima beasiswa dari sumber lain.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat untuk persyaratan permohonan Beasiswa ....(nama beasiswa).
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
              <span style="white-space: nowrap">Yang Menyatakan,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap">${account?.name ?? ''}</span>
              <br>
              <span style="white-space: nowrap">${account?.educationNumber ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
