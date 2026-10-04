import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanKenaikanJabatanVariables = [
  LetterVariable(key: 'nama_pimpinan_hrd', label: 'Nama Pimpinan/HRD'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nik_nip_karyawan', label: 'NIK/NIP Karyawan'),
  LetterVariable(key: 'jabatan_saat_ini', label: 'Jabatan Saat Ini'),
  LetterVariable(key: 'divisi_departemen', label: 'Divisi/Departemen'),
  LetterVariable(
      key: 'tanggal_mulai_bekerja',
      label: 'Tanggal Mulai Bekerja',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'jabatan_yang_diharapkan', label: 'Jabatan yang Diharapkan'),
  LetterVariable(key: 'pencapaian_prestasi_1', label: 'Pencapaian/Prestasi 1'),
  LetterVariable(key: 'pencapaian_prestasi_2', label: 'Pencapaian/Prestasi 2'),
  LetterVariable(key: 'pencapaian_prestasi_3', label: 'Pencapaian/Prestasi 3'),
];

String suratPermohonanKenaikanJabatan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Kenaikan Jabatan</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_hrd', '... (Nama Pimpinan/HRD)')}
      <br>
      ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}
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
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Pendidikan Terakhir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.lastEducation ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">NIK/NIP Karyawan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nik_nip_karyawan', '... (NIK/NIP Karyawan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jabatan Saat Ini</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jabatan_saat_ini', '... (Jabatan Saat Ini)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Divisi/Departemen</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'divisi_departemen', '... (Divisi/Departemen)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Mulai Bekerja</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_mulai_bekerja', '... (Tanggal Mulai Bekerja)')}</td>
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
      Melalui surat ini, dengan segala kerendahan hati saya bermaksud mengajukan permohonan kenaikan jabatan dari ${fillVar(vars, 'jabatan_saat_ini', '... (Jabatan Saat Ini)')} menjadi ${fillVar(vars, 'jabatan_yang_diharapkan', '... (Jabatan yang Diharapkan)')} di ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}.
    </p>
    <p style="text-align: justify; ">
      Selama bekerja, saya telah berupaya menunjukkan kinerja dan dedikasi terbaik, antara lain melalui pencapaian sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      1. ${fillVar(vars, 'pencapaian_prestasi_1', '... (Pencapaian/Prestasi 1)')}
      <br>
      2. ${fillVar(vars, 'pencapaian_prestasi_2', '... (Pencapaian/Prestasi 2)')}
      <br>
      3. ${fillVar(vars, 'pencapaian_prestasi_3', '... (Pencapaian/Prestasi 3)')}
    </p>
    <p style="text-align: justify; ">
      Saya berkomitmen untuk terus meningkatkan kinerja serta memberikan kontribusi yang lebih besar bagi kemajuan perusahaan. Sebagai bahan pertimbangan, saya lampirkan dokumen pendukung yang relevan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya sampaikan. Atas perhatian dan kebijaksanaan Bapak/Ibu Pimpinan, saya ucapkan terima kasih.
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
