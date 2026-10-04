import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanPengantarPenelitianVariables = [
  LetterVariable(
      key: 'dekan_ketua_program_studi', label: 'Dekan/Ketua Program Studi'),
  LetterVariable(
      key: 'semester_saat_ini',
      label: 'Semester Saat Ini',
      type: LetterVariableType.number),
  LetterVariable(key: 'judul_penelitian', label: 'Judul Penelitian'),
  LetterVariable(
      key: 'nama_instansi_lokasi_penelitian',
      label: 'Nama Instansi/Lokasi Penelitian'),
  LetterVariable(
      key: 'alamat_lengkap_lokasi',
      label: 'Alamat Lengkap Lokasi',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'tanggal_mulai_s_d_selesai', label: 'Tanggal Mulai s/d Selesai'),
  LetterVariable(key: 'nama_dosen_pembimbing', label: 'Nama Dosen Pembimbing'),
];

String suratPermohonanPengantarPenelitian(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Surat Pengantar Penelitian</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'dekan_ketua_program_studi', '... (Dekan/Ketua Program Studi)')}
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
      Dalam rangka menyelesaikan tugas akhir/skripsi/tesis, dengan ini saya bermaksud mengajukan permohonan penerbitan <b>Surat Pengantar Penelitian</b> yang akan saya gunakan untuk melakukan penelitian di:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Judul Penelitian</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'judul_penelitian', '... (Judul Penelitian)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat Penelitian</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_instansi_lokasi_penelitian', '... (Nama Instansi/Lokasi Penelitian)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat Lokasi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_lengkap_lokasi', '... (Alamat Lengkap Lokasi)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Pelaksanaan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_mulai_s_d_selesai', '... (Tanggal Mulai s/d Selesai)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Dosen Pembimbing</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_dosen_pembimbing', '... (Nama Dosen Pembimbing)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya melampirkan proposal penelitian beserta dokumen pendukung lainnya.
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
