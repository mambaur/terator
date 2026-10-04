import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanBebasPlagiarismeVariables = [
  LetterVariable(
      key: 'judul_karya_ilmiah_tugas_akhir_skripsi',
      label: 'Judul Karya Ilmiah/Tugas Akhir/Skripsi'),
];

String suratPernyataanBebasPlagiarisme(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN BEBAS PLAGIARISME</b>
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
            <td style="white-space: nowrap">NIM</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationNumber ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
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
            <td style="white-space: nowrap">Perguruan Tinggi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationInstitution ?? ''}</td>
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
      Dengan ini menyatakan dengan sebenar-benarnya bahwa karya ilmiah/tugas akhir saya yang berjudul:
    </p>
    <p style="text-align: center; ">
      ${fillVar(vars, 'judul_karya_ilmiah_tugas_akhir_skripsi', '"... (Judul Karya Ilmiah/Tugas Akhir/Skripsi)"', prefix: '"', suffix: '"')}
    </p>
    <p style="text-align: justify; ">
      adalah benar-benar merupakan hasil karya saya sendiri, bukan merupakan duplikasi, plagiasi, ataupun pengambilan karya orang lain tanpa menyebutkan sumber yang sah, kecuali pada bagian-bagian yang sumbernya telah saya cantumkan sesuai dengan kaidah penulisan ilmiah yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Apabila di kemudian hari ditemukan adanya unsur plagiarisme atau penyimpangan dari kaidah ilmiah dalam karya tersebut, maka saya bersedia:
    </p>
    <p style="text-align: justify; ">
      1. Menerima sanksi akademik sesuai dengan ketentuan yang berlaku di ${account?.educationInstitution ?? '... (Nama Perguruan Tinggi)'};
      <br>
      2. Pembatalan gelar akademik yang telah saya peroleh;
      <br>
      3. Mempertanggungjawabkan seluruh konsekuensi hukum yang timbul tanpa melibatkan pihak lain.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pernyataan ini saya buat dengan sesungguhnya, dalam keadaan sadar dan tanpa paksaan dari pihak manapun, untuk dapat dipergunakan sebagaimana mestinya.
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
              <br>
              <span style="white-space: nowrap">NIM. ${account?.educationNumber ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
