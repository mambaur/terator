import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanAktifKembaliKuliahVariables = [
  LetterVariable(
      key: 'dekan_ketua_program_studi', label: 'Dekan/Ketua Program Studi'),
  LetterVariable(key: 'nomor_surat_cuti', label: 'Nomor Surat Cuti'),
  LetterVariable(
      key: 'tanggal_surat_cuti',
      label: 'Tanggal Surat Cuti',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'semester',
      label: 'Semester',
      type: LetterVariableType.choice,
      options: ['Ganjil', 'Genap']),
  LetterVariable(key: 'tahun_akademik', label: 'Tahun Akademik'),
  LetterVariable(
      key: 'lampiran',
      label: 'Lampiran',
      hint: 'mis. Salinan Surat Cuti Akademik/Bukti Pembayaran SPP'),
];

String suratPermohonanAktifKembaliKuliah(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Aktif Kembali Kuliah</b>
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
      Sehubungan dengan telah berakhirnya masa cuti akademik saya sesuai Surat Cuti Akademik Nomor ${fillVar(vars, 'nomor_surat_cuti', '... (Nomor Surat Cuti)')} tanggal ${fillVar(vars, 'tanggal_surat_cuti', '... (Tanggal Surat Cuti)')}, melalui surat ini saya bermaksud mengajukan permohonan untuk dapat <b>aktif kembali</b> sebagai mahasiswa pada ${fillVar(vars, 'semester', 'Semester ... (Ganjil/Genap)', prefix: 'Semester ')} ${fillVar(vars, 'tahun_akademik', 'Tahun Akademik ... (Tahun Akademik)', prefix: 'Tahun Akademik ')}.
    </p>
    <p style="text-align: justify; ">
      Saya menyatakan dalam keadaan sehat jasmani dan rohani serta siap untuk melanjutkan studi dengan penuh tanggung jawab. Saya juga bersedia memenuhi seluruh kewajiban administratif maupun akademik yang berlaku.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya melampirkan dokumen pendukung berupa ${fillVar(vars, 'lampiran', '... (Lampiran, mis. Salinan Surat Cuti Akademik/Bukti Pembayaran SPP)')}.
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
