import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanPindahJurusanVariables = [
  LetterVariable(
      key: 'dekan_wakil_dekan_bidang_akademik',
      label: 'Dekan/Wakil Dekan Bidang Akademik'),
  LetterVariable(
      key: 'semester_saat_ini',
      label: 'Semester Saat Ini',
      type: LetterVariableType.number),
  LetterVariable(key: 'jurusan_prodi_tujuan', label: 'Jurusan/Prodi Tujuan'),
  LetterVariable(
      key: 'semester',
      label: 'Semester',
      type: LetterVariableType.choice,
      options: ['Ganjil', 'Genap']),
  LetterVariable(key: 'tahun_akademik', label: 'Tahun Akademik'),
  LetterVariable(
      key: 'alasan',
      label: 'Alasan',
      type: LetterVariableType.multiline,
      hint: 'mis. Minat/Bakat/Prospek Karier/Kesesuaian Cita-cita'),
];

String suratPermohonanPindahJurusan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Pindah Jurusan</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'dekan_wakil_dekan_bidang_akademik', '... (Dekan/Wakil Dekan Bidang Akademik)')}
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
            <td style="white-space: nowrap">Jurusan/Prodi Asal</td>
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
      Dengan ini bermaksud mengajukan permohonan pindah jurusan/program studi dari <b>${account?.educationStudyProgram ?? '... (Jurusan/Prodi Asal)'}</b> ke ${fillVar(vars, 'jurusan_prodi_tujuan', '... (Jurusan/Prodi Tujuan)')} di lingkungan ${account?.educationInstitution ?? '... (Nama Kampus)'}, terhitung mulai ${fillVar(vars, 'semester', 'Semester ... (Ganjil/Genap)', prefix: 'Semester ')} ${fillVar(vars, 'tahun_akademik', 'Tahun Akademik ... (Tahun Akademik)', prefix: 'Tahun Akademik ')}.
    </p>
    <p style="text-align: justify; ">
      Adapun alasan saya mengajukan permohonan ini adalah ${fillVar(vars, 'alasan', '... (Alasan, mis. Minat/Bakat/Prospek Karier/Kesesuaian Cita-cita)')}.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya bersedia mengikuti seluruh prosedur, persyaratan akademik, serta tes yang ditetapkan oleh fakultas/jurusan tujuan. Saya juga melampirkan dokumen pendukung sebagai berikut: transkrip nilai, kartu hasil studi (KHS), serta surat persetujuan orang tua.
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
