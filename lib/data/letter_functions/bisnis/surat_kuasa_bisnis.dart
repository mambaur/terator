import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKuasaBisnisVariables = [
  LetterVariable(key: 'jabatan_pemberi_kuasa', label: 'Jabatan Pemberi Kuasa'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nama_penerima_kuasa', label: 'Nama Penerima Kuasa'),
  LetterVariable(
      key: 'jabatan_penerima_kuasa', label: 'Jabatan Penerima Kuasa'),
  LetterVariable(key: 'nik', label: 'NIK'),
  LetterVariable(
      key: 'detail_kuasa',
      label: 'Detail Kuasa',
      type: LetterVariableType.multiline,
      hint: 'misal: penandatanganan kontrak, pengambilan dokumen, dll'),
  LetterVariable(
      key: 'tanggal_berakhir',
      label: 'Tanggal Berakhir',
      type: LetterVariableType.date),
  LetterVariable(key: 'penerima_kuasa', label: 'Penerima Kuasa'),
];

String suratKuasaBisnis(LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KUASA</b>
    </p>
    <p><br></p>
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jabatan_pemberi_kuasa', '... (Jabatan)')}</td>
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
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Memberikan kuasa penuh kepada:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_penerima_kuasa', '... (Nama Penerima Kuasa)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jabatan_penerima_kuasa', '... (Jabatan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">NIK</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nik', '... (NIK)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Untuk dan atas nama pemberi kuasa melakukan ${fillVar(vars, 'detail_kuasa', '... (Detail Kuasa, misal: penandatanganan kontrak, pengambilan dokumen, dll)')}.
    </p>
    <p style="text-align: justify; ">
      Surat kuasa ini berlaku sejak ditandatangani sampai dengan ${fillVar(vars, 'tanggal_berakhir', '... (Tanggal Berakhir)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat kuasa ini dibuat untuk dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Penerima Kuasa</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Pemberi Kuasa,</span>
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
              <span style="white-space: nowrap">${fillVar(vars, 'penerima_kuasa', '... (Penerima Kuasa)')}</span>
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
