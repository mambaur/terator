import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanMenjadiSupplierVariables = [
  LetterVariable(
      key: 'nama_pimpinan_bagian_pengadaan',
      label: 'Nama Pimpinan/Bagian Pengadaan'),
  LetterVariable(
      key: 'nama_perusahaan_tujuan', label: 'Nama Perusahaan Tujuan'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'bidang_usaha', label: 'Bidang Usaha'),
  LetterVariable(key: 'jenis_produk_jasa', label: 'Jenis Produk/Jasa'),
  LetterVariable(key: 'lama_pengalaman', label: 'Lama Pengalaman'),
  LetterVariable(key: 'kapasitas', label: 'Kapasitas'),
];

String suratPermohonanMenjadiSupplier(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_bagian_pengadaan', '... (Nama Pimpinan/Bagian Pengadaan)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan_tujuan', '... (Nama Perusahaan Tujuan)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Permohonan Menjadi Supplier/Pemasok</b></p>
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
						<td style="white-space: nowrap">Nama Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Bidang Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'bidang_usaha', '... (Bidang Usaha)')}</td>
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
          <tr>
						<td style="white-space: nowrap">Email</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.email ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini mengajukan permohonan untuk menjadi supplier/pemasok di perusahaan Bapak/Ibu. Perusahaan kami menyediakan produk/jasa berupa ${fillVar(vars, 'jenis_produk_jasa', '... (Jenis Produk/Jasa)')} yang telah berpengalaman selama ${fillVar(vars, 'lama_pengalaman', '... (Lama Pengalaman)')}.
    </p>
    <p style="text-align: justify; ">
      Kami memiliki kapasitas produksi/penyediaan sebesar ${fillVar(vars, 'kapasitas', '... (Kapasitas)')} per bulan dan siap memenuhi kebutuhan perusahaan Bapak/Ibu dengan harga yang kompetitif serta kualitas terjamin.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, kami lampirkan company profile, daftar harga, katalog produk, dan dokumen legalitas perusahaan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini kami sampaikan. Atas perhatian dan kesempatan yang diberikan, kami ucapkan terima kasih.
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
