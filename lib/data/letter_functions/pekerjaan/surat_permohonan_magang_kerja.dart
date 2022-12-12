import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanMagangKerja(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Perihal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">Permohonan Magang Kerja</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Lampiran</td>
						<td>:&nbsp</td>
						<td style="width: 100%">1 Berkas</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      Kepala Bagian HRD
      <br>
      ... (Nama Instansi)
      <br>
      ... (Alamat)
      <br>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Sehubungan dengan informasi tentang lowongan magang di <b>... (Instansi)</b>, maka saya yang bertanda tangan di bawah ini :
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
						<td style="white-space: nowrap">NIS</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationNumber ?? ''}</td>
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
						<td style="white-space: nowrap">Pendidikan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.lastEducation ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Kewarganegaraan</td>
						<td>:&nbsp</td>
						<td style="width: 100%">Indonesia</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Agama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.religion ?? ''}</td>
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
      Dengan pembuatan surat ini saya memiliki maksud untuk mengajukan surat izin dalam rangka pelaksanaan magang. Saya telah membaca semua persyaratan dan bersedia memenuhi semua ketentuan perusahaan. Untuk itu, sebagai bahan pertimbangan Bapak/Ibu HRD, bersama surat permohonan magang ini saya turut melampirkan :
    </p>
    <p>
      <ul>
        <li>Fotokopi Ijazah Terakhir</li>
        <li>Fotokopi Transkrip Nilai</li>
        <li>Fotokopi KTP</li>
        <li>Surat Keterangan Catatan Kepolisian (SKCK)</li>
        <li>Surat Keterangan Sehat</li>
        <li>Daftar Riwayat Hidup</li>
        <li>Pas Foto Terbaru Ukuran 4 x 6</li>
        <li>Fotokopi Sertifikat Akreditasi</li>
      </ul>
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan magang yang saya ajukan. Sangat besar harapan dari saya agar Bapak/Ibu dapat berkenan mempertimbangkan permohonan saya ini.
    </p>
    <p style="text-align: justify; ">
      Saya ucapkan terima kasih atas perhatiannya.
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
