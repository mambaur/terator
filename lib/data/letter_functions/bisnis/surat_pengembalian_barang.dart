import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPengembalianBarang(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Perusahaan Penjual)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Pengembalian Barang</b></p>
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
						<td style="white-space: nowrap">Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Perusahaan)</b></td>
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
      Dengan ini mengajukan pengembalian barang dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Barang</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Barang)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Nomor Invoice</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nomor Invoice)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tanggal Pembelian</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tanggal Pembelian)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jumlah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Jumlah Barang)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Alasan pengembalian barang ini adalah <b>... (Alasan Pengembalian, misal: barang rusak / tidak sesuai spesifikasi / cacat produksi)</b>.
    </p>
    <p style="text-align: justify; ">
      Saya mengharapkan <b>... (Penggantian Barang Baru / Pengembalian Dana)</b> atas pengembalian ini sesuai dengan ketentuan yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengembalian ini kami sampaikan. Atas perhatian dan kerjasamanya kami ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat kami,</span>
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
