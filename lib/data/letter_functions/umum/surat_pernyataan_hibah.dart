import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanHibahVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(key: 'nama_penerima_hibah', label: 'Nama Penerima Hibah'),
  LetterVariable(
      key: 'tempat_tgl_lahir_penerima', label: 'Tempat/Tgl. Lahir Penerima'),
  LetterVariable(
      key: 'hubungan_dengan_pemberi_hibah',
      label: 'Hubungan dengan Pemberi Hibah'),
  LetterVariable(
      key: 'nomor_ktp_nik_penerima', label: 'Nomor KTP/NIK Penerima'),
  LetterVariable(
      key: 'alamat_penerima',
      label: 'Alamat Penerima',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'objek_hibah',
      label: 'Objek Hibah',
      hint: 'mis. Tanah/Bangunan/Kendaraan/Uang Tunai'),
  LetterVariable(
      key: 'jenis_bentuk_objek_hibah', label: 'Jenis/Bentuk Objek Hibah'),
  LetterVariable(
      key: 'no_sertifikat_bpkb_lainnya', label: 'No. Sertifikat/BPKB/Lainnya'),
  LetterVariable(
      key: 'luas_jumlah_nilai_objek', label: 'Luas/Jumlah/Nilai Objek'),
  LetterVariable(
      key: 'alamat_letak_objek',
      label: 'Alamat/Letak Objek',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_saksi_1', label: 'Nama Saksi 1'),
  LetterVariable(key: 'nama_saksi_2', label: 'Nama Saksi 2'),
];

String suratPernyataanHibah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
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
            <td style="width: 100%">${fillVar(vars, 'pekerjaan', '... (Pekerjaan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik', '... (Nomor KTP/NIK)')}</td>
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
            <td style="width: 100%">${fillVar(vars, 'nama_penerima_hibah', '... (Nama Penerima Hibah)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tempat_tgl_lahir_penerima', '... (Tempat/Tgl. Lahir Penerima)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hubungan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hubungan_dengan_pemberi_hibah', '... (Hubungan dengan Pemberi Hibah)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik_penerima', '... (Nomor KTP/NIK Penerima)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_penerima', '... (Alamat Penerima)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Berupa ${fillVar(vars, 'objek_hibah', '... (Objek Hibah, mis. Tanah/Bangunan/Kendaraan/Uang Tunai)')} dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Jenis</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jenis_bentuk_objek_hibah', '... (Jenis/Bentuk Objek Hibah)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Identitas/Bukti Kepemilikan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'no_sertifikat_bpkb_lainnya', '... (No. Sertifikat/BPKB/Lainnya)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Luas/Jumlah/Nilai</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'luas_jumlah_nilai_objek', '... (Luas/Jumlah/Nilai Objek)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Lokasi/Letak</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_letak_objek', '... (Alamat/Letak Objek)')}</td>
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
              <span style="white-space: nowrap">( ${fillVar(vars, 'nama_penerima_hibah', '... (Nama Penerima Hibah)')} )</span>
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
              <span style="white-space: nowrap">( ${fillVar(vars, 'nama_saksi_1', '... (Nama Saksi 1)')} )</span>
            </p>
          </td>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Saksi 2,</span>
            <br><br><br><br><br>
            <p>
              <span style="white-space: nowrap">( ${fillVar(vars, 'nama_saksi_2', '... (Nama Saksi 2)')} )</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
