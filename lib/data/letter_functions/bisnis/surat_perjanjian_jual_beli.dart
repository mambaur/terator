import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPerjanjianJualBeli(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERJANJIAN JUAL BELI</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Pada hari ini, $dateNow2, yang bertanda tangan di bawah ini:
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
      Selanjutnya disebut <b>PIHAK PENJUAL</b>, dan:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Pembeli)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alamat Pembeli)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (No. Telepon Pembeli)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut <b>PIHAK PEMBELI</b>, sepakat mengadakan perjanjian jual beli dengan ketentuan sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 1 - Objek Jual Beli</b>
    </p>
    <p style="text-align: justify; ">
      Pihak Penjual menjual dan Pihak Pembeli membeli barang berupa <b>... (Nama/Jenis Barang)</b> dengan spesifikasi <b>... (Spesifikasi Barang)</b> sebanyak <b>... (Jumlah)</b> unit.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 2 - Harga dan Pembayaran</b>
    </p>
    <p style="text-align: justify; ">
      Harga yang disepakati adalah sebesar <b>Rp ... (Nominal)</b> dengan cara pembayaran <b>... (Tunai / Transfer / Cicilan)</b>.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 3 - Penyerahan Barang</b>
    </p>
    <p style="text-align: justify; ">
      Penyerahan barang dilakukan pada tanggal <b>... (Tanggal Penyerahan)</b> di <b>... (Tempat Penyerahan)</b>.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 4 - Penyelesaian Perselisihan</b>
    </p>
    <p style="text-align: justify; ">
      Apabila terjadi perselisihan, kedua belah pihak sepakat untuk menyelesaikannya secara musyawarah mufakat.
    </p>
    <p style="text-align: justify; ">
      Demikian surat perjanjian ini dibuat dalam rangkap dua yang memiliki kekuatan hukum yang sama.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pihak Pembeli</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Pihak Penjual,</span>
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
              <span style="white-space: nowrap"><b>... (Nama Pembeli)</b></span>
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
