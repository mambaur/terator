import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanDispensasiVariables = [
  LetterVariable(
      key: 'kepala_sekolah_wali_kelas_dosen',
      label: 'Kepala Sekolah/Wali Kelas/Dosen'),
  LetterVariable(
      key: 'jenis_dispensasi',
      label: 'Jenis Dispensasi',
      hint:
          'mis. Tidak Mengikuti Pelajaran/Meninggalkan Kelas Lebih Awal/Datang Terlambat'),
  LetterVariable(
      key: 'hari_tanggal',
      label: 'Hari, Tanggal',
      type: LetterVariableType.dateWithDay),
  LetterVariable(
      key: 'waktu', label: 'Waktu', hint: 'mis. Pukul 09.00 - 12.00 WIB'),
  LetterVariable(
      key: 'mata_pelajaran_mata_kuliah', label: 'Mata Pelajaran/Mata Kuliah'),
  LetterVariable(
      key: 'alasan',
      label: 'Alasan',
      type: LetterVariableType.multiline,
      hint:
          'mis. Mengikuti Lomba/Acara Keluarga/Kegiatan Organisasi/Pemeriksaan Kesehatan'),
];

String suratPermohonanDispensasi(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Dispensasi</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'kepala_sekolah_wali_kelas_dosen', '... (Kepala Sekolah/Wali Kelas/Dosen)')}
      <br>
      ${account?.educationInstitution ?? ''}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Saya selaku orang tua/wali dari siswa/mahasiswa di bawah ini:
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
            <td style="white-space: nowrap">Sekolah/Kampus</td>
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
      Dengan ini bermaksud mengajukan permohonan dispensasi ${fillVar(vars, 'jenis_dispensasi', '... (Jenis Dispensasi, mis. Tidak Mengikuti Pelajaran/Meninggalkan Kelas Lebih Awal/Datang Terlambat)')} pada:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hari_tanggal', '... (Hari, Tanggal)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'waktu', '... (Waktu, mis. Pukul 09.00 - 12.00 WIB)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Mata Pelajaran/Kuliah</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'mata_pelajaran_mata_kuliah', '... (Mata Pelajaran/Mata Kuliah)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Adapun alasan permohonan dispensasi ini adalah ${fillVar(vars, 'alasan', '... (Alasan, mis. Mengikuti Lomba/Acara Keluarga/Kegiatan Organisasi/Pemeriksaan Kesehatan)')}.
    </p>
    <p style="text-align: justify; ">
      Saya berkomitmen untuk tetap mengejar ketertinggalan materi pelajaran/kuliah selama tidak mengikuti kegiatan tersebut.
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
