import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratIzinTidakMasukKerjaVariables = [
  LetterVariable(key: 'divisi', label: 'Divisi'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(
      key: 'alamat_perusahaan',
      label: 'Alamat Perusahaan',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'alasan', label: 'Alasan', type: LetterVariableType.multiline),
];

String suratIzinTidakMasukKerja(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Perihal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">Permohonan Izin Tidak Masuk Kerja</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p>
      Kepada Yth.
      <br>
      Kepala Bagian ${fillVar(vars, 'divisi', '... (Divisi)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}
      <br>
      ${fillVar(vars, 'alamat_perusahaan', '... (Alamat Perusahaan)')}
    </p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan dibawah ini:
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini saya memberitahukan bahwa pada hari $dateNow saya tidak bisa masuk untuk bekerja seperti biasanya dikarenakan ${fillVar(vars, 'alasan', '... (Alasan)')}. Sehubungan dengan hal tersebut, saya bermaksud untuk memohon izin tidak masuk kerja pada tanggal tersebut.
    </p>
    <p style="text-align: justify; ">
      Demikian surat izin saya sampaikan dengan sebenar-benarnya. Atas perhatiannya saya  ucapkan terima kasih.
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
