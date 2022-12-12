import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratLamaranPekerjaan(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      Bapak/Ibu Pimpinan
      <br>
      ... (Nama Perusahaan)
      <br>
      ... (Alamat)
      <br>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini :
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
						<td style="white-space: nowrap">Status</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.maritalStatus ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Pendidikan Terakhir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.lastEducation ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Nomor Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
          tr>
						<td style="white-space: nowrap">Alamat</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.address ?? ''}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Dengan surat lamaran ini saya mengajukan permohonan kerja di perusahaan yang Bapak/Ibu pimpin untuk menempati posisi <b> ... (Jabatan)</b>.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya telah melampirkan beberapa berkas penting sebagai berikut:
    </p>
    <p>
      <ul>
        <li>Daftar Riwayat Hidup</li>
        <li>Scan Kartu Tanda Penduduk (KTP)</li>
        <li>Scan Ijazah Terakhir</li>
        <li>Scan Surat Keterangan Dokter</li>
        <li>Pas Photo format .jpeg (1 file)</li>
      </ul>
    </p>
    <p style="text-align: justify; ">
      Demikian surat lamaran kerja yang saya buat, dengan lamaran ini besar harapan saya semoga dapat diterima diperusahaan yang Bapak/Ibu pimpin, terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">Hormat saya,</span>
            </p>
            $image
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
