import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanVisumVariables = [
  LetterVariable(
      key: 'nama_dokter_direktur_rumah_sakit',
      label: 'Nama Dokter / Direktur Rumah Sakit'),
  LetterVariable(key: 'nama_rumah_sakit', label: 'Nama Rumah Sakit'),
  LetterVariable(key: 'nama_yang_divisum', label: 'Nama yang Divisum'),
  LetterVariable(
      key: 'jenis_kejadian',
      label: 'Jenis Kejadian',
      hint: 'misal: kecelakaan lalu lintas / tindak kekerasan'),
  LetterVariable(
      key: 'tanggal_kejadian',
      label: 'Tanggal Kejadian',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'tujuan',
      label: 'Tujuan',
      hint: 'misal: proses hukum / klaim asuransi'),
];

String suratPermohonanVisum(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_dokter_direktur_rumah_sakit', '... (Nama Dokter / Direktur Rumah Sakit)')}
      <br>
      ${fillVar(vars, 'nama_rumah_sakit', '... (Nama Rumah Sakit)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan Hormat,</p>
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
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
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
      Dengan ini mengajukan permohonan pembuatan Visum et Repertum atas diri saya / atas nama ${fillVar(vars, 'nama_yang_divisum', '... (Nama yang Divisum)')} sehubungan dengan kejadian ${fillVar(vars, 'jenis_kejadian', '... (Jenis Kejadian, misal: kecelakaan lalu lintas / tindak kekerasan)')} yang terjadi pada tanggal ${fillVar(vars, 'tanggal_kejadian', '... (Tanggal Kejadian)')}.
    </p>
    <p style="text-align: justify; ">
      Visum et Repertum ini diperlukan untuk keperluan ${fillVar(vars, 'tujuan', '... (Tujuan, misal: proses hukum / klaim asuransi)')}.
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
