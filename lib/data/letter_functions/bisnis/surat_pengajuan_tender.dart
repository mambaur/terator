import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPengajuanTenderVariables = [
  LetterVariable(
      key: 'nama_panitia_pengadaan_pejabat',
      label: 'Nama Panitia Pengadaan/Pejabat'),
  LetterVariable(
      key: 'nama_instansi_perusahaan', label: 'Nama Instansi/Perusahaan'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nama_proyek_pengadaan', label: 'Nama Proyek/Pengadaan'),
  LetterVariable(key: 'nomor_tender', label: 'Nomor Tender'),
  LetterVariable(
      key: 'nilai_penawaran',
      label: 'Nilai Penawaran',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'jangka_waktu_pelaksanaan', label: 'Jangka Waktu Pelaksanaan'),
  LetterVariable(
      key: 'masa_berlaku_penawaran', label: 'Masa Berlaku Penawaran'),
];

String suratPengajuanTender(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_panitia_pengadaan_pejabat', '... (Nama Panitia Pengadaan/Pejabat)')}
      <br>
      ${fillVar(vars, 'nama_instansi_perusahaan', '... (Nama Instansi/Perusahaan)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Pengajuan Penawaran Tender</b></p>
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
          <tr>
						<td style="white-space: nowrap">Email</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.email ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan penawaran untuk mengikuti proses tender/pengadaan ${fillVar(vars, 'nama_proyek_pengadaan', '... (Nama Proyek/Pengadaan)')} dengan nomor referensi ${fillVar(vars, 'nomor_tender', '... (Nomor Tender)')}.
    </p>
    <p style="text-align: justify; ">
      Adapun rincian penawaran kami adalah sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nilai Penawaran</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nilai_penawaran', 'Rp ... (Nominal)', prefix: 'Rp ')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jangka Waktu Pelaksanaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jangka_waktu_pelaksanaan', '... (Durasi)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Masa Berlaku Penawaran</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'masa_berlaku_penawaran', '... (Masa Berlaku)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Bersama surat ini kami lampirkan dokumen administrasi, teknis, dan penawaran harga sebagaimana yang dipersyaratkan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengajuan tender ini kami sampaikan. Atas perhatian dan pertimbangan Bapak/Ibu, kami ucapkan terima kasih.
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
