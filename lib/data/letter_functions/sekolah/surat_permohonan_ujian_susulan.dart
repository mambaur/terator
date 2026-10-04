import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanUjianSusulanVariables = [
  LetterVariable(
      key: 'kepala_sekolah_wali_kelas_dosen_pengampu',
      label: 'Kepala Sekolah/Wali Kelas/Dosen Pengampu'),
  LetterVariable(
      key: 'jenis_ujian',
      label: 'Jenis Ujian',
      type: LetterVariableType.choice,
      options: ['UTS', 'UAS', 'Ujian Harian', 'Praktikum']),
  LetterVariable(
      key: 'nama_mata_pelajaran_kuliah', label: 'Nama Mata Pelajaran/Kuliah'),
  LetterVariable(
      key: 'tanggal_ujian_yang_terlewat',
      label: 'Tanggal Ujian yang Terlewat',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'alasan',
      label: 'Alasan',
      type: LetterVariableType.multiline,
      hint: 'mis. Sakit/Mengikuti Lomba/Acara Keluarga yang Mendesak'),
  LetterVariable(
      key: 'lampiran',
      label: 'Lampiran',
      hint: 'mis. Surat Keterangan Dokter/Surat Tugas'),
];

String suratPermohonanUjianSusulan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Mengikuti Ujian Susulan</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'kepala_sekolah_wali_kelas_dosen_pengampu', '... (Kepala Sekolah/Wali Kelas/Dosen Pengampu)')}
      <br>
      ${account?.educationInstitution ?? ''}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
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
            <td style="white-space: nowrap">NIS/NIM</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.educationNumber ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
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
      Dengan ini bermaksud mengajukan permohonan untuk dapat mengikuti <b>ujian susulan</b> dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Jenis Ujian</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jenis_ujian', '... (UTS/UAS/Ujian Harian/Praktikum)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Mata Pelajaran/Kuliah</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_mata_pelajaran_kuliah', '... (Nama Mata Pelajaran/Kuliah)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Ujian</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_ujian_yang_terlewat', '... (Tanggal Ujian yang Terlewat)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Adapun saya tidak dapat mengikuti ujian tersebut pada jadwal yang telah ditentukan dikarenakan ${fillVar(vars, 'alasan', '... (Alasan, mis. Sakit/Mengikuti Lomba/Acara Keluarga yang Mendesak)')}. Sebagai bukti, saya melampirkan dokumen pendukung berupa ${fillVar(vars, 'lampiran', '... (Lampiran, mis. Surat Keterangan Dokter/Surat Tugas)')}.
    </p>
    <p style="text-align: justify; ">
      Saya berkomitmen untuk mengikuti ujian susulan sesuai dengan jadwal yang akan ditetapkan oleh Bapak/Ibu.
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
              <br>
              <span style="white-space: nowrap">NIS/NIM. ${account?.educationNumber ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
