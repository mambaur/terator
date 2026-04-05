import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPeringatanPembayaran(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Penerima)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Peringatan Pembayaran</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Melalui surat ini, kami ingin mengingatkan bahwa terdapat tagihan yang belum diselesaikan dengan rincian:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">No. Invoice</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (No. Invoice)</b></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tanggal Invoice</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tanggal)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jumlah Tagihan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>Rp ... (Nominal)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jatuh Tempo</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tanggal Jatuh Tempo)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Kami mohon agar pembayaran dapat segera diselesaikan selambat-lambatnya <b>... (Batas Waktu)</b>. Apabila telah melakukan pembayaran, mohon abaikan surat ini.
    </p>
    <p style="text-align: justify; ">
      Demikian surat peringatan ini kami sampaikan. Atas perhatiannya kami ucapkan terima kasih.
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
