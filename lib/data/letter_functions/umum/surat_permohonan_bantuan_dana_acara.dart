import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPermohonanBantuanDanaAcara(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Nomor&nbsp;&nbsp;&nbsp;&nbsp;: <b>... (Nomor Surat)</b>
      <br>
      Lampiran&nbsp;: 1 (satu) berkas proposal
      <br>
      Perihal&nbsp;&nbsp;&nbsp;: <b>Permohonan Bantuan Dana Acara</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Pimpinan/Sponsor)</b>
      <br>
      <b>... (Nama Instansi/Perusahaan)</b>
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Sehubungan dengan akan diselenggarakannya kegiatan <b>... (Nama Acara)</b> oleh <b>... (Nama Penyelenggara/Organisasi)</b>, dengan ini kami selaku panitia bermaksud mengajukan permohonan bantuan dana guna mendukung kelancaran pelaksanaan kegiatan tersebut.
    </p>
    <p style="text-align: justify; ">
      Adapun rincian kegiatan adalah sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Nama Acara</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Nama Acara)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tema Acara</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tema Acara)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Hari, Tanggal Pelaksanaan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Pukul)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tempat Pelaksanaan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Target Peserta</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Jumlah Target Peserta)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Total Anggaran</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>Rp ... (Total Anggaran)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Dana yang Dimohon</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>Rp ... (Nominal Bantuan yang Dimohon)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Sebagai timbal balik atas dukungan yang Bapak/Ibu berikan, kami akan mencantumkan logo serta nama instansi/perusahaan Bapak/Ibu sebagai sponsor pada seluruh materi publikasi acara, termasuk spanduk, brosur, media sosial, dan sertifikat peserta.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, kami melampirkan proposal lengkap yang memuat rincian acara, susunan panitia, anggaran biaya, serta paket sponsorship yang ditawarkan.
    </p>
    <p style="text-align: justify; ">
      Demikian surat permohonan ini kami sampaikan. Besar harapan kami atas bantuan dan dukungan Bapak/Ibu demi suksesnya kegiatan ini. Atas perhatian dan kerja samanya, kami ucapkan terima kasih.
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
