import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanKreditUsaha(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Pimpinan Bank/Lembaga Keuangan)</b>
      <br>
      <b>... (Nama Bank/Lembaga Keuangan)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Kredit Usaha</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini:
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
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Nama Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Usaha)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jenis Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Jenis Usaha)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alamat Usaha)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan kredit usaha dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Jumlah Pinjaman</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>Rp ... (Nominal)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jangka Waktu</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Jangka Waktu)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tujuan Penggunaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tujuan Penggunaan Dana)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jaminan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Jenis Jaminan)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya lampirkan dokumen pendukung berupa fotokopi KTP, SIUP/NIB, laporan keuangan usaha, dan dokumen jaminan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat. Atas perhatian dan pertimbangan Bapak/Ibu, saya ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat saya,</span>
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
