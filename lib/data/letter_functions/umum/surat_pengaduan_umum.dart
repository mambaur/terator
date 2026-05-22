import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPengaduanUmum(
    LetterModel? letter, String? img, AccountModel? account) {
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
      <b>... (Nama Pimpinan/Bagian Pengaduan)</b>
      <br>
      <b>... (Nama Instansi/Perusahaan)</b>
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
            <td style="width: 100%"><b>... (Nomor KTP/NIK)</b></td>
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
            <td style="width: 100%"><b>... (Jenis Pengaduan, mis. Pelayanan/Produk/Lingkungan)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Waktu Kejadian</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Tanggal/Waktu Kejadian)</b></td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Lokasi</td>
            <td>:&nbsp</td>
            <td style="width: 100%"><b>... (Lokasi Kejadian)</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Adapun uraian kronologis pengaduan/keluhan saya adalah sebagai berikut:
    </p>
    <p style="text-align: justify; ">
      <b>... (Uraian Lengkap Kronologis Kejadian/Pengaduan)</b>
    </p>
    <p style="text-align: justify; ">
      Akibat dari kejadian tersebut, saya mengalami kerugian berupa <b>... (Kerugian yang Dialami)</b>. Oleh karena itu, saya memohon kepada pihak yang berwenang untuk:
    </p>
    <p style="text-align: justify; ">
      1. Menindaklanjuti pengaduan/keluhan ini dengan sebaik-baiknya;
      <br>
      2. Memberikan penjelasan dan solusi atas permasalahan yang saya laporkan;
      <br>
      3. Mengambil langkah perbaikan agar kejadian serupa tidak terulang kembali.
    </p>
    <p style="text-align: justify; ">
      Sebagai bahan pertimbangan, saya melampirkan bukti pendukung berupa <b>... (Bukti Pendukung, mis. Foto/Bukti Transaksi/Saksi)</b>.
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
