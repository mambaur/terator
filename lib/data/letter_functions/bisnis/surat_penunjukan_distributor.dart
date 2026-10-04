import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPenunjukanDistributorVariables = [
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(
      key: 'nama_perwakilan_distributor', label: 'Nama Perwakilan Distributor'),
  LetterVariable(
      key: 'nama_perusahaan_distributor', label: 'Nama Perusahaan Distributor'),
  LetterVariable(
      key: 'alamat_distributor',
      label: 'Alamat Distributor',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_produk', label: 'Nama Produk'),
  LetterVariable(key: 'wilayah_distribusi', label: 'Wilayah Distribusi'),
  LetterVariable(key: 'jangka_waktu', label: 'Jangka Waktu'),
  LetterVariable(key: 'nama_distributor', label: 'Nama Distributor'),
];

String suratPenunjukanDistributor(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PENUNJUKAN DISTRIBUTOR</b>
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
						<td style="width: 100%">${fillVar(vars, 'jabatan', '... (Jabatan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}</td>
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
      Selanjutnya disebut <b>PIHAK PERTAMA</b>, dengan ini menunjuk:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perwakilan_distributor', '... (Nama Perwakilan Distributor)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan_distributor', '... (Nama Perusahaan Distributor)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_distributor', '... (Alamat Distributor)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut <b>PIHAK KEDUA</b>, sebagai distributor resmi untuk produk ${fillVar(vars, 'nama_produk', '... (Nama Produk)')} di wilayah ${fillVar(vars, 'wilayah_distribusi', '... (Wilayah Distribusi)')} dengan ketentuan sebagai berikut:
    </p>
    <ul>
      <li>Jangka waktu penunjukan berlaku selama ${fillVar(vars, 'jangka_waktu', '... (Jangka Waktu)')} terhitung sejak tanggal surat ini ditandatangani.</li>
      <li>Pihak Kedua wajib menjaga kualitas dan reputasi produk Pihak Pertama.</li>
      <li>Harga jual mengikuti ketentuan yang ditetapkan oleh Pihak Pertama.</li>
      <li>Pihak Kedua tidak diperkenankan mendistribusikan produk sejenis dari perusahaan lain tanpa persetujuan tertulis dari Pihak Pertama.</li>
    </ul>
    <p style="text-align: justify; ">
      Demikian surat penunjukan ini dibuat untuk dapat digunakan sebagaimana mestinya.
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
              <span style="white-space: nowrap">${fillVar(vars, 'nama_distributor', '... (Nama Distributor)')}</span>
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
