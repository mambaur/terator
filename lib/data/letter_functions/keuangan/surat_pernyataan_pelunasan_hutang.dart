import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanPelunasanHutangVariables = [
  LetterVariable(key: 'nama_debitur', label: 'Nama Debitur'),
  LetterVariable(
      key: 'alamat_debitur',
      label: 'Alamat Debitur',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
  LetterVariable(key: 'terbilang', label: 'Terbilang'),
];

String suratPernyataanPelunasanHutang(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN PELUNASAN HUTANG</b>
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
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut sebagai <b>PIHAK PERTAMA (Kreditur)</b>, dengan ini menyatakan bahwa:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_debitur', '... (Nama Debitur)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_debitur', '... (Alamat Debitur)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut sebagai <b>PIHAK KEDUA (Debitur)</b>, telah melunasi seluruh hutangnya sebesar ${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')} (${fillVar(vars, 'terbilang', '... Terbilang')}) pada tanggal <b>$dateNow2</b>.
    </p>
    <p style="text-align: justify; ">
      Dengan adanya pelunasan ini, maka PIHAK KEDUA dinyatakan tidak memiliki kewajiban hutang lagi kepada PIHAK PERTAMA.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan pelunasan ini dibuat dengan sebenar-benarnya untuk dapat dipergunakan sebagaimana mestinya.
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
              <span style="white-space: nowrap">${fillVar(vars, 'nama_debitur', '... (Nama Debitur)')}</span>
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
