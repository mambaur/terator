import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganTanah(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN TANAH</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah <b>... (Nama Desa/Kelurahan)</b>, Kecamatan <b>... (Nama Kecamatan)</b>, Kabupaten/Kota <b>... (Nama Kabupaten/Kota)</b>, dengan ini menerangkan bahwa:
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
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Adalah benar memiliki / menguasai sebidang tanah yang terletak di wilayah kami dengan rincian:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Lokasi Tanah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alamat Lokasi Tanah)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Luas Tanah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Luas dalam m²)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Utara</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Batas Utara)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Selatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Batas Selatan)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Timur</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Batas Timur)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Barat</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Batas Barat)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Status Tanah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Hak Milik / Girik / Lainnya)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ini dibuat dengan sebenar-benarnya untuk dapat digunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pemilik Tanah</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Kepala Desa/Lurah,</span>
          </td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            ${img == null ? '<br><br><br><br><br>' : ''}
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            ${img ?? ''}
          </td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap"><b>... (Nama Kepala Desa/Lurah)</b></span>
            </p>
          </td>
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
