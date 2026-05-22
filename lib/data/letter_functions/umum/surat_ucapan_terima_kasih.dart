import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratUcapanTerimaKasih(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Ucapan Terima Kasih</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Penerima)</b>
      <br>
      <b>... (Jabatan/Instansi Penerima)</b>
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Puji syukur kami panjatkan kepada Tuhan Yang Maha Esa atas segala rahmat dan karunia-Nya. Melalui surat ini, perkenankanlah kami menyampaikan rasa terima kasih yang sebesar-besarnya kepada Bapak/Ibu atas <b>... (Hal yang Diapresiasi, mis. Bantuan/Dukungan/Partisipasi/Kerjasama dalam Acara)</b> yang telah diberikan.
    </p>
    <p style="text-align: justify; ">
      Dukungan, perhatian, dan kerja sama yang Bapak/Ibu berikan sangat berarti dan memberikan kontribusi nyata terhadap <b>... (Kegiatan/Acara/Tujuan yang Dicapai)</b>. Tanpa adanya dukungan tersebut, niscaya kegiatan ini tidak akan dapat berjalan dengan lancar dan baik.
    </p>
    <p style="text-align: justify; ">
      Kami menyadari bahwa apa yang Bapak/Ibu lakukan merupakan bentuk kepedulian yang luar biasa. Semoga segala kebaikan tersebut mendapatkan balasan yang berlipat ganda dari Tuhan Yang Maha Esa.
    </p>
    <p style="text-align: justify; ">
      Kami berharap silaturahmi dan kerja sama yang baik ini dapat terus terjalin di masa yang akan datang. Apabila terdapat hal-hal yang kurang berkenan selama proses kerja sama, dengan segala kerendahan hati kami mohon maaf yang sebesar-besarnya.
    </p>
    <p style="text-align: justify; ">
      Demikian surat ucapan terima kasih ini kami sampaikan. Atas perhatian dan kebaikan Bapak/Ibu, sekali lagi kami ucapkan terima kasih.
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
