import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPengantarIzinKeramaian(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PENGANTAR IZIN KERAMAIAN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Ketua RT/RW <b>... (Alamat RT/RW)</b>, dengan ini memberikan pengantar kepada:
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
      Untuk mengurus izin keramaian di Kepolisian setempat sehubungan dengan penyelenggaraan acara dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Acara</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Acara)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Hari/Tanggal</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Hari/Tanggal Acara)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Waktu</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Waktu Acara)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tempat</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tempat Acara)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Perkiraan Peserta</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Jumlah Peserta)</b> orang</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Penyelenggara bersedia menjaga ketertiban dan keamanan selama acara berlangsung serta mematuhi peraturan yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengantar ini dibuat untuk dapat digunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pemohon</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Ketua RT/RW,</span>
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
              <span style="white-space: nowrap"><b>... (Nama Ketua RT/RW)</b></span>
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
