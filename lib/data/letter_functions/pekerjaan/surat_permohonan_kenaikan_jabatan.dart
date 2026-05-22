import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanKenaikanJabatan(
    LetterModel? letter, String? img, AccountModel? account) {
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
            <td style="white-space: nowrap">Pendidikan Terakhir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.lastEducation ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">NIK/NIP Karyawan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (NIK/NIP Karyawan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Jabatan Saat Ini</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Jabatan Saat Ini)</b></td>
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
      Melalui surat ini, dengan segala kerendahan hati saya bermaksud mengajukan permohonan kenaikan jabatan dari <b>... (Jabatan Saat Ini)</b> menjadi <b>... (Jabatan yang Diharapkan)</b> di <b>... (Nama Perusahaan)</b>.
    </p>
    <p style="text-align: justify; ">
      Selama bekerja, saya telah berupaya menunjukkan kinerja dan dedikasi terbaik, antara lain melalui pencapaian sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      1. <b>... (Pencapaian/Prestasi 1)</b>
      <br>
      2. <b>... (Pencapaian/Prestasi 2)</b>
      <br>
      3. <b>... (Pencapaian/Prestasi 3)</b>
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
