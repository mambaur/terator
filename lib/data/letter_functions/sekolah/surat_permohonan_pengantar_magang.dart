import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanPengantarMagangVariables = [
  LetterVariable(
      key: 'kepala_sekolah_dekan_ketua_program_studi',
      label: 'Kepala Sekolah/Dekan/Ketua Program Studi'),
  LetterVariable(
      key: 'nama_instansi_perusahaan_tujuan',
      label: 'Nama Instansi/Perusahaan Tujuan'),
  LetterVariable(
      key: 'alamat_lengkap_instansi',
      label: 'Alamat Lengkap Instansi',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'bidang_divisi_magang', label: 'Bidang/Divisi Magang'),
  LetterVariable(
      key: 'tanggal_mulai_s_d_selesai', label: 'Tanggal Mulai s/d Selesai'),
];

String suratPermohonanPengantarMagang(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Surat Pengantar Magang/PKL</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'kepala_sekolah_dekan_ketua_program_studi', '... (Kepala Sekolah/Dekan/Ketua Program Studi)')}
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
      Dalam rangka memenuhi kurikulum dan menambah pengalaman praktik kerja, dengan ini saya bermaksud mengajukan permohonan penerbitan <b>Surat Pengantar Magang/Praktik Kerja Lapangan (PKL)</b> yang ditujukan kepada:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama Instansi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_instansi_perusahaan_tujuan', '... (Nama Instansi/Perusahaan Tujuan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat Instansi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_lengkap_instansi', '... (Alamat Lengkap Instansi)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Bidang Magang</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'bidang_divisi_magang', '... (Bidang/Divisi Magang)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Periode Magang</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_mulai_s_d_selesai', '... (Tanggal Mulai s/d Selesai)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Saya berkomitmen untuk menjaga nama baik sekolah/kampus selama melaksanakan kegiatan magang/PKL serta mematuhi seluruh peraturan yang berlaku, baik di tempat magang maupun di sekolah/kampus.
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
