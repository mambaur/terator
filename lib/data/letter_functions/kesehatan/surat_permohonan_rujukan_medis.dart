import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanRujukanMedisVariables = [
  LetterVariable(
      key: 'nama_rumah_sakit_tujuan', label: 'Nama Rumah Sakit Tujuan'),
  LetterVariable(
      key: 'alamat_rs_tujuan',
      label: 'Alamat RS Tujuan',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'jenis_pelayanan', label: 'Jenis Pelayanan'),
  LetterVariable(
      key: 'alasan_diagnosa',
      label: 'Alasan/Diagnosa',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'nama_rs_puskesmas_asal', label: 'Nama RS/Puskesmas Asal'),
];

String suratPermohonanRujukanMedis(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      Direktur ${fillVar(vars, 'nama_rumah_sakit_tujuan', '... (Nama Rumah Sakit Tujuan)')}
      <br>
      di ${fillVar(vars, 'alamat_rs_tujuan', '... (Alamat RS Tujuan)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Rujukan Medis</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini:
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
      Dengan ini mengajukan permohonan rujukan medis untuk mendapatkan pelayanan kesehatan berupa ${fillVar(vars, 'jenis_pelayanan', '... (Jenis Pelayanan)')} dikarenakan ${fillVar(vars, 'alasan_diagnosa', '... (Alasan/Diagnosa)')}.
    </p>
    <p style="text-align: justify; ">
      Bersama surat ini saya lampirkan surat pengantar dari ${fillVar(vars, 'nama_rs_puskesmas_asal', '... (Nama RS/Puskesmas Asal)')} dan dokumen pendukung lainnya.
    </p>
    <p style="text-align: justify; ">
      Demikian permohonan ini saya sampaikan. Atas perhatian dan bantuannya saya ucapkan terima kasih.
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
