import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPernyataanTidakTerlibatKasusHukum(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN TIDAK SEDANG TERLIBAT KASUS HUKUM</b>
    </p>
    <p><br></p>
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
            <td style="white-space: nowrap">Pendidikan Terakhir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.lastEducation ?? ''}</td>
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
      Dengan ini menyatakan dengan sesungguhnya bahwa saya:
    </p>
    <p style="text-align: justify; ">
      1. <b>TIDAK SEDANG TERLIBAT</b> kasus hukum baik pidana maupun perdata dalam bentuk apapun;
      <br>
      2. <b>TIDAK SEDANG MENJALANI</b> proses penyidikan, penuntutan, ataupun persidangan di pengadilan;
      <br>
      3. <b>TIDAK PERNAH DIJATUHI</b> hukuman pidana berdasarkan putusan pengadilan yang telah memperoleh kekuatan hukum tetap;
      <br>
      4. <b>TIDAK SEDANG DALAM PENGAWASAN</b> aparat penegak hukum dengan status tersangka, terdakwa, ataupun terpidana;
      <br>
      5. <b>TIDAK SEDANG DICEKAL</b> atau dilarang bepergian ke luar negeri oleh pihak yang berwenang.
    </p>
    <p style="text-align: justify; ">
      Surat pernyataan ini saya buat untuk keperluan <b>... (Keperluan, mis. Lamaran Kerja/CPNS/Pengajuan Visa/Pencalonan)</b>.
    </p>
    <p style="text-align: justify; ">
      Apabila di kemudian hari pernyataan ini terbukti tidak benar, maka saya bersedia:
    </p>
    <p style="text-align: justify; ">
      1. Menerima sanksi sesuai dengan ketentuan dan peraturan yang berlaku;
      <br>
      2. Dibatalkan keikutsertaan/penerimaan saya dalam proses tersebut tanpa syarat;
      <br>
      3. Mempertanggungjawabkan seluruh konsekuensi hukum yang timbul tanpa melibatkan pihak lain.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sebenar-benarnya, dalam keadaan sadar dan tanpa paksaan dari pihak manapun, untuk dapat dipergunakan sebagaimana mestinya.
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
