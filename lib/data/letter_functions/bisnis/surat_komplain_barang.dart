import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKomplainBarang(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Perusahaan/Supplier)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Komplain Barang/Jasa</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Kami yang bertanda tangan di bawah ini selaku perwakilan dari <b>... (Nama Perusahaan)</b>, menyampaikan keluhan terkait barang/jasa yang telah kami terima dengan rincian:
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
						<td style="white-space: nowrap">Tanggal Terima</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Tanggal)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Nama Barang</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Barang)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Masalah</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Deskripsi Masalah)</b></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Kami memohon agar masalah ini dapat segera ditindaklanjuti dengan <b>... (penggantian/perbaikan/pengembalian dana)</b> selambat-lambatnya <b>... (Batas Waktu)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian surat ini kami sampaikan. Atas perhatian dan tindak lanjutnya kami ucapkan terima kasih.
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
