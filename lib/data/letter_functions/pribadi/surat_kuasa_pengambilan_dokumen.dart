import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratKuasaPengambilanDokumen(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT KUASA PENGAMBILAN DOKUMEN</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini, selaku <b>Pemberi Kuasa</b>:
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
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
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
            <td style="width: 100%"><b>... (Pekerjaan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nomor KTP/NIK)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.address ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Telp</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.telephone ?? ''}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini memberikan kuasa kepada, selaku <b>Penerima Kuasa</b>:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Penerima Kuasa)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tempat/Tgl. Lahir Penerima Kuasa)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Pekerjaan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Pekerjaan Penerima Kuasa)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nomor KTP/NIK Penerima Kuasa)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hubungan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Hubungan dengan Pemberi Kuasa)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Alamat Penerima Kuasa)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Telp</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (No. Telp Penerima Kuasa)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      <b>--------------------------------------- KHUSUS ---------------------------------------</b>
    </p>
    <p style="text-align: justify; ">
      Untuk dan atas nama Pemberi Kuasa mengambil dokumen berupa <b>... (Jenis Dokumen yang Diambil)</b> di <b>... (Nama Instansi/Tempat Pengambilan)</b> yang beralamat di <b>... (Alamat Instansi)</b>.
    </p>
    <p style="text-align: justify; ">
      Surat kuasa ini diberikan karena Pemberi Kuasa berhalangan untuk mengambil dokumen tersebut secara langsung, dengan alasan <b>... (Alasan Tidak Dapat Mengambil Sendiri)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian surat kuasa ini dibuat dengan sebenar-benarnya untuk dapat dipergunakan sebagaimana mestinya. Segala akibat yang timbul dari penggunaan surat kuasa ini menjadi tanggung jawab bersama.
    </p>
    <p><br></p>
    <p style="text-align: center;">
      ${account?.letterCityWritten ?? ''}, $dateNow2
    </p>
    <table border="0" style="width:100%">
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Penerima Kuasa,</span>
            <br><br><br><br><br>
            <p>
              <span style="white-space: nowrap">( <b>... (Nama Penerima Kuasa)</b> )</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Pemberi Kuasa,</span>
            <br>
            ${img ?? '<br><br><br><br><br>'}
            <p>
              <span style="white-space: nowrap">( ${account?.name ?? ''} )</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
