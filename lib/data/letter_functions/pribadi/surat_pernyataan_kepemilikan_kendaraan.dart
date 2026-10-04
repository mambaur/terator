import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPernyataanKepemilikanKendaraanVariables = [
  LetterVariable(key: 'pekerjaan', label: 'Pekerjaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(
      key: 'merk_dan_tipe_kendaraan', label: 'Merk dan Tipe Kendaraan'),
  LetterVariable(
      key: 'jenis_kendaraan',
      label: 'Jenis Kendaraan',
      type: LetterVariableType.choice,
      options: ['Mobil', 'Motor']),
  LetterVariable(
      key: 'tahun_pembuatan',
      label: 'Tahun Pembuatan',
      type: LetterVariableType.number),
  LetterVariable(key: 'warna_kendaraan', label: 'Warna Kendaraan'),
  LetterVariable(key: 'nomor_polisi', label: 'Nomor Polisi'),
  LetterVariable(key: 'nomor_rangka', label: 'Nomor Rangka'),
  LetterVariable(key: 'nomor_mesin', label: 'Nomor Mesin'),
  LetterVariable(key: 'nomor_bpkb', label: 'Nomor BPKB'),
];

String suratPernyataanKepemilikanKendaraan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: center;">
      <b>SURAT PERNYATAAN KEPEMILIKAN KENDARAAN BERMOTOR</b>
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
          <tr>
            <td style="white-space: nowrap">No. Telp</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.telephone ?? ''}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Dengan ini menyatakan dengan sesungguhnya bahwa saya adalah pemilik sah atas kendaraan bermotor dengan data sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Merk / Tipe</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'merk_dan_tipe_kendaraan', '... (Merk dan Tipe Kendaraan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jenis Kendaraan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jenis_kendaraan', '... (Mobil/Motor)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tahun Pembuatan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tahun_pembuatan', '... (Tahun)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Warna</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'warna_kendaraan', '... (Warna Kendaraan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Polisi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_polisi', '... (Nomor Polisi)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Rangka</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_rangka', '... (Nomor Rangka)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Mesin</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_mesin', '... (Nomor Mesin)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. BPKB</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_bpkb', '... (Nomor BPKB)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Kendaraan tersebut benar-benar merupakan milik pribadi saya, bukan hasil dari tindak pidana, tidak sedang dalam status sengketa, tidak sedang dijaminkan kepada pihak manapun, serta diperoleh dengan cara yang sah menurut hukum.
    </p>
    <p style="text-align: justify; ">
      Apabila di kemudian hari pernyataan ini terbukti tidak benar, maka saya bersedia mempertanggungjawabkan sepenuhnya secara hukum tanpa melibatkan pihak lain.
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
