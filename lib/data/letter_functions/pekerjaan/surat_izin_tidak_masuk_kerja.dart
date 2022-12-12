import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratIzinTidakMasukKerja(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Perihal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">Permohonan Izin Tidak Masuk Kerja</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p>
      Kepada Yth.
      <br>
      Kepala Bagian ...
      <br>
      ... (Nama Perusahaan Perusahaan)
      <br>
      ... (Alamat Perusahaan)
    </p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan dibawah ini:
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini saya memberitahukan bahwa pada hari $dateNow saya tidak bisa masuk untuk bekerja seperti biasanya dikarenakan <b>... (Alasan)</b>. Sehubungan dengan hal tersebut, saya bermaksud untuk memohon izin tidak masuk kerja pada tanggal tersebut.
    </p>
    <p style="text-align: justify; ">
      Demikian surat izin saya sampaikan dengan sebenar-benarnya. Atas perhatiannya saya  ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">Hormat saya,</span>
            </p>
            $image
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
