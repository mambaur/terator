import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganPindah(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN PINDAH</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah <b>... (Nama Desa/Kelurahan)</b>, menerangkan bahwa:
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
						<td style="white-space: nowrap">No. KK</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Asal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Bermaksud pindah ke alamat:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Alamat Tujuan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alamat Tujuan)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Kelurahan/Desa</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Kelurahan/Desa)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Kecamatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Kecamatan)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Kabupaten/Kota</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Kabupaten)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alasan Pindah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alasan)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan pindah ini dibuat untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Kepala Desa/Lurah,</span>
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
