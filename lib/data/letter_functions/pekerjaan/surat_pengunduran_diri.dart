import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPengunduranDiriVariables = [
  LetterVariable(key: 'divisi', label: 'Divisi'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(
      key: 'alamat_perusahaan',
      label: 'Alamat Perusahaan',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'pimpinan', label: 'Pimpinan'),
];

String suratPengunduranDiri(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p>
      Kepada Yth.
      <br>
      Kepala Bagian ${fillVar(vars, 'divisi', '... (Divisi)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}
      <br>
      ${fillVar(vars, 'alamat_perusahaan', '... (Alamat Perusahaan)')}
    </p>
    <p>
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Yang bertanda tangan dibawah ini:
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
						<td style="white-space: nowrap">Nomor Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
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
      Melalui surat pernyataan ini, saya berniat untuk mengajukan permohonan pengunduran diri saya dari jabatan ${fillVar(vars, 'jabatan', '... (Jabatan)')} di perusahaan ${fillVar(vars, 'nama_perusahaan', '... (Nama perusahaan)')} terhitung mulai tanggal $dateNow2.
    </p>
    <p style="text-align: justify; ">
      Sebelumnya, saya dengan rasa syukur yang sebesar-besarnya berterima kasih kepada ${fillVar(vars, 'pimpinan', '... (Pimpinan)')} karena sudah memberikan saya kesempatan untuk dapat bekerja, belajar, dan berkembang di perusahaan ini
    </p>
    <p style="text-align: justify; ">
      Selain itu, saya juga ingin berterima kasih pada rekan-rekan kerja saya di sini yang telah berjuang bersama dalam mencapai target perusahaan.
    </p>
    <p style="text-align: justify; ">
      Saya memohon maaf atas segala kesalahan dan kekurangan yang saya lakukan selama menjadi bagian dari ${fillVar(vars, 'divisi', '... (Divisi)')} Semoga perusahaan ini dapat terus berkembang dan semakin maju.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengunduran diri ini saya buat dengan kesadaran dan tanpa tekanan dari pihak manapun.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">Hormat saya,</span>
            </p>
            $image
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
