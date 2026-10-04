import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKeteranganKehilanganVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'jenis_barang_dokumen', label: 'Jenis Barang/Dokumen'),
  LetterVariable(key: 'nomor_jika_ada', label: 'Nomor (jika ada)'),
  LetterVariable(
      key: 'perkiraan_waktu_hilang', label: 'Perkiraan Waktu Hilang'),
  LetterVariable(key: 'lokasi_kehilangan', label: 'Lokasi Kehilangan'),
  LetterVariable(
      key: 'dokumen_barang_yang_hilang', label: 'Dokumen/Barang yang Hilang'),
  LetterVariable(key: 'nama_ketua_rt_rw', label: 'Nama Ketua RT/RW'),
];

String suratKeteranganKehilangan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN KEHILANGAN</b>
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
      Dengan ini melaporkan kehilangan barang/dokumen sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Jenis Barang/Dokumen</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jenis_barang_dokumen', '... (Jenis Barang/Dokumen)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Nomor (jika ada)</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nomor_jika_ada', '... (Nomor Dokumen)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Perkiraan Waktu Hilang</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'perkiraan_waktu_hilang', '... (Waktu Kehilangan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Lokasi Kehilangan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'lokasi_kehilangan', '... (Lokasi Kehilangan)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Surat keterangan ini dibuat untuk keperluan pengurusan penggantian ${fillVar(vars, 'dokumen_barang_yang_hilang', '... (Dokumen/Barang yang Hilang)')} dan sebagai bukti laporan kehilangan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ini saya buat dengan sebenar-benarnya, tanpa paksaan dari pihak manapun.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <br>
            <span style="white-space: nowrap">Mengetahui,</span>
            <br>
            <span style="white-space: nowrap">Ketua RT/RW</span>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Yang menyatakan,</span>
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
