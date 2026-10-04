import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanBantuanDanaAcaraVariables = [
  LetterVariable(key: 'nomor_surat', label: 'Nomor Surat'),
  LetterVariable(key: 'nama_pimpinan_sponsor', label: 'Nama Pimpinan/Sponsor'),
  LetterVariable(
      key: 'nama_instansi_perusahaan', label: 'Nama Instansi/Perusahaan'),
  LetterVariable(key: 'nama_acara', label: 'Nama Acara'),
  LetterVariable(
      key: 'nama_penyelenggara_organisasi',
      label: 'Nama Penyelenggara/Organisasi'),
  LetterVariable(key: 'tema_acara', label: 'Tema Acara'),
  LetterVariable(
      key: 'hari_tanggal_pelaksanaan',
      label: 'Hari, Tanggal Pelaksanaan',
      type: LetterVariableType.dateWithDay),
  LetterVariable(key: 'pukul', label: 'Pukul'),
  LetterVariable(key: 'tempat_pelaksanaan', label: 'Tempat Pelaksanaan'),
  LetterVariable(
      key: 'jumlah_target_peserta',
      label: 'Jumlah Target Peserta',
      type: LetterVariableType.number),
  LetterVariable(
      key: 'total_anggaran',
      label: 'Total Anggaran',
      type: LetterVariableType.currency),
  LetterVariable(
      key: 'nominal_bantuan_yang_dimohon',
      label: 'Nominal Bantuan yang Dimohon',
      type: LetterVariableType.currency),
  LetterVariable(key: 'jabatan', label: 'Jabatan', hint: 'mis. Ketua Panitia'),
];

String suratPermohonanBantuanDanaAcara(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Nomor&nbsp;&nbsp;&nbsp;&nbsp;: ${fillVar(vars, 'nomor_surat', '... (Nomor Surat)')}
      <br>
      Lampiran&nbsp;: 1 (satu) berkas proposal
      <br>
      Perihal&nbsp;&nbsp;&nbsp;: <b>Permohonan Bantuan Dana Acara</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_sponsor', '... (Nama Pimpinan/Sponsor)')}
      <br>
      ${fillVar(vars, 'nama_instansi_perusahaan', '... (Nama Instansi/Perusahaan)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Sehubungan dengan akan diselenggarakannya kegiatan ${fillVar(vars, 'nama_acara', '... (Nama Acara)')} oleh ${fillVar(vars, 'nama_penyelenggara_organisasi', '... (Nama Penyelenggara/Organisasi)')}, dengan ini kami selaku panitia bermaksud mengajukan permohonan bantuan dana guna mendukung kelancaran pelaksanaan kegiatan tersebut.
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
            <td style="width: 100%">${fillVar(vars, 'nama_acara', '... (Nama Acara)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tema Acara</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tema_acara', '... (Tema Acara)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hari_tanggal_pelaksanaan', '... (Hari, Tanggal Pelaksanaan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'pukul', '... (Pukul)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tempat_pelaksanaan', '... (Tempat Pelaksanaan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Target Peserta</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jumlah_target_peserta', '... (Jumlah Target Peserta)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Total Anggaran</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'total_anggaran', 'Rp ... (Total Anggaran)', prefix: 'Rp ')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Dana yang Dimohon</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nominal_bantuan_yang_dimohon', 'Rp ... (Nominal Bantuan yang Dimohon)', prefix: 'Rp ')}</td>
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
              <span style="white-space: nowrap">${fillVar(vars, 'jabatan', '... (Jabatan, mis. Ketua Panitia)')}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
