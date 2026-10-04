import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanSponsorshipVariables = [
  LetterVariable(
      key: 'nama_pimpinan_perusahaan', label: 'Nama Pimpinan Perusahaan'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(
      key: 'alamat_perusahaan',
      label: 'Alamat Perusahaan',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(
      key: 'nama_perusahaan_organisasi', label: 'Nama Perusahaan/Organisasi'),
  LetterVariable(key: 'nama_acara', label: 'Nama Acara'),
  LetterVariable(
      key: 'hari_tanggal_acara',
      label: 'Hari/Tanggal Acara',
      type: LetterVariableType.dateWithDay),
  LetterVariable(key: 'tempat_acara', label: 'Tempat Acara'),
  LetterVariable(
      key: 'jumlah_peserta',
      label: 'Jumlah Peserta',
      type: LetterVariableType.number),
  LetterVariable(
      key: 'bentuk_sponsorship',
      label: 'Bentuk Sponsorship',
      hint: 'misal: dana / produk / jasa'),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
  LetterVariable(
      key: 'bentuk_kompensasi',
      label: 'Bentuk Kompensasi',
      type: LetterVariableType.multiline,
      hint: 'misal: pemasangan logo / booth pameran / mention di acara'),
];

String suratPermohonanSponsorship(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_perusahaan', '... (Nama Pimpinan Perusahaan)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}
      <br>
      di ${fillVar(vars, 'alamat_perusahaan', '... (Alamat Perusahaan)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Sponsorship</b></p>
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jabatan', '... (Jabatan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Perusahaan/Organisasi</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan_organisasi', '... (Nama Perusahaan/Organisasi)')}</td>
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
						<td style="white-space: nowrap">Email</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.email ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan sponsorship untuk acara ${fillVar(vars, 'nama_acara', '... (Nama Acara)')} yang akan diselenggarakan pada:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Hari/Tanggal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'hari_tanggal_acara', '... (Hari/Tanggal Acara)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tempat_acara', '... (Tempat Acara)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jumlah Peserta</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jumlah_peserta', '... (Jumlah Peserta)')} orang</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Adapun bentuk sponsorship yang kami harapkan berupa ${fillVar(vars, 'bentuk_sponsorship', '... (Bentuk Sponsorship, misal: dana / produk / jasa)')} senilai ${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')}. Sebagai bentuk kerja sama, kami menawarkan ${fillVar(vars, 'bentuk_kompensasi', '... (Bentuk Kompensasi, misal: pemasangan logo / booth pameran / mention di acara)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini kami sampaikan. Atas perhatian dan kerjasamanya kami ucapkan terima kasih.
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
