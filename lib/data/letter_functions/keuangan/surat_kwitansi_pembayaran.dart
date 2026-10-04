import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKwitansiPembayaranVariables = [
  LetterVariable(key: 'nomor_kwitansi', label: 'Nomor Kwitansi'),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
  LetterVariable(key: 'terbilang', label: 'Terbilang'),
  LetterVariable(key: 'untuk_pembayaran', label: 'Untuk pembayaran'),
];

String suratKwitansiPembayaran(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>KWITANSI PEMBAYARAN</b>
    </p>
    <p><br></p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nomor</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nomor_kwitansi', '... (Nomor Kwitansi)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Telah terima dari</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.name ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Sejumlah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Terbilang</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'terbilang', '... (Terbilang)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Untuk pembayaran</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'untuk_pembayaran', '... (Keperluan)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Penerima,</span>
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
