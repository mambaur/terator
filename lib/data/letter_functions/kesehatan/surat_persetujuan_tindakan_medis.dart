import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPersetujuanTindakanMedis(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERSETUJUAN TINDAKAN MEDIS</b>
      <br>
      <b>(INFORMED CONSENT)</b>
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
						<td style="white-space: nowrap">Umur</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Umur)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selaku pasien / wali dari pasien <b>... (Nama Pasien)</b>, dengan ini menyatakan <b>SETUJU</b> untuk dilakukan tindakan medis berupa <b>... (Jenis Tindakan Medis)</b> oleh dokter <b>... (Nama Dokter)</b> di <b>... (Nama Rumah Sakit)</b>.
    </p>
    <p style="text-align: justify; ">
      Saya telah menerima penjelasan mengenai tujuan, prosedur, risiko, serta alternatif dari tindakan medis tersebut dan memahaminya dengan baik.
    </p>
    <p style="text-align: justify; ">
      Demikian surat persetujuan ini saya buat dengan penuh kesadaran dan tanpa paksaan.
    </p>
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
