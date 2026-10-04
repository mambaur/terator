import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPerjanjianJualBeliVariables = [
  LetterVariable(key: 'nama_pembeli', label: 'Nama Pembeli'),
  LetterVariable(
      key: 'alamat_pembeli',
      label: 'Alamat Pembeli',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'no_telepon_pembeli', label: 'No. Telepon Pembeli'),
  LetterVariable(key: 'nama_jenis_barang', label: 'Nama/Jenis Barang'),
  LetterVariable(
      key: 'spesifikasi_barang',
      label: 'Spesifikasi Barang',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'jumlah', label: 'Jumlah'),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
  LetterVariable(
      key: 'metode_pembayaran',
      label: 'Metode Pembayaran',
      type: LetterVariableType.choice,
      options: ['Tunai', 'Transfer', 'Cicilan']),
  LetterVariable(
      key: 'tanggal_penyerahan',
      label: 'Tanggal Penyerahan',
      type: LetterVariableType.date),
  LetterVariable(key: 'tempat_penyerahan', label: 'Tempat Penyerahan'),
];

String suratPerjanjianJualBeli(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERJANJIAN JUAL BELI</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Pada hari ini, $dateNow2, yang bertanda tangan di bawah ini:
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
      Selanjutnya disebut <b>PIHAK PENJUAL</b>, dan:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_pembeli', '... (Nama Pembeli)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_pembeli', '... (Alamat Pembeli)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'no_telepon_pembeli', '... (No. Telepon Pembeli)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Selanjutnya disebut <b>PIHAK PEMBELI</b>, sepakat mengadakan perjanjian jual beli dengan ketentuan sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 1 - Objek Jual Beli</b>
    </p>
    <p style="text-align: justify; ">
      Pihak Penjual menjual dan Pihak Pembeli membeli barang berupa ${fillVar(vars, 'nama_jenis_barang', '... (Nama/Jenis Barang)')} dengan spesifikasi ${fillVar(vars, 'spesifikasi_barang', '... (Spesifikasi Barang)')} sebanyak ${fillVar(vars, 'jumlah', '... (Jumlah)')} unit.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 2 - Harga dan Pembayaran</b>
    </p>
    <p style="text-align: justify; ">
      Harga yang disepakati adalah sebesar ${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')} dengan cara pembayaran ${fillVar(vars, 'metode_pembayaran', '... (Tunai / Transfer / Cicilan)')}.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 3 - Penyerahan Barang</b>
    </p>
    <p style="text-align: justify; ">
      Penyerahan barang dilakukan pada tanggal ${fillVar(vars, 'tanggal_penyerahan', '... (Tanggal Penyerahan)')} di ${fillVar(vars, 'tempat_penyerahan', '... (Tempat Penyerahan)')}.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 4 - Penyelesaian Perselisihan</b>
    </p>
    <p style="text-align: justify; ">
      Apabila terjadi perselisihan, kedua belah pihak sepakat untuk menyelesaikannya secara musyawarah mufakat.
    </p>
    <p style="text-align: justify; ">
      Demikian surat perjanjian ini dibuat dalam rangkap dua yang memiliki kekuatan hukum yang sama.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pihak Pembeli</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Pihak Penjual,</span>
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
              <span style="white-space: nowrap">${fillVar(vars, 'nama_pembeli', '... (Nama Pembeli)')}</span>
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
