import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPengantarSkckVariables = [
  LetterVariable(key: 'alamat_rt_rw', label: 'Alamat RT/RW'),
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(
      key: 'tujuan_skck',
      label: 'Tujuan SKCK',
      hint: 'misal: melamar pekerjaan / pendaftaran CPNS'),
  LetterVariable(key: 'nama_ketua_rt_rw', label: 'Nama Ketua RT/RW'),
];

String suratPengantarSkck(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PENGANTAR SKCK</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Ketua RT/RW ${fillVar(vars, 'alamat_rt_rw', '... (Alamat RT/RW)')}, dengan ini memberikan pengantar kepada:
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
						<td style="white-space: nowrap">Agama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.religion ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Status</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.maritalStatus ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Pekerjaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'pekerjaan', '... (Pekerjaan)')}</td>
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
      Adalah benar warga kami yang berdomisili di wilayah tersebut dan bermaksud mengurus Surat Keterangan Catatan Kepolisian (SKCK) untuk keperluan ${fillVar(vars, 'tujuan_skck', '... (Tujuan SKCK, misal: melamar pekerjaan / pendaftaran CPNS)')}.
    </p>
    <p style="text-align: justify; ">
      Sepanjang pengetahuan kami, yang bersangkutan berkelakuan baik dan tidak pernah terlibat dalam tindak pidana.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengantar ini dibuat untuk dapat digunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Pemohon</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Ketua RT/RW,</span>
          </td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            ${img == null ? '<br><br><br><br><br>' : ''}
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            ${img ?? ''}
          </td>
        </tr>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">${fillVar(vars, 'nama_ketua_rt_rw', '... (Nama Ketua RT/RW)')}</span>
            </p>
          </td>
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
