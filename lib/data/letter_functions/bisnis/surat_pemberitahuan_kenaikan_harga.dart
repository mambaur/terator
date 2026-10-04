import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPemberitahuanKenaikanHargaVariables = [
  LetterVariable(key: 'nama_pelanggan_mitra', label: 'Nama Pelanggan/Mitra'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(
      key: 'tanggal_berlaku',
      label: 'Tanggal Berlaku',
      type: LetterVariableType.date),
  LetterVariable(key: 'nama_produk_jasa', label: 'Nama Produk/Jasa'),
  LetterVariable(
      key: 'harga_lama',
      label: 'Harga Lama',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'harga_baru',
      label: 'Harga Baru',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'alasan_kenaikan_harga',
      label: 'Alasan Kenaikan Harga',
      type: LetterVariableType.multiline,
      hint:
          'misal: kenaikan biaya bahan baku / inflasi / penyesuaian operasional'),
];

String suratPemberitahuanKenaikanHarga(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pelanggan_mitra', '... (Nama Pelanggan/Mitra)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Pemberitahuan Kenaikan Harga</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Melalui surat ini, kami dari ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')} ingin memberitahukan bahwa terhitung mulai tanggal ${fillVar(vars, 'tanggal_berlaku', '... (Tanggal Berlaku)')}, akan terjadi penyesuaian harga pada produk/jasa kami sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Produk/Jasa</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_produk_jasa', '... (Nama Produk/Jasa)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Harga Lama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'harga_lama', 'Rp ... (Harga Lama)', prefix: 'Rp ')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Harga Baru</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'harga_baru', 'Rp ... (Harga Baru)', prefix: 'Rp ')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Penyesuaian harga ini dilakukan sehubungan dengan ${fillVar(vars, 'alasan_kenaikan_harga', '... (Alasan Kenaikan Harga, misal: kenaikan biaya bahan baku / inflasi / penyesuaian operasional)')}.
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
