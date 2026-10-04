import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanPerpanjanganKontrakKerjaVariables = [
  LetterVariable(key: 'nama_pimpinan_hrd', label: 'Nama Pimpinan/HRD'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nik_nip_karyawan', label: 'NIK/NIP Karyawan'),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'divisi_departemen', label: 'Divisi/Departemen'),
  LetterVariable(key: 'nomor_kontrak_kerja', label: 'Nomor Kontrak Kerja'),
  LetterVariable(
      key: 'tanggal_berakhir_kontrak',
      label: 'Tanggal Berakhir Kontrak',
      type: LetterVariableType.date),
];

String suratPermohonanPerpanjanganKontrakKerja(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Perpanjangan Kontrak Kerja</b>
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
            <td style="white-space: nowrap">Nomor Kontrak</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_kontrak_kerja', '... (Nomor Kontrak Kerja)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Masa Kontrak Berakhir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_berakhir_kontrak', '... (Tanggal Berakhir Kontrak)')}</td>
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
      Sehubungan dengan akan berakhirnya masa kontrak kerja saya pada tanggal ${fillVar(vars, 'tanggal_berakhir_kontrak', '... (Tanggal Berakhir Kontrak)')}, melalui surat ini saya bermaksud mengajukan permohonan perpanjangan kontrak kerja di ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}.
    </p>
    <p style="text-align: justify; ">
      Selama menjalankan kontrak kerja yang lalu, saya telah berupaya melaksanakan tugas dan tanggung jawab dengan sebaik-baiknya, serta mematuhi seluruh peraturan yang berlaku di perusahaan. Saya juga merasa cocok dengan lingkungan kerja dan ingin terus berkontribusi bagi kemajuan perusahaan.
    </p>
    <p style="text-align: justify; ">
      Apabila permohonan ini dikabulkan, saya bersedia untuk melanjutkan kontrak kerja sesuai dengan ketentuan dan kebijakan yang ditetapkan oleh perusahaan.
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
