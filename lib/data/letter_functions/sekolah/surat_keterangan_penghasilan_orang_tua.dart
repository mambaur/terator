import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganPenghasilanOrangTua(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN PENGHASILAN ORANG TUA / WALI</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan dibawah ini:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Nama Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.parentName ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat / Tgl. Lahir Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Nomor Telepon Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Pekerjaan Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Alamat Orang tua / Wali</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Yang merupakan orang tua / wali dari:
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
						<td style="white-space: nowrap">NIM</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationNumber ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Fakultas</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationFaculty ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Program Studi</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationStudyProgram ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Nomor Telepon</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.telephone ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Email</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.email ?? ''}</td>
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
      Menyatakan bahwa saat ini, kami selaku orang tua/wali mempunyai penghasilan rata-rata sebesar <b> Rp ... (Penghasilan)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian pernyataan ini kami buat dengan sebenar-benarnya dan penuh rasa tanggung jawab, dan apabila dikemudian hari ternyata pernyataan ini tidak benar/menyimpang dengan keadaan yang sebenarnya, kami bersedia menerima sanksi yang telah ditetapkan.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <p>
              <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
              <br>
              <span style="white-space: nowrap">Orang tua / Wali,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap">${account?.parentName ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
