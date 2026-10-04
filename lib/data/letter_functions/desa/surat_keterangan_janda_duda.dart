import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganJandaDudaVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_kecamatan', label: 'Nama Kecamatan'),
  LetterVariable(key: 'nama_kabupaten_kota', label: 'Nama Kabupaten/Kota'),
  LetterVariable(
      key: 'status',
      label: 'Status',
      type: LetterVariableType.choice,
      options: ['Janda', 'Duda']),
  LetterVariable(
      key: 'tanggal', label: 'Tanggal', type: LetterVariableType.date),
  LetterVariable(
      key: 'alasan',
      label: 'Alasan',
      type: LetterVariableType.multiline,
      hint:
          'misal: suami/istri meninggal dunia / perceraian berdasarkan putusan pengadilan nomor ...'),
  LetterVariable(
      key: 'tujuan',
      label: 'Tujuan',
      hint: 'misal: administrasi pernikahan / pengajuan bantuan sosial'),
  LetterVariable(
      key: 'nama_kepala_desa_lurah', label: 'Nama Kepala Desa/Lurah'),
];

String suratKeteranganJandaDuda(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN JANDA / DUDA</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah ${fillVar(vars, 'nama_desa_kelurahan', '... (Nama Desa/Kelurahan)')}, Kecamatan ${fillVar(vars, 'nama_kecamatan', '... (Nama Kecamatan)')}, Kabupaten/Kota ${fillVar(vars, 'nama_kabupaten_kota', '... (Nama Kabupaten/Kota)')}, dengan ini menerangkan bahwa:
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
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Adalah benar berstatus sebagai ${fillVar(vars, 'status', '... (Janda / Duda)')} sejak tanggal ${fillVar(vars, 'tanggal', '... (Tanggal)')} dikarenakan ${fillVar(vars, 'alasan', '... (Alasan, misal: suami/istri meninggal dunia / perceraian berdasarkan putusan pengadilan nomor ...)')}.
    </p>
    <p style="text-align: justify; ">
      Surat keterangan ini dibuat untuk keperluan ${fillVar(vars, 'tujuan', '... (Tujuan, misal: administrasi pernikahan / pengajuan bantuan sosial)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ini dibuat dengan sebenar-benarnya untuk dapat digunakan sebagaimana mestinya.
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
            <span style="white-space: nowrap">Kepala Desa/Lurah,</span>
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
              <span style="white-space: nowrap">${fillVar(vars, 'nama_kepala_desa_lurah', '... (Nama Kepala Desa/Lurah)')}</span>
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
