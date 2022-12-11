import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanBeaSiswa(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());

  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String image = img ??
      '<p style="text-align: right; "><br></p><p style="text-align: right; "><br></p>';

  String html2 =
      '<p style="text-align: right; ">$dateNow</p><p>Perihal: Permohonan Beasiswa<br>Lampiran: 1 Berkas</p><p><br></p><p>Kepada Yth.<br>Kepala ${account?.educationInstitution ?? ''}<br>${account?.educationAddress ?? ''}</p><p><br></p><p>Dengan Hormat,</p><p>Bersamaan adanya informasi beasiswa <b>(Nama Beasiswa)</b>, saya yang bertanda tangan di bawah ini:</p><p>Nama : ${account?.name ?? ''}<br>NIS : ${account?.educationNumber ?? ''}<br>TTL : ${account?.placeAndDateOfBirth ?? ''}<br>Sekolah Asal : ${account?.educationInstitution ?? ''}<br>Kelas : ${account?.educationClass ?? ''}<br>Alamat : ${account?.address ?? ''}</p><p>Dengan ini, saya ingin mengajukan permohonan untuk program Beasiswa. Sebagai pertimbangan, saya lampirkan berkas yang dibutuhkan:</p><p></p><ul><li>Fotokopi KTP</li><li>Fotokopi KTM</li><li>Transkrip Nilai</li><li>Pas Foto 4 x 6</li></ul><p>Demikian surat permohonan yang saya ajukan dengan semestinya. Terima kasih atas perhatian dan bantuannya.</p><p><br></p><p style="text-align: right; ">Hormat saya,</p>$image<p style="text-align: right; ">${account?.name ?? ''}<br>${account?.educationNumber ?? ''}</p>';

  String html = """
    <p style="text-align: right; ">$dateNow</p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">Perihal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">Permohonan Beasiswa</td>
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
      Kepala ${account?.educationInstitution ?? ''}
      <br>
      ${account?.educationAddress ?? ''}
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Bersamaan adanya informasi Beasiswa <b>...(Nama Beasiswa)</b>, saya yang bertanda tangan di bawah ini:
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
						<td style="white-space: nowrap">Sekolah Asal</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationInstitution ?? ''}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Kelas</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${account?.educationClass ?? ''}</td>
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
      Dengan ini, saya ingin mengajukan permohonan untuk program Beasiswa. Sebagai pertimbangan, saya lampirkan berkas yang dibutuhkan:
    </p>
    <p>
      <ul>
        <li>Fotokopi KTP</li>
        <li>Fotokopi KTM</li>
        <li>Transkrip Nilai</li>
        <li>Pas Foto 4 x 6</li>
      </ul>
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan yang saya ajukan dengan semestinya. Terima kasih atas perhatian dan bantuannya.
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
              <span style="white-space: nowrap">Hormat saya,</span>
            </p>
            $image
            <p>
              <span style="white-space: nowrap">${account?.name ?? ''}</span>
              <br>
              <span style="white-space: nowrap">${account?.educationNumber ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
