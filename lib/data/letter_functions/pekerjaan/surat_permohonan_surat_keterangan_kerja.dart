import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanSuratKeteranganKerja(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Surat Keterangan Kerja</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Pimpinan/HRD)</b>
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
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
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
            <td style="white-space: nowrap">Mulai Bekerja</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tanggal Mulai Bekerja)</b></td>
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
      Dengan ini bermaksud mengajukan permohonan kepada Bapak/Ibu untuk dapat diterbitkannya <b>Surat Keterangan Kerja</b> atas nama saya. Surat tersebut akan saya gunakan untuk keperluan <b>... (Keperluan, mis. Pengajuan KPR/Pinjaman/Pembuatan Visa/Pendaftaran Sekolah Anak)</b>.
    </p>
    <p style="text-align: justify; ">
      Adapun informasi yang saya harapkan dapat dicantumkan dalam surat tersebut antara lain adalah identitas, jabatan, masa kerja, serta status kepegawaian saya di <b>... (Nama Perusahaan)</b>.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya bersedia untuk mengikuti seluruh prosedur administrasi yang berlaku di perusahaan dalam proses penerbitan surat tersebut.
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
