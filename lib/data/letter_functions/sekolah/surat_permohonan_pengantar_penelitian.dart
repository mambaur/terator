import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanPengantarPenelitian(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Permohonan Surat Pengantar Penelitian</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Dekan/Ketua Program Studi)</b>
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
            <td style="white-space: nowrap">Semester</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Semester Saat Ini)</b></td>
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
      Dalam rangka menyelesaikan tugas akhir/skripsi/tesis, dengan ini saya bermaksud mengajukan permohonan penerbitan <b>Surat Pengantar Penelitian</b> yang akan saya gunakan untuk melakukan penelitian di:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Judul Penelitian</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Judul Penelitian)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat Penelitian</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Instansi/Lokasi Penelitian)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Alamat Lokasi</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Alamat Lengkap Lokasi)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tanggal Pelaksanaan</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tanggal Mulai s/d Selesai)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Dosen Pembimbing</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Dosen Pembimbing)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya melampirkan proposal penelitian beserta dokumen pendukung lainnya.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini saya sampaikan. Atas perhatian dan kerja sama Bapak/Ibu, saya ucapkan terima kasih.
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
