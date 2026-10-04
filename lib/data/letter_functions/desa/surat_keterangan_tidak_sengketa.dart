import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganTidakSengketaVariables = [
  LetterVariable(key: 'nama_desa_kelurahan', label: 'Nama Desa/Kelurahan'),
  LetterVariable(key: 'nama_kecamatan', label: 'Nama Kecamatan'),
  LetterVariable(key: 'nama_kabupaten_kota', label: 'Nama Kabupaten/Kota'),
  LetterVariable(
      key: 'jenis_aset',
      label: 'Jenis Aset',
      type: LetterVariableType.choice,
      options: ['Tanah', 'Bangunan', 'Aset']),
  LetterVariable(key: 'lokasi_aset', label: 'Lokasi Aset'),
  LetterVariable(key: 'luas', label: 'Luas'),
  LetterVariable(
      key: 'tujuan',
      label: 'Tujuan',
      hint: 'misal: jual beli / pengajuan kredit / sertifikasi'),
  LetterVariable(
      key: 'nama_kepala_desa_lurah', label: 'Nama Kepala Desa/Lurah'),
];

String suratKeteranganTidakSengketa(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN TIDAK SENGKETA</b>
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
      Memiliki ${fillVar(vars, 'jenis_aset', '... (Tanah / Bangunan / Aset)')} yang terletak di ${fillVar(vars, 'lokasi_aset', '... (Lokasi Aset)')} dengan luas ${fillVar(vars, 'luas', '... (Luas)')}.
    </p>
    <p style="text-align: justify; ">
      Berdasarkan pengetahuan kami, ${fillVar(vars, 'jenis_aset', '... (tanah / bangunan / aset)')} tersebut tidak sedang dalam keadaan sengketa dengan pihak manapun, tidak sedang dijaminkan, dan tidak sedang dalam sitaan.
    </p>
    <p style="text-align: justify; ">
      Surat keterangan ini dibuat untuk keperluan ${fillVar(vars, 'tujuan', '... (Tujuan, misal: jual beli / pengajuan kredit / sertifikasi)')}.
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
            <span style="white-space: nowrap">Pemilik</span>
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
