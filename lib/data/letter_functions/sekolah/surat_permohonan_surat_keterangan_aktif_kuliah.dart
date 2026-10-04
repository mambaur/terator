import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanSuratKeteranganAktifKuliahVariables =
    [
  LetterVariable(
      key: 'dekan_ketua_program_studi_bagian_akademik',
      label: 'Dekan/Ketua Program Studi/Bagian Akademik'),
  LetterVariable(
      key: 'semester_saat_ini',
      label: 'Semester Saat Ini',
      type: LetterVariableType.number),
  LetterVariable(key: 'tahun_akademik', label: 'Tahun Akademik'),
  LetterVariable(
      key: 'keperluan',
      label: 'Keperluan',
      hint:
          'mis. Pengajuan Beasiswa/Tunjangan Anak Pegawai/Pengurusan KIP/Pengajuan Pinjaman'),
];

String suratPermohonanSuratKeteranganAktifKuliah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Surat Keterangan Aktif Kuliah</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'dekan_ketua_program_studi_bagian_akademik', '... (Dekan/Ketua Program Studi/Bagian Akademik)')}
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
            <td style="white-space: nowrap">Semester</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'semester_saat_ini', '... (Semester Saat Ini)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tahun Akademik</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tahun_akademik', '... (Tahun Akademik)')}</td>
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
      Dengan ini bermaksud mengajukan permohonan kepada Bapak/Ibu untuk dapat diterbitkannya <b>Surat Keterangan Aktif Kuliah</b> atas nama saya. Surat tersebut akan saya gunakan untuk keperluan ${fillVar(vars, 'keperluan', '... (Keperluan, mis. Pengajuan Beasiswa/Tunjangan Anak Pegawai/Pengurusan KIP/Pengajuan Pinjaman)')}.
    </p>
    <p style="text-align: justify; ">
      Adapun saya menyatakan bahwa saat ini saya benar-benar masih aktif mengikuti perkuliahan di ${account?.educationInstitution ?? '... (Nama Kampus)'} dan tidak sedang dalam status cuti akademik maupun tidak aktif.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya bersedia untuk mengikuti seluruh prosedur administrasi yang berlaku, termasuk melampirkan dokumen pendukung yang diperlukan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya sampaikan. Atas perhatian dan kerja sama Bapak/Ibu, saya ucapkan terima kasih.
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
