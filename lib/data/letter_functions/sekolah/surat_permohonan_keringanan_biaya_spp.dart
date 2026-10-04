import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanKeringananBiayaSppVariables = [
  LetterVariable(
      key: 'kepala_sekolah_rektor_dekan', label: 'Kepala Sekolah/Rektor/Dekan'),
  LetterVariable(
      key: 'pekerjaan_orang_tua_wali', label: 'Pekerjaan Orang Tua/Wali'),
  LetterVariable(
      key: 'penghasilan_per_bulan',
      label: 'Penghasilan per Bulan',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'semester',
      label: 'Semester',
      type: LetterVariableType.choice,
      options: ['Ganjil', 'Genap']),
  LetterVariable(key: 'tahun_ajaran', label: 'Tahun Ajaran'),
  LetterVariable(
      key: 'nominal_spp_saat_ini',
      label: 'Nominal SPP Saat Ini',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'nominal_yang_diharapkan',
      label: 'Nominal yang Diharapkan',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'alasan',
      label: 'Alasan',
      type: LetterVariableType.multiline,
      hint:
          'mis. PHK/Penurunan Penghasilan/Sakit/Tanggungan Keluarga yang Banyak'),
];

String suratPermohonanKeringananBiayaSpp(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Keringanan Biaya SPP</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'kepala_sekolah_rektor_dekan', '... (Kepala Sekolah/Rektor/Dekan)')}
      <br>
      ${account?.educationInstitution ?? ''}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Saya yang bertanda tangan di bawah ini, selaku orang tua/wali dari:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama Siswa/Mahasiswa</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.name ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">NIS/NIM</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationNumber ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Kelas/Semester</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationClass ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jurusan/Prodi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationStudyProgram ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Sekolah/Kampus</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationInstitution ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nama Orang Tua/Wali</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.parentName ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Pekerjaan Orang Tua</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'pekerjaan_orang_tua_wali', '... (Pekerjaan Orang Tua/Wali)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Penghasilan Orang Tua</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'penghasilan_per_bulan', 'Rp ... (Penghasilan per Bulan)', prefix: 'Rp ')}</td>
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
      Dengan ini mengajukan permohonan keringanan biaya SPP/UKT untuk ${fillVar(vars, 'semester', 'Semester ... (Ganjil/Genap)', prefix: 'Semester ')} ${fillVar(vars, 'tahun_ajaran', 'Tahun Ajaran ... (Tahun Ajaran)', prefix: 'Tahun Ajaran ')}. Adapun besaran SPP/UKT yang saat ini ditetapkan adalah ${fillVar(vars, 'nominal_spp_saat_ini', 'Rp ... (Nominal SPP Saat Ini)', prefix: 'Rp ')}, dan saya memohon dengan hormat agar dapat diberikan keringanan menjadi ${fillVar(vars, 'nominal_yang_diharapkan', 'Rp ... (Nominal yang Diharapkan)', prefix: 'Rp ')}.
    </p>
    <p style="text-align: justify; ">
      Permohonan ini saya ajukan dikarenakan kondisi ekonomi keluarga yang saat ini kurang memungkinkan, antara lain dengan alasan ${fillVar(vars, 'alasan', '... (Alasan, mis. PHK/Penurunan Penghasilan/Sakit/Tanggungan Keluarga yang Banyak)')}.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya melampirkan dokumen pendukung berupa Surat Keterangan Tidak Mampu dari Kelurahan, slip gaji/keterangan penghasilan, serta Kartu Keluarga.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya sampaikan. Atas perhatian dan kebijaksanaan Bapak/Ibu, saya ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat saya,</span>
            <br>
            <span style="white-space: nowrap">Orang Tua/Wali,</span>
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
              <span style="white-space: nowrap">( ${account?.parentName ?? ''} )</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
