import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanHibah(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN HIBAH</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Yang bertanda tangan di bawah ini, selaku <b>Pihak Pemberi Hibah</b>:
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
            <td style="white-space: nowrap">Agama</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.religion ?? ''}</td>
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
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini secara sukarela dan tanpa paksaan dari pihak manapun, menyatakan menghibahkan kepada <b>Pihak Penerima Hibah</b>:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Penerima Hibah)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tempat/Tgl. Lahir Penerima)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hubungan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Hubungan dengan Pemberi Hibah)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nomor KTP/NIK Penerima)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Alamat Penerima)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Berupa <b>... (Objek Hibah, mis. Tanah/Bangunan/Kendaraan/Uang Tunai)</b> dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Jenis</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Jenis/Bentuk Objek Hibah)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Identitas/Bukti Kepemilikan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (No. Sertifikat/BPKB/Lainnya)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Luas/Jumlah/Nilai</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Luas/Jumlah/Nilai Objek)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Lokasi/Letak</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Alamat/Letak Objek)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Hibah ini diberikan secara cuma-cuma tanpa imbalan apapun. Objek hibah tersebut merupakan milik sah Pemberi Hibah, tidak sedang dalam status sengketa, tidak sedang dijaminkan kepada pihak manapun, serta diperoleh dengan cara yang sah menurut hukum.
    </p>
    <p style="text-align: justify; ">
      Dengan ditandatanganinya surat pernyataan ini, maka segala hak kepemilikan atas objek hibah tersebut beralih sepenuhnya kepada Penerima Hibah dan tidak dapat ditarik kembali oleh Pemberi Hibah.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan hibah ini dibuat dengan sebenar-benarnya, dalam keadaan sadar dan tanpa paksaan dari pihak manapun, untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <p style="text-align: center;">
      ${account?.letterCityWritten ?? ''}, $dateNow2
    </p>
    <table border="0" style="width:100%">
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Penerima Hibah,</span>
            <br><br><br><br><br>
            <p>
              <span style="white-space: nowrap">( <b>... (Nama Penerima Hibah)</b> )</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Pemberi Hibah,</span>
            <br>
            ${img ?? '<br><br><br><br><br>'}
            <p>
              <span style="white-space: nowrap">( ${account?.name ?? ''} )</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <p style="text-align: center; ">
      <b>Saksi-Saksi:</b>
    </p>
    <table border="0" style="width:100%">
      <tbody>
        <tr>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Saksi 1,</span>
            <br><br><br><br><br>
            <p>
              <span style="white-space: nowrap">( <b>... (Nama Saksi 1)</b> )</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Saksi 2,</span>
            <br><br><br><br><br>
            <p>
              <span style="white-space: nowrap">( <b>... (Nama Saksi 2)</b> )</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
