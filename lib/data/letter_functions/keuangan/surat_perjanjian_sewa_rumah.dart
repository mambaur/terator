import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPerjanjianSewaRumah(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERJANJIAN SEWA RUMAH</b>
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
      Selanjutnya disebut sebagai <b>PIHAK PERTAMA (Pemilik)</b>.
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Penyewa)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Alamat Penyewa)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (No. Telepon)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut sebagai <b>PIHAK KEDUA (Penyewa)</b>.
    </p>
    <p style="text-align: justify; ">
      Kedua belah pihak sepakat mengadakan perjanjian sewa rumah dengan ketentuan:
    </p>
    <p>
      <ol>
        <li>Objek sewa berupa rumah yang terletak di <b>... (Alamat Rumah)</b></li>
        <li>Jangka waktu sewa selama <b>... (Durasi)</b> terhitung sejak <b>... (Tanggal Mulai)</b></li>
        <li>Harga sewa sebesar <b>Rp ... (Nominal)</b> per <b>... (Bulan/Tahun)</b></li>
        <li>Pembayaran dilakukan di muka sebelum masa sewa dimulai</li>
        <li>Penyewa wajib menjaga dan merawat rumah dengan baik</li>
      </ol>
    </p>
    <p style="text-align: justify; ">
      Demikian surat perjanjian sewa rumah ini dibuat dan ditandatangani oleh kedua belah pihak dalam keadaan sadar tanpa paksaan.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pihak Kedua</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Pihak Pertama,</span>
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
              <span style="white-space: nowrap"><b>... (Nama Penyewa)</b></span>
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
