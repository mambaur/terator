import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanReimbursementBiaya(
    LetterModel? letter, String? img, AccountModel? account) {
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
      <b>... (Nama Pimpinan/HRD/Bagian Keuangan)</b>
      <br>
      <b>... (Nama Perusahaan)</b>
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
            <td style="width: 100%"><b>... (NIK/NIP Karyawan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jabatan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Jabatan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Divisi/Departemen</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Divisi/Departemen)</b></td>
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
            <td style="width: 100%"><b>... (Jenis Pengeluaran, mis. Transportasi/Akomodasi/Konsumsi/Medis)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Keperluan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Uraian Keperluan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Pengeluaran</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tanggal Pengeluaran)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Total Biaya</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>Rp ... (Total Biaya)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Terbilang</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Jumlah dalam Huruf) Rupiah</b></td>
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
            <td style="width: 100%"><b>... (Nama Bank)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Nomor Rekening</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nomor Rekening)</b></td>
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
