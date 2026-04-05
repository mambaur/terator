import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanPinjaman(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      Pimpinan <b>... (Nama Lembaga Keuangan)</b>
      <br>
      di <b>... (Alamat Lembaga)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Pinjaman</b></p>
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
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Pekerjaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Penghasilan/bulan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>Rp ... (Nominal)</b></td>
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
      Dengan ini mengajukan permohonan pinjaman sebesar <b>Rp ... (Jumlah Pinjaman)</b> dengan jangka waktu pelunasan selama <b>... (Jangka Waktu)</b> untuk keperluan <b>... (Tujuan Pinjaman)</b>.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, bersama ini saya lampirkan:
    </p>
    <p>
      <ul>
        <li>Fotokopi KTP</li>
        <li>Fotokopi Kartu Keluarga</li>
        <li>Slip Gaji / Surat Keterangan Penghasilan</li>
        <li>Dokumen pendukung lainnya</li>
      </ul>
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat dengan sebenar-benarnya. Atas perhatian dan kerjasamanya saya ucapkan terima kasih.
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
