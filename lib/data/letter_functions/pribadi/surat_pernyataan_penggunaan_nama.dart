import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanPenggunaanNama(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN PENGGUNAAN NAMA</b>
    </p>
    <p><br></p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama Lengkap</td>
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
          <tr>
            <td style="white-space: nowrap">No. Telp</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.telephone ?? ''}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyatakan dengan sebenar-benarnya bahwa nama yang tertera pada dokumen-dokumen di bawah ini, meskipun memiliki perbedaan penulisan, adalah merujuk pada orang yang sama yaitu saya pribadi:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama pada KTP</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama sesuai KTP)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nama pada Ijazah</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama sesuai Ijazah)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nama pada Akta Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama sesuai Akta Lahir)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nama pada Kartu Keluarga</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama sesuai Kartu Keluarga)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nama pada Dokumen Lain</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama sesuai Dokumen Lain)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Perbedaan penulisan nama tersebut disebabkan oleh <b>... (Alasan Perbedaan Penulisan Nama, mis. Kesalahan Penulisan/Penyingkatan)</b> dan bukan merupakan upaya untuk memalsukan identitas maupun untuk tujuan yang melawan hukum.
    </p>
    <p style="text-align: justify; ">
      Surat pernyataan ini saya buat untuk keperluan <b>... (Keperluan, mis. Pencairan Dana/Pendaftaran)</b>. Apabila di kemudian hari pernyataan ini terbukti tidak benar, maka saya bersedia mempertanggungjawabkan sepenuhnya secara hukum tanpa melibatkan pihak lain.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya untuk dapat dipergunakan sebagaimana mestinya.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Yang menyatakan,</span>
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
