import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganBerkelakuanBaik(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN BERKELAKUAN BAIK</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Ketua RT/RW <b>... (Alamat RT/RW)</b>, menerangkan bahwa:
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
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat, tgl lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Agama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.religion ?? ''}</td>
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
      Adalah benar warga kami yang berkelakuan baik dan tidak pernah terlibat dalam tindak pidana maupun hal-hal yang melanggar norma dan kesusilaan di lingkungan masyarakat.
    </p>
    <p style="text-align: justify; ">
      Surat keterangan ini dibuat untuk keperluan <b>... (Tujuan Surat)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ini dibuat dengan sebenarnya untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Ketua RT/RW,</span>
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
              <span style="white-space: nowrap"><b>... (Nama Ketua RT/RW)</b></span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
