import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKeteranganTidakMampu(
    LetterModel? letter, String? img, AccountModel? account) {
  // String dateNow =
  //     DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html = """
    <p style="text-align: center;">
      <b>SURAT KETERANGAN TIDAK MAMPU</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini Kepala Kelurahan <b>... (Alamat)</b> menerangkan bahwa :
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
						<td style="white-space: nowrap">Jenis Kelamin</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.gender ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tempat / Tgl. Lahir</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Agama</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.religion ?? ''}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Pekerjaan</td>
						<td>:&nbsp</td>
						<td style="width: 100%"></td>
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
      Warga tersebut diatas adalah benar penduduk <b>... (Alamat)</b> yang bertempat tinggal di alamat tersebut diatas.
    </p>
    <p style="text-align: justify; ">
      Berdasarkan Pengantar dari Ketua RT/RW setempat yang menurut sepengetahuan kami, bahwa benar yang bersangkutan tergolong orang yang tidak mampu/miskin.
    </p>
    <p style="text-align: justify; ">
      Surat keterangan ini kami berikan atas permintaan yang bersangkutan untuk dipergunakan sebagai <b>... (Kebutuhan)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian surat keterangan ini kami buat dengan sesungguhnya untuk dapat dipergunakan seperlunya.
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
              <span style="white-space: nowrap">Kepala Kelurahan,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap"><b>... (Nama Kepala Lurah)</b></span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
