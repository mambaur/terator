import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPermohonanSumbanganVariables = [
  LetterVariable(key: 'nomor_surat', label: 'Nomor Surat'),
  LetterVariable(key: 'nama_pimpinan_donatur', label: 'Nama Pimpinan/Donatur'),
  LetterVariable(
      key: 'nama_instansi_perusahaan', label: 'Nama Instansi/Perusahaan'),
  LetterVariable(key: 'nama_kegiatan', label: 'Nama Kegiatan'),
  LetterVariable(
      key: 'hari_tanggal',
      label: 'Hari, Tanggal',
      type: LetterVariableType.dateWithDay),
  LetterVariable(key: 'pukul', label: 'Pukul'),
  LetterVariable(key: 'lokasi_kegiatan', label: 'Lokasi Kegiatan'),
  LetterVariable(
      key: 'nama_penyelenggara_panitia', label: 'Nama Penyelenggara/Panitia'),
  LetterVariable(
      key: 'nominal_yang_dibutuhkan',
      label: 'Nominal yang Dibutuhkan',
      type: LetterVariableType.currency),
  LetterVariable(key: 'nama_bendahara', label: 'Nama Bendahara'),
  LetterVariable(key: 'nama_bank', label: 'Nama Bank'),
  LetterVariable(key: 'nomor_rekening', label: 'Nomor Rekening'),
  LetterVariable(key: 'jabatan', label: 'Jabatan', hint: 'mis. Ketua Panitia'),
];

String suratPermohonanSumbangan(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Nomor&nbsp;&nbsp;&nbsp;&nbsp;: ${fillVar(vars, 'nomor_surat', '... (Nomor Surat)')}
      <br>
      Lampiran&nbsp;: 1 (satu) berkas
      <br>
      Perihal&nbsp;&nbsp;&nbsp;: <b>Permohonan Sumbangan/Donasi</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_donatur', '... (Nama Pimpinan/Donatur)')}
      <br>
      ${fillVar(vars, 'nama_instansi_perusahaan', '... (Nama Instansi/Perusahaan)')}
      <br>
      di Tempat
    </p>
    <p><br></p>
    <p style="text-align: justify; ">Dengan hormat,</p>
    <p style="text-align: justify; ">
      Puji syukur kami panjatkan kepada Tuhan Yang Maha Esa. Sehubungan dengan akan dilaksanakannya kegiatan ${fillVar(vars, 'nama_kegiatan', '... (Nama Kegiatan)')} yang akan diselenggarakan pada:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Hari/Tanggal</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'hari_tanggal', '... (Hari, Tanggal)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'pukul', '... (Pukul)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Tempat</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'lokasi_kegiatan', '... (Lokasi Kegiatan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Penyelenggara</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nama_penyelenggara_panitia', '... (Nama Penyelenggara/Panitia)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Maka dengan segala kerendahan hati, kami selaku panitia bermaksud memohon bantuan berupa sumbangan/donasi kepada Bapak/Ibu, guna kelancaran pelaksanaan kegiatan tersebut. Adapun bentuk sumbangan dapat berupa:
    </p>
    <p style="text-align: justify; ">
      1. Sumbangan dana sebesar ${fillVar(vars, 'nominal_yang_dibutuhkan', 'Rp ... (Nominal yang Dibutuhkan)', prefix: 'Rp ')};
      <br>
      2. Sumbangan barang/konsumsi/perlengkapan kegiatan;
      <br>
      3. Bentuk dukungan lain yang sesuai dengan kebijakan Bapak/Ibu.
    </p>
    <p style="text-align: justify; ">
      Apabila Bapak/Ibu berkenan menyalurkan sumbangan, dapat melalui rekening atas nama ${fillVar(vars, 'nama_bendahara', '... (Nama Bendahara)')}, Bank ${fillVar(vars, 'nama_bank', '... (Nama Bank)')}, Nomor Rekening ${fillVar(vars, 'nomor_rekening', '... (Nomor Rekening)')}, atau dapat diserahkan secara langsung kepada panitia.
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
