import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanSumbangan(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Nomor&nbsp;&nbsp;&nbsp;&nbsp;: <b>... (Nomor Surat)</b>
      <br>
      Lampiran&nbsp;: 1 (satu) berkas
      <br>
      Perihal&nbsp;&nbsp;&nbsp;: <b>Permohonan Sumbangan/Donasi</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Pimpinan/Donatur)</b>
      <br>
      <b>... (Nama Instansi/Perusahaan)</b>
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Puji syukur kami panjatkan kepada Tuhan Yang Maha Esa. Sehubungan dengan akan dilaksanakannya kegiatan <b>... (Nama Kegiatan)</b> yang akan diselenggarakan pada:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Hari, Tanggal)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Pukul)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Lokasi Kegiatan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Penyelenggara</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Penyelenggara/Panitia)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Maka dengan segala kerendahan hati, kami selaku panitia bermaksud memohon bantuan berupa sumbangan/donasi kepada Bapak/Ibu, guna kelancaran pelaksanaan kegiatan tersebut. Adapun bentuk sumbangan dapat berupa:
    </p>
    <p style="text-align: justify; ">
      1. Sumbangan dana sebesar <b>Rp ... (Nominal yang Dibutuhkan)</b>;
      <br>
      2. Sumbangan barang/konsumsi/perlengkapan kegiatan;
      <br>
      3. Bentuk dukungan lain yang sesuai dengan kebijakan Bapak/Ibu.
    </p>
    <p style="text-align: justify; ">
      Apabila Bapak/Ibu berkenan menyalurkan sumbangan, dapat melalui rekening atas nama <b>... (Nama Bendahara)</b>, Bank <b>... (Nama Bank)</b>, Nomor Rekening <b>... (Nomor Rekening)</b>, atau dapat diserahkan secara langsung kepada panitia.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, kami melampirkan proposal kegiatan beserta rincian anggaran. Setiap bentuk bantuan yang Bapak/Ibu berikan akan kami kelola dengan penuh tanggung jawab dan kami laporkan setelah kegiatan selesai.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini kami sampaikan. Atas perhatian dan kemurahan hati Bapak/Ibu, kami ucapkan terima kasih.
    </p>
    <p><br></p>
    <table>
      <tbody>
        <tr>
          <td style="width: 100%">&nbsp;</td>
          <td style="vertical-align:top;text-align:center;">
            <span style="white-space: nowrap">Hormat kami,</span>
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
              <span style="white-space: nowrap"><b>... (Jabatan, mis. Ketua Panitia)</b></span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
