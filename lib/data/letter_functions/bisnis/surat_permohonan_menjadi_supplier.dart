import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanMenjadiSupplier(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Pimpinan/Bagian Pengadaan)</b>
      <br>
      <b>... (Nama Perusahaan Tujuan)</b>
      <br>
      di <b>... (Alamat)</b>
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
						<td style="width: 100%"><b>... (Jabatan)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Nama Perusahaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Nama Perusahaan)</b></td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Bidang Usaha</td>
						<td>:&nbsp</td>
						<td style="width: 100%"><b>... (Bidang Usaha)</b></td>
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
      Dengan ini mengajukan permohonan untuk menjadi supplier/pemasok di perusahaan Bapak/Ibu. Perusahaan kami menyediakan produk/jasa berupa <b>... (Jenis Produk/Jasa)</b> yang telah berpengalaman selama <b>... (Lama Pengalaman)</b>.
    </p>
    <p style="text-align: justify; ">
      Kami memiliki kapasitas produksi/penyediaan sebesar <b>... (Kapasitas)</b> per bulan dan siap memenuhi kebutuhan perusahaan Bapak/Ibu dengan harga yang kompetitif serta kualitas terjamin.
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
