import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganTanahVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_kecamatan', label: 'Nama Kecamatan'),
  LetterVariable(key: 'nama_kabupaten_kota', label: 'Nama Kabupaten/Kota'),
  LetterVariable(
      key: 'alamat_lokasi_tanah',
      label: 'Alamat Lokasi Tanah',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'luas_dalam_m2',
      label: 'Luas dalam m²',
      type: LetterVariableType.number),
  LetterVariable(key: 'batas_utara', label: 'Batas Utara'),
  LetterVariable(key: 'batas_selatan', label: 'Batas Selatan'),
  LetterVariable(key: 'batas_timur', label: 'Batas Timur'),
  LetterVariable(key: 'batas_barat', label: 'Batas Barat'),
  LetterVariable(
      key: 'status_kepemilikan',
      label: 'Status Kepemilikan',
      type: LetterVariableType.choice,
      options: ['Hak Milik', 'Girik', 'Lainnya']),
  LetterVariable(
      key: 'nama_kepala_desa_lurah', label: 'Nama Kepala Desa/Lurah'),
];

String suratKeteranganTanah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN TANAH</b>
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
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Adalah benar memiliki / menguasai sebidang tanah yang terletak di wilayah kami dengan rincian:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Lokasi Tanah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'alamat_lokasi_tanah', '... (Alamat Lokasi Tanah)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Luas Tanah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'luas_dalam_m2', '... (Luas dalam m²)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Utara</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'batas_utara', '... (Batas Utara)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Selatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'batas_selatan', '... (Batas Selatan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Timur</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'batas_timur', '... (Batas Timur)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Batas Barat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'batas_barat', '... (Batas Barat)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Status Tanah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'status_kepemilikan', '... (Hak Milik / Girik / Lainnya)')}</td>
					</tr>
				</tbody>
			</table>
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
            <span style="white-space: nowrap">Pemilik Tanah</span>
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
