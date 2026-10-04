import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanPerpanjanganKontrakBisnisVariables = [
  LetterVariable(key: 'nama_pimpinan_mitra', label: 'Nama Pimpinan Mitra'),
  LetterVariable(key: 'nama_perusahaan_mitra', label: 'Nama Perusahaan Mitra'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nomor_kontrak', label: 'Nomor Kontrak'),
  LetterVariable(
      key: 'tanggal_kontrak_awal',
      label: 'Tanggal Kontrak Awal',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'tanggal_berakhir',
      label: 'Tanggal Berakhir',
      type: LetterVariableType.date),
  LetterVariable(key: 'durasi_perpanjangan', label: 'Durasi Perpanjangan'),
];

String suratPermohonanPerpanjanganKontrakBisnis(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_mitra', '... (Nama Pimpinan Mitra)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan_mitra', '... (Nama Perusahaan Mitra)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Perpanjangan Kontrak Kerjasama</b></p>
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
						<td style="white-space: nowrap">Jabatan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'jabatan', '... (Jabatan)')}</td>
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
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan perpanjangan kontrak kerjasama yang telah berjalan antara perusahaan kami dengan ${fillVar(vars, 'nama_perusahaan_mitra', '... (Nama Perusahaan Mitra)')} berdasarkan perjanjian nomor ${fillVar(vars, 'nomor_kontrak', '... (Nomor Kontrak)')} tertanggal ${fillVar(vars, 'tanggal_kontrak_awal', '... (Tanggal Kontrak Awal)')} yang akan berakhir pada tanggal ${fillVar(vars, 'tanggal_berakhir', '... (Tanggal Berakhir)')}.
    </p>
    <p style="text-align: justify; ">
      Selama masa kerjasama, kami merasa bahwa hubungan bisnis yang terjalin berjalan dengan baik dan saling menguntungkan. Oleh karena itu, kami berharap kerjasama ini dapat diperpanjang untuk jangka waktu ${fillVar(vars, 'durasi_perpanjangan', '... (Durasi Perpanjangan)')} ke depan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini kami sampaikan. Atas perhatian dan pertimbangan Bapak/Ibu, kami ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat kami,</span>
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
