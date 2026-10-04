import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanSecondOpinionVariables = [
  LetterVariable(key: 'nama_dokter_spesialis', label: 'Nama Dokter Spesialis'),
  LetterVariable(
      key: 'nama_rumah_sakit_klinik_tujuan',
      label: 'Nama Rumah Sakit / Klinik Tujuan'),
  LetterVariable(
      key: 'nama_dokter_rumah_sakit_sebelumnya',
      label: 'Nama Dokter/Rumah Sakit Sebelumnya'),
  LetterVariable(key: 'jenis_diagnosis', label: 'Jenis Diagnosis'),
  LetterVariable(
      key: 'jenis_tindakan_yang_direkomendasikan',
      label: 'Jenis Tindakan yang Direkomendasikan'),
];

String suratPermohonanSecondOpinion(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_dokter_spesialis', '... (Nama Dokter Spesialis)')}
      <br>
      ${fillVar(vars, 'nama_rumah_sakit_klinik_tujuan', '... (Nama Rumah Sakit / Klinik Tujuan)')}
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
      Dengan ini mengajukan permohonan untuk mendapatkan pendapat medis kedua (second opinion) atas diagnosis yang telah saya terima sebelumnya dari ${fillVar(vars, 'nama_dokter_rumah_sakit_sebelumnya', '... (Nama Dokter/Rumah Sakit Sebelumnya)')}.
    </p>
    <p style="text-align: justify; ">
      Adapun diagnosis sebelumnya yang saya terima adalah ${fillVar(vars, 'jenis_diagnosis', '... (Jenis Diagnosis)')} dengan rekomendasi tindakan berupa ${fillVar(vars, 'jenis_tindakan_yang_direkomendasikan', '... (Jenis Tindakan yang Direkomendasikan)')}.
    </p>
    <p style="text-align: justify; ">
      Saya berharap dapat memperoleh evaluasi dan pendapat medis dari dokter yang bersangkutan untuk memastikan langkah pengobatan yang terbaik.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat. Atas perhatian dan bantuannya saya ucapkan terima kasih.
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
