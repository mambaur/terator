import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanBantuanSosialVariables = [
  LetterVariable(key: 'nama_pejabat_instansi', label: 'Nama Pejabat/Instansi'),
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(
      key: 'jenis_bantuan',
      label: 'Jenis Bantuan',
      hint: 'misal: bantuan pangan / bantuan tunai / bantuan kesehatan'),
  LetterVariable(
      key: 'alasan_permohonan',
      label: 'Alasan Permohonan',
      type: LetterVariableType.multiline,
      hint:
          'misal: kondisi ekonomi yang sulit / terdampak bencana alam / kepala keluarga meninggal dunia'),
  LetterVariable(
      key: 'jumlah_tanggungan',
      label: 'Jumlah Tanggungan',
      type: LetterVariableType.number),
  LetterVariable(
      key: 'nominal_penghasilan',
      label: 'Nominal Penghasilan',
      type: LetterVariableType.currency),
];

String suratPermohonanBantuanSosial(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pejabat_instansi', '... (Nama Pejabat/Instansi)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Bantuan Sosial</b></p>
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
          <tr>
						<td style="white-space: nowrap">No. Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan bantuan sosial berupa ${fillVar(vars, 'jenis_bantuan', '... (Jenis Bantuan, misal: bantuan pangan / bantuan tunai / bantuan kesehatan)')} dikarenakan ${fillVar(vars, 'alasan_permohonan', '... (Alasan Permohonan, misal: kondisi ekonomi yang sulit / terdampak bencana alam / kepala keluarga meninggal dunia)')}.
    </p>
    <p style="text-align: justify; ">
      Saya memiliki tanggungan sebanyak ${fillVar(vars, 'jumlah_tanggungan', '... (Jumlah Tanggungan)')} orang dengan penghasilan rata-rata sebesar ${fillVar(vars, 'nominal_penghasilan', 'Rp ... (Nominal Penghasilan)', prefix: 'Rp ')} per bulan.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya lampirkan fotokopi KTP, Kartu Keluarga, dan surat keterangan tidak mampu dari RT/RW setempat.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya buat dengan sebenar-benarnya. Atas perhatian dan bantuannya saya ucapkan terima kasih.
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
