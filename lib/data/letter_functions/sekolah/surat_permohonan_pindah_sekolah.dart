import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanPindahSekolah(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: justify; ">
      Perihal: Permohonan Pindah Sekolah
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      Kepala ${account?.educationInstitution != null && account?.educationInstitution != '' ? account?.educationInstitution : '<b>... (Nama Sekolah)</b>'}
      <br>
      Di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Sehubungan dengan surat ini, saya selaku wali murid/orang tua dari:
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
						<td style="white-space: nowrap">Sekolah Asal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationInstitution ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Kelas</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationClass ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Mengajukan permohonan pindah dari ${account?.educationInstitution != null && account?.educationInstitution != '' ? account?.educationInstitution : '<b>... (Asal Sekolah)</b>'} ke <b>SMA Budi Mulia Jakarta</b>. Hal ini sehubungan dengan <b>pindah tugas kedua orang tua ke Jakarta</b>.
    </p>
    <p style="text-align: justify; ">
      Kami berharap pihak sekolah mempertimbangkan permohonan di atas. Terima kasih atas perhatiannya.
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
              <span style="white-space: nowrap">Hormat saya,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap">${account?.parentName ?? '(Nama Orang Tua)'}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
