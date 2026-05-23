import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPemberitahuanKenaikanHarga(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Pelanggan/Mitra)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Pemberitahuan Kenaikan Harga</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Melalui surat ini, kami dari <b>... (Nama Perusahaan)</b> ingin memberitahukan bahwa terhitung mulai tanggal <b>... (Tanggal Berlaku)</b>, akan terjadi penyesuaian harga pada produk/jasa kami sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Produk/Jasa</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Produk/Jasa)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Harga Lama</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>Rp ... (Harga Lama)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Harga Baru</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>Rp ... (Harga Baru)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Penyesuaian harga ini dilakukan sehubungan dengan <b>... (Alasan Kenaikan Harga, misal: kenaikan biaya bahan baku / inflasi / penyesuaian operasional)</b>.
    </p>
    <p style="text-align: justify; ">
      Kami berharap hal ini tidak mengurangi kepercayaan Bapak/Ibu terhadap produk dan layanan kami. Kami tetap berkomitmen untuk menjaga kualitas terbaik.
    </p>
    <p style="text-align: justify; ">
      Demikian pemberitahuan ini kami sampaikan. Atas perhatian dan pengertiannya kami ucapkan terima kasih.
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
