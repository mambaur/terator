import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanCutiSakitBerkepanjanganVariables = [
  LetterVariable(key: 'nama_pimpinan', label: 'Nama Pimpinan'),
  LetterVariable(
      key: 'nama_perusahaan_instansi', label: 'Nama Perusahaan/Instansi'),
  LetterVariable(key: 'jenis_penyakit', label: 'Jenis Penyakit'),
  LetterVariable(
      key: 'tanggal_mulai_cuti',
      label: 'Tanggal Mulai Cuti',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'tanggal_selesai_cuti',
      label: 'Tanggal Selesai Cuti',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'jumlah_hari',
      label: 'Jumlah Hari',
      type: LetterVariableType.number),
];

String suratPermohonanCutiSakitBerkepanjangan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan', '... (Nama Pimpinan)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan_instansi', '... (Nama Perusahaan/Instansi)')}
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
      Dengan ini mengajukan permohonan cuti sakit berkepanjangan dikarenakan kondisi kesehatan saya yang memerlukan perawatan dan pemulihan dalam jangka waktu yang lebih lama.
    </p>
    <p style="text-align: justify; ">
      Adapun rincian permohonan cuti sakit adalah sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Jenis Penyakit</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_penyakit', '... (Jenis Penyakit)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tanggal Mulai Cuti</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tanggal_mulai_cuti', '... (Tanggal Mulai)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Tanggal Selesai Cuti</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tanggal_selesai_cuti', '... (Tanggal Selesai)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Total Hari</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jumlah_hari', '... (Jumlah Hari)')} hari</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bukti, saya lampirkan surat keterangan dokter yang merawat saya. Selama masa cuti, saya dapat dihubungi melalui nomor telepon ${account?.telephone ?? ''}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat. Atas perhatian dan kebijaksanaan Bapak/Ibu, saya ucapkan terima kasih.
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
