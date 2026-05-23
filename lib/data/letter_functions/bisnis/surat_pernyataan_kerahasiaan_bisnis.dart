import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanKerahasiaanBisnis(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN KERAHASIAAN BISNIS</b>
      <br>
      <b>(NON-DISCLOSURE AGREEMENT)</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini:
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
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyatakan bahwa saya bersedia menjaga kerahasiaan seluruh informasi bisnis yang bersifat rahasia milik <b>... (Nama Perusahaan/Pihak Pemilik Informasi)</b>, yang meliputi namun tidak terbatas pada:
    </p>
    <ul>
      <li>Data keuangan dan strategi bisnis</li>
      <li>Informasi pelanggan dan pemasok</li>
      <li>Rahasia dagang, formula, dan proses produksi</li>
      <li>Rencana pengembangan produk dan pemasaran</li>
      <li>Informasi teknologi dan sistem informasi</li>
    </ul>
    <p style="text-align: justify; ">
      Kewajiban kerahasiaan ini berlaku selama <b>... (Jangka Waktu)</b> terhitung sejak tanggal surat ini ditandatangani.
    </p>
    <p style="text-align: justify; ">
      Apabila saya terbukti melanggar ketentuan kerahasiaan ini, saya bersedia menerima sanksi sesuai dengan ketentuan hukum yang berlaku dan bersedia mengganti kerugian yang ditimbulkan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan penuh kesadaran dan tanpa paksaan dari pihak manapun.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Yang menyatakan,</span>
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
