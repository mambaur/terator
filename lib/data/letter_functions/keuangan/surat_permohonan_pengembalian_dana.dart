import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanPengembalianDanaVariables = [
  LetterVariable(key: 'nama_pihak_tujuan', label: 'Nama Pihak Tujuan'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
  LetterVariable(
      key: 'tanggal_pembayaran',
      label: 'Tanggal Pembayaran',
      type: LetterVariableType.date),
  LetterVariable(key: 'keperluan', label: 'Keperluan'),
  LetterVariable(
      key: 'alasan_pengembalian',
      label: 'Alasan Pengembalian',
      type: LetterVariableType.multiline),
];

String suratPermohonanPengembalianDana(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pihak_tujuan', '... (Nama Pihak Tujuan)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Pengembalian Dana</b></p>
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
      Dengan ini mengajukan permohonan pengembalian dana sebesar ${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')} yang telah saya bayarkan pada tanggal ${fillVar(vars, 'tanggal_pembayaran', '... (Tanggal Pembayaran)')} untuk keperluan ${fillVar(vars, 'keperluan', '... (Keperluan)')}.
    </p>
    <p style="text-align: justify; ">
      Adapun alasan pengembalian dana ini adalah ${fillVar(vars, 'alasan_pengembalian', '... (Alasan Pengembalian)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat. Atas perhatian dan kerjasamanya saya ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat saya,</span>
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
