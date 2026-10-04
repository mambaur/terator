import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratIzinSakitVariables = [
  LetterVariable(
      key: 'nama_pimpinan_kepala_sekolah',
      label: 'Nama Pimpinan/Kepala Sekolah'),
  LetterVariable(key: 'jenis_penyakit', label: 'Jenis Penyakit'),
  LetterVariable(
      key: 'jumlah_hari',
      label: 'Jumlah Hari',
      type: LetterVariableType.number),
  LetterVariable(
      key: 'tanggal_mulai',
      label: 'Tanggal Mulai',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'tanggal_selesai',
      label: 'Tanggal Selesai',
      type: LetterVariableType.date),
];

String suratIzinSakit(LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_kepala_sekolah', '... (Nama Pimpinan/Kepala Sekolah)')}
      <br>
      di Tempat
    </p>
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
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyampaikan bahwa saya tidak dapat masuk kerja/sekolah karena sakit ${fillVar(vars, 'jenis_penyakit', '... (Jenis Penyakit)')} selama ${fillVar(vars, 'jumlah_hari', '... (Jumlah Hari)')} hari, terhitung mulai tanggal ${fillVar(vars, 'tanggal_mulai', '... (Tanggal Mulai)')} sampai dengan ${fillVar(vars, 'tanggal_selesai', '... (Tanggal Selesai)')}.
    </p>
    <p style="text-align: justify; ">
      Sebagai bukti, saya lampirkan surat keterangan dokter.
    </p>
    <p style="text-align: justify; ">
      Demikian surat izin sakit ini saya buat. Atas perhatiannya saya ucapkan terima kasih.
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
