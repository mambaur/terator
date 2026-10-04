import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPengaduanUmumVariables = [
  LetterVariable(
      key: 'nama_pimpinan_bagian_pengaduan',
      label: 'Nama Pimpinan/Bagian Pengaduan'),
  LetterVariable(
      key: 'nama_instansi_perusahaan', label: 'Nama Instansi/Perusahaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(
      key: 'jenis_pengaduan',
      label: 'Jenis Pengaduan',
      hint: 'mis. Pelayanan/Produk/Lingkungan'),
  LetterVariable(
      key: 'tanggal_waktu_kejadian', label: 'Tanggal/Waktu Kejadian'),
  LetterVariable(key: 'lokasi_kejadian', label: 'Lokasi Kejadian'),
  LetterVariable(
      key: 'uraian_lengkap_kronologis_kejadian_pengaduan',
      label: 'Uraian Lengkap Kronologis Kejadian/Pengaduan',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'kerugian_yang_dialami',
      label: 'Kerugian yang Dialami',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'bukti_pendukung',
      label: 'Bukti Pendukung',
      hint: 'mis. Foto/Bukti Transaksi/Saksi'),
];

String suratPengaduanUmum(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Pengaduan/Keluhan</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_bagian_pengaduan', '... (Nama Pimpinan/Bagian Pengaduan)')}
      <br>
      ${fillVar(vars, 'nama_instansi_perusahaan', '... (Nama Instansi/Perusahaan)')}
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
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik', '... (Nomor KTP/NIK)')}</td>
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
          <tr>
            <td style="white-space: nowrap">Email</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.email ?? ''}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Melalui surat ini, saya bermaksud menyampaikan pengaduan/keluhan terkait dengan hal sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Jenis Pengaduan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'jenis_pengaduan', '... (Jenis Pengaduan, mis. Pelayanan/Produk/Lingkungan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu Kejadian</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'tanggal_waktu_kejadian', '... (Tanggal/Waktu Kejadian)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Lokasi</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'lokasi_kejadian', '... (Lokasi Kejadian)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Adapun uraian kronologis pengaduan/keluhan saya adalah sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      ${fillVar(vars, 'uraian_lengkap_kronologis_kejadian_pengaduan', '... (Uraian Lengkap Kronologis Kejadian/Pengaduan)')}
    </p>
    <p style="text-align: justify; ">
      Akibat dari kejadian tersebut, saya mengalami kerugian berupa ${fillVar(vars, 'kerugian_yang_dialami', '... (Kerugian yang Dialami)')}. Oleh karena itu, saya memohon kepada pihak yang berwenang untuk:
    </p>
    <p style="text-align: justify; ">
      1. Menindaklanjuti pengaduan/keluhan ini dengan sebaik-baiknya;
      <br>
      2. Memberikan penjelasan dan solusi atas permasalahan yang saya laporkan;
      <br>
      3. Mengambil langkah perbaikan agar kejadian serupa tidak terulang kembali.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya melampirkan bukti pendukung berupa ${fillVar(vars, 'bukti_pendukung', '... (Bukti Pendukung, mis. Foto/Bukti Transaksi/Saksi)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pengaduan ini saya sampaikan. Atas perhatian dan tindak lanjut Bapak/Ibu, saya ucapkan terima kasih.
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
