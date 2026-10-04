import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanKreditUsahaVariables = [
  LetterVariable(
      key: 'nama_pimpinan_bank_lembaga_keuangan',
      label: 'Nama Pimpinan Bank/Lembaga Keuangan'),
  LetterVariable(
      key: 'nama_bank_lembaga_keuangan', label: 'Nama Bank/Lembaga Keuangan'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_usaha', label: 'Nama Usaha'),
  LetterVariable(key: 'jenis_usaha', label: 'Jenis Usaha'),
  LetterVariable(
      key: 'alamat_usaha',
      label: 'Alamat Usaha',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'jumlah_pinjaman',
      label: 'Jumlah Pinjaman',
      type: LetterVariableType.currency),
  LetterVariable(key: 'jangka_waktu', label: 'Jangka Waktu'),
  LetterVariable(
      key: 'tujuan_penggunaan_dana', label: 'Tujuan Penggunaan Dana'),
  LetterVariable(key: 'jenis_jaminan', label: 'Jenis Jaminan'),
];

String suratPermohonanKreditUsaha(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_bank_lembaga_keuangan', '... (Nama Pimpinan Bank/Lembaga Keuangan)')}
      <br>
      ${fillVar(vars, 'nama_bank_lembaga_keuangan', '... (Nama Bank/Lembaga Keuangan)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Kredit Usaha</b></p>
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
						<td style="white-space: nowrap">Tempat / Tgl. Lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
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
          <tr>
						<td style="white-space: nowrap">Nama Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_usaha', '... (Nama Usaha)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jenis Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_usaha', '... (Jenis Usaha)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Alamat Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_usaha', '... (Alamat Usaha)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan kredit usaha dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Jumlah Pinjaman</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jumlah_pinjaman', 'Rp ... (Nominal)', prefix: 'Rp ')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jangka Waktu</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jangka_waktu', '... (Jangka Waktu)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tujuan Penggunaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tujuan_penggunaan_dana', '... (Tujuan Penggunaan Dana)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jaminan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_jaminan', '... (Jenis Jaminan)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya lampirkan dokumen pendukung berupa fotokopi KTP, SIUP/NIB, laporan keuangan usaha, dan dokumen jaminan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat. Atas perhatian dan pertimbangan Bapak/Ibu, saya ucapkan terima kasih.
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
