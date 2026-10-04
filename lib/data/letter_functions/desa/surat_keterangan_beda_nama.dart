import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganBedaNamaVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_kecamatan', label: 'Nama Kecamatan'),
  LetterVariable(key: 'nama_kabupaten_kota', label: 'Nama Kabupaten/Kota'),
  LetterVariable(
      key: 'jenis_dokumen',
      label: 'Jenis Dokumen',
      hint: 'misal: Ijazah / Akta Kelahiran / Buku Nikah'),
  LetterVariable(key: 'nama_di_dokumen', label: 'Nama (di dokumen)'),
  LetterVariable(
      key: 'alasan_perbedaan',
      label: 'Alasan Perbedaan',
      type: LetterVariableType.multiline,
      hint: 'misal: kesalahan penulisan / perubahan nama'),
  LetterVariable(key: 'tujuan', label: 'Tujuan'),
  LetterVariable(
      key: 'nama_kepala_desa_lurah', label: 'Nama Kepala Desa/Lurah'),
];

String suratKeteranganBedaNama(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN BEDA NAMA</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Desa/Lurah ${fillVar(vars, 'nama_desa_kelurahan', '... (Nama Desa/Kelurahan)')}, Kecamatan ${fillVar(vars, 'nama_kecamatan', '... (Nama Kecamatan)')}, Kabupaten/Kota ${fillVar(vars, 'nama_kabupaten_kota', '... (Nama Kabupaten/Kota)')}, dengan ini menerangkan bahwa:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama (sesuai KTP)</td>
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
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Adalah benar orang yang sama dengan yang tertulis dalam dokumen ${fillVar(vars, 'jenis_dokumen', '... (Jenis Dokumen, misal: Ijazah / Akta Kelahiran / Buku Nikah)')} dengan nama:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama (di dokumen)</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_di_dokumen', '... (Nama Berbeda)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Perbedaan nama tersebut terjadi karena ${fillVar(vars, 'alasan_perbedaan', '... (Alasan Perbedaan, misal: kesalahan penulisan / perubahan nama)')}. Surat keterangan ini dibuat untuk keperluan ${fillVar(vars, 'tujuan', '... (Tujuan)')}.
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
