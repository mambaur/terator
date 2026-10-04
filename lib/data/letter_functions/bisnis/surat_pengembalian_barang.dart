import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPengembalianBarangVariables = [
  LetterVariable(
      key: 'nama_perusahaan_penjual', label: 'Nama Perusahaan Penjual'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nama_barang', label: 'Nama Barang'),
  LetterVariable(key: 'nomor_invoice', label: 'Nomor Invoice'),
  LetterVariable(
      key: 'tanggal_pembelian',
      label: 'Tanggal Pembelian',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'jumlah_barang',
      label: 'Jumlah Barang',
      type: LetterVariableType.number),
  LetterVariable(
      key: 'alasan_pengembalian',
      label: 'Alasan Pengembalian',
      type: LetterVariableType.multiline,
      hint: 'misal: barang rusak / tidak sesuai spesifikasi / cacat produksi'),
  LetterVariable(
      key: 'penyelesaian_yang_diminta',
      label: 'Penyelesaian yang Diminta',
      type: LetterVariableType.choice,
      options: ['Penggantian Barang Baru', 'Pengembalian Dana']),
];

String suratPengembalianBarang(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_perusahaan_penjual', '... (Nama Perusahaan Penjual)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Pengembalian Barang</b></p>
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
						<td style="white-space: nowrap">Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}</td>
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
      Dengan ini mengajukan pengembalian barang dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Barang</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_barang', '... (Nama Barang)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Nomor Invoice</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nomor_invoice', '... (Nomor Invoice)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tanggal Pembelian</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tanggal_pembelian', '... (Tanggal Pembelian)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jumlah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jumlah_barang', '... (Jumlah Barang)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Alasan pengembalian barang ini adalah ${fillVar(vars, 'alasan_pengembalian', '... (Alasan Pengembalian, misal: barang rusak / tidak sesuai spesifikasi / cacat produksi)')}.
    </p>
    <p style="text-align: justify; ">
      Saya mengharapkan ${fillVar(vars, 'penyelesaian_yang_diminta', '... (Penggantian Barang Baru / Pengembalian Dana)')} atas pengembalian ini sesuai dengan ketentuan yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengembalian ini kami sampaikan. Atas perhatian dan kerjasamanya kami ucapkan terima kasih.
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
