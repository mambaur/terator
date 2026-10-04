import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanCutiMelahirkanVariables = [
  LetterVariable(key: 'nama_pimpinan_hrd', label: 'Nama Pimpinan/HRD'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nik_nip_karyawan', label: 'NIK/NIP Karyawan'),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'divisi_departemen', label: 'Divisi/Departemen'),
  LetterVariable(
      key: 'perkiraan_tanggal_persalinan',
      label: 'Perkiraan Tanggal Persalinan',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'tanggal_mulai_cuti',
      label: 'Tanggal Mulai Cuti',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'tanggal_selesai_cuti',
      label: 'Tanggal Selesai Cuti',
      type: LetterVariableType.date),
  LetterVariable(key: 'lama_cuti', label: 'Lama Cuti', hint: 'mis. 3 bulan'),
  LetterVariable(
      key: 'nama_rekan_kerja_pengganti', label: 'Nama Rekan Kerja Pengganti'),
];

String suratPermohonanCutiMelahirkan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Cuti Melahirkan</b>
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
            <td style="white-space: nowrap">NIK/NIP Karyawan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nik_nip_karyawan', '... (NIK/NIP Karyawan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jabatan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jabatan', '... (Jabatan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Divisi/Departemen</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'divisi_departemen', '... (Divisi/Departemen)')}</td>
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
      Bersama surat ini, saya bermaksud mengajukan permohonan cuti melahirkan sesuai dengan ketentuan yang berlaku di perusahaan dan Undang-Undang Ketenagakerjaan. Adapun rincian cuti yang saya ajukan adalah sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Perkiraan Tanggal Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'perkiraan_tanggal_persalinan', '... (Perkiraan Tanggal Persalinan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Mulai Cuti</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_mulai_cuti', '... (Tanggal Mulai Cuti)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Selesai Cuti</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_selesai_cuti', '... (Tanggal Selesai Cuti)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Lama Cuti</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'lama_cuti', '... (Lama Cuti, mis. 3 bulan)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Selama saya menjalani cuti, seluruh tugas dan tanggung jawab pekerjaan akan saya delegasikan kepada ${fillVar(vars, 'nama_rekan_kerja_pengganti', '... (Nama Rekan Kerja Pengganti)')} dengan persetujuan atasan langsung. Sebagai bahan pertimbangan, saya melampirkan surat keterangan dari dokter sebagai berikut.
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
