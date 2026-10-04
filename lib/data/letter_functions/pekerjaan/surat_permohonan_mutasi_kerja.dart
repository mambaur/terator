import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanMutasiKerjaVariables = [
  LetterVariable(key: 'nama_pimpinan_hrd', label: 'Nama Pimpinan/HRD'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nik_nip_karyawan', label: 'NIK/NIP Karyawan'),
  LetterVariable(key: 'jabatan_saat_ini', label: 'Jabatan Saat Ini'),
  LetterVariable(
      key: 'divisi_departemen_saat_ini', label: 'Divisi/Departemen Saat Ini'),
  LetterVariable(
      key: 'cabang_lokasi_saat_ini', label: 'Cabang/Lokasi Saat Ini'),
  LetterVariable(
      key: 'tanggal_mulai_bekerja',
      label: 'Tanggal Mulai Bekerja',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'cabang_divisi_saat_ini', label: 'Cabang/Divisi Saat Ini'),
  LetterVariable(key: 'cabang_divisi_tujuan', label: 'Cabang/Divisi Tujuan'),
  LetterVariable(key: 'lokasi_tujuan', label: 'Lokasi Tujuan'),
  LetterVariable(
      key: 'tanggal_efektif_mutasi',
      label: 'Tanggal Efektif Mutasi',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'alasan_mutasi',
      label: 'Alasan Mutasi',
      type: LetterVariableType.multiline,
      hint: 'mis. Mendekati Keluarga/Kesehatan/Pengembangan Karier'),
];

String suratPermohonanMutasiKerja(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Mutasi Kerja</b>
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
            <td style="white-space: nowrap">NIK/NIP Karyawan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nik_nip_karyawan', '... (NIK/NIP Karyawan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jabatan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jabatan_saat_ini', '... (Jabatan Saat Ini)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Divisi/Departemen</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'divisi_departemen_saat_ini', '... (Divisi/Departemen Saat Ini)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Cabang/Lokasi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'cabang_lokasi_saat_ini', '... (Cabang/Lokasi Saat Ini)')}</td>
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
      Dengan ini bermaksud mengajukan permohonan mutasi kerja dari ${fillVar(vars, 'cabang_divisi_saat_ini', '... (Cabang/Divisi Saat Ini)')} ke ${fillVar(vars, 'cabang_divisi_tujuan', '... (Cabang/Divisi Tujuan)')} yang berlokasi di ${fillVar(vars, 'lokasi_tujuan', '... (Lokasi Tujuan)')}, terhitung sejak tanggal ${fillVar(vars, 'tanggal_efektif_mutasi', '... (Tanggal Efektif Mutasi)')}.
    </p>
    <p style="text-align: justify; ">
      Adapun alasan permohonan mutasi ini adalah ${fillVar(vars, 'alasan_mutasi', '... (Alasan Mutasi, mis. Mendekati Keluarga/Kesehatan/Pengembangan Karier)')}.
    </p>
    <p style="text-align: justify; ">
      Saya berkomitmen untuk tetap memberikan kinerja terbaik di lokasi/divisi tujuan dan bersedia mengikuti seluruh ketentuan yang berlaku di tempat baru. Saya juga bersedia menyelesaikan seluruh tanggung jawab di unit kerja saat ini sebelum dimutasi.
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
