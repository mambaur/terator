import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanBantuanBiayaPengobatanVariables = [
  LetterVariable(key: 'pihak_yang_dituju', label: 'Pihak yang Dituju'),
  LetterVariable(key: 'nama_pasien', label: 'Nama Pasien'),
  LetterVariable(key: 'nama_rumah_sakit', label: 'Nama Rumah Sakit'),
  LetterVariable(key: 'jenis_penyakit', label: 'Jenis Penyakit'),
  LetterVariable(
      key: 'nominal', label: 'Nominal', type: LetterVariableType.currency),
];

String suratPermohonanBantuanBiayaPengobatan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'pihak_yang_dituju', '... (Pihak yang Dituju)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Bantuan Biaya Pengobatan</b></p>
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
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan bantuan biaya pengobatan untuk ${fillVar(vars, 'nama_pasien', '... (Nama Pasien)')} yang sedang menjalani perawatan di ${fillVar(vars, 'nama_rumah_sakit', '... (Nama Rumah Sakit)')} karena menderita ${fillVar(vars, 'jenis_penyakit', '... (Jenis Penyakit)')}.
    </p>
    <p style="text-align: justify; ">
      Adapun total biaya yang dibutuhkan adalah sebesar ${fillVar(vars, 'nominal', 'Rp ... (Nominal)', prefix: 'Rp ')}. Mengingat kondisi ekonomi keluarga yang kurang mampu, kami sangat membutuhkan bantuan dari Bapak/Ibu.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat dengan sebenar-benarnya. Atas perhatian dan bantuannya saya ucapkan terima kasih.
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
