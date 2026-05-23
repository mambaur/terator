import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPengajuanTender(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Panitia Pengadaan/Pejabat)</b>
      <br>
      <b>... (Nama Instansi/Perusahaan)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Pengajuan Penawaran Tender</b></p>
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Jabatan)</b></td>
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
          <tr>
						<td style="white-space: nowrap">Email</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.email ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan penawaran untuk mengikuti proses tender/pengadaan <b>... (Nama Proyek/Pengadaan)</b> dengan nomor referensi <b>... (Nomor Tender)</b>.
    </p>
    <p style="text-align: justify; ">
      Adapun rincian penawaran kami adalah sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nilai Penawaran</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>Rp ... (Nominal)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jangka Waktu Pelaksanaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Durasi)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Masa Berlaku Penawaran</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Masa Berlaku)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Bersama surat ini kami lampirkan dokumen administrasi, teknis, dan penawaran harga sebagaimana yang dipersyaratkan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengajuan tender ini kami sampaikan. Atas perhatian dan pertimbangan Bapak/Ibu, kami ucapkan terima kasih.
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
