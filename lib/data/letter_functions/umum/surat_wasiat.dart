import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratWasiatVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(
      key: 'rincian_harta_1',
      label: 'Rincian Harta 1',
      type: LetterVariableType.multiline,
      hint: 'mis. Tanah seluas ... m² di alamat ...'),
  LetterVariable(
      key: 'rincian_harta_2',
      label: 'Rincian Harta 2',
      type: LetterVariableType.multiline,
      hint: 'mis. Kendaraan/Tabungan/Saham'),
  LetterVariable(
      key: 'rincian_harta_lainnya',
      label: 'Rincian Harta Lainnya',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'nama_penerima_wasiat_1', label: 'Nama Penerima Wasiat 1'),
  LetterVariable(key: 'hubungan_ahli_waris_1', label: 'Hubungan Ahli Waris 1'),
  LetterVariable(key: 'bagian_ahli_waris_1', label: 'Bagian Ahli Waris 1'),
  LetterVariable(
      key: 'nama_penerima_wasiat_2', label: 'Nama Penerima Wasiat 2'),
  LetterVariable(key: 'hubungan_ahli_waris_2', label: 'Hubungan Ahli Waris 2'),
  LetterVariable(key: 'bagian_ahli_waris_2', label: 'Bagian Ahli Waris 2'),
  LetterVariable(key: 'nama_pelaksana_wasiat', label: 'Nama Pelaksana Wasiat'),
  LetterVariable(key: 'nama_saksi_1', label: 'Nama Saksi 1'),
  LetterVariable(key: 'nama_saksi_2', label: 'Nama Saksi 2'),
];

String suratWasiat(LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT WASIAT</b>
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
            <td style="white-space: nowrap">Status Perkawinan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.maritalStatus ?? ''}</td>
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
      Dalam keadaan sehat jasmani dan rohani, sadar sepenuhnya serta tanpa paksaan dari pihak manapun, dengan ini menyatakan wasiat saya sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 1 — Maksud dan Tujuan</b>
      <br>
      Surat wasiat ini saya buat untuk mengatur pembagian harta peninggalan saya kepada ahli waris/penerima wasiat apabila saya telah meninggal dunia, sesuai dengan ketentuan hukum yang berlaku di Negara Kesatuan Republik Indonesia.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 2 — Harta yang Diwasiatkan</b>
      <br>
      Adapun harta yang saya wasiatkan adalah sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      1. ${fillVar(vars, 'rincian_harta_1', '... (Rincian Harta 1, mis. Tanah seluas ... m² di alamat ...)')}
      <br>
      2. ${fillVar(vars, 'rincian_harta_2', '... (Rincian Harta 2, mis. Kendaraan/Tabungan/Saham)')}
      <br>
      3. ${fillVar(vars, 'rincian_harta_lainnya', '... (Rincian Harta Lainnya)')}
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 3 — Penerima Wasiat</b>
      <br>
      Saya menetapkan penerima wasiat sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama Penerima 1</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_penerima_wasiat_1', '... (Nama Penerima Wasiat 1)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hubungan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hubungan_ahli_waris_1', '... (Hubungan dengan Pewaris)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Bagian yang Diterima</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'bagian_ahli_waris_1', '... (Bagian/Persentase yang Diterima)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nama Penerima 2</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_penerima_wasiat_2', '... (Nama Penerima Wasiat 2)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hubungan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hubungan_ahli_waris_2', '... (Hubungan dengan Pewaris)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Bagian yang Diterima</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'bagian_ahli_waris_2', '... (Bagian/Persentase yang Diterima)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 4 — Pelaksana Wasiat</b>
      <br>
      Saya menunjuk ${fillVar(vars, 'nama_pelaksana_wasiat', '... (Nama Pelaksana Wasiat)')} sebagai pelaksana wasiat yang bertugas untuk menjalankan isi wasiat ini dengan adil dan sesuai dengan ketentuan yang berlaku.
    </p>
    <p style="text-align: justify; ">
      <b>Pasal 5 — Penutup</b>
      <br>
      Surat wasiat ini berlaku sejak saya meninggal dunia. Apabila terdapat hal yang belum diatur dalam surat wasiat ini, maka akan diselesaikan secara musyawarah dan/atau berdasarkan ketentuan hukum yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Demikian surat wasiat ini saya buat dengan sebenar-benarnya, dalam keadaan sehat jasmani dan rohani, sadar sepenuhnya, serta tanpa paksaan dari pihak manapun.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
            <br>
            <span style="white-space: nowrap">Pemberi Wasiat,</span>
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
