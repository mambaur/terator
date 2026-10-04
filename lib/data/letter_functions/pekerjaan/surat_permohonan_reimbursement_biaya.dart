import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanReimbursementBiayaVariables = [
  LetterVariable(
      key: 'nama_pimpinan_hrd_bagian_keuangan',
      label: 'Nama Pimpinan/HRD/Bagian Keuangan'),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'nik_nip_karyawan', label: 'NIK/NIP Karyawan'),
  LetterVariable(key: 'jabatan', label: 'Jabatan'),
  LetterVariable(key: 'divisi_departemen', label: 'Divisi/Departemen'),
  LetterVariable(
      key: 'jenis_pengeluaran',
      label: 'Jenis Pengeluaran',
      hint: 'mis. Transportasi/Akomodasi/Konsumsi/Medis'),
  LetterVariable(
      key: 'uraian_keperluan',
      label: 'Uraian Keperluan',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'tanggal_pengeluaran',
      label: 'Tanggal Pengeluaran',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'total_biaya',
      label: 'Total Biaya',
      type: LetterVariableType.currency),
  LetterVariable(key: 'jumlah_dalam_huruf', label: 'Jumlah dalam Huruf'),
  LetterVariable(key: 'nama_bank', label: 'Nama Bank'),
  LetterVariable(key: 'nomor_rekening', label: 'Nomor Rekening'),
];

String suratPermohonanReimbursementBiaya(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Reimbursement Biaya</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_hrd_bagian_keuangan', '... (Nama Pimpinan/HRD/Bagian Keuangan)')}
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
            <td style="width: 100%">${fillVar(vars, 'jabatan', '... (Jabatan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Divisi/Departemen</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'divisi_departemen', '... (Divisi/Departemen)')}</td>
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
      Melalui surat ini, saya mengajukan permohonan penggantian biaya (<i>reimbursement</i>) atas pengeluaran yang telah saya keluarkan untuk keperluan dinas/pekerjaan dengan rincian sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Jenis Pengeluaran</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jenis_pengeluaran', '... (Jenis Pengeluaran, mis. Transportasi/Akomodasi/Konsumsi/Medis)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Keperluan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'uraian_keperluan', '... (Uraian Keperluan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Pengeluaran</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_pengeluaran', '... (Tanggal Pengeluaran)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Total Biaya</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'total_biaya', 'Rp ... (Total Biaya)', prefix: 'Rp ')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Terbilang</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jumlah_dalam_huruf', '... (Jumlah dalam Huruf) Rupiah', suffix: ' Rupiah')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bukti pendukung, saya melampirkan bukti pembayaran/kuitansi asli yang berkaitan dengan pengeluaran tersebut. Adapun penggantian biaya dapat ditransfer ke rekening saya sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama Bank</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_bank', '... (Nama Bank)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nomor Rekening</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_rekening', '... (Nomor Rekening)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Atas Nama</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.name ?? ''}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya sampaikan. Atas perhatian dan kerja samanya, saya ucapkan terima kasih.
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
