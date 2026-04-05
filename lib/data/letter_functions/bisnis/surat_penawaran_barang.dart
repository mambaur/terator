import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratPenawaranBarang(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      <b>... (Nama Perusahaan/Klien)</b>
      <br>
      di <b>... (Alamat)</b>
    </p>
    <p><br></p>
    <p>Perihal: <b>Penawaran Barang/Jasa</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Perkenalkan, kami dari <b>... (Nama Perusahaan)</b> bermaksud menawarkan produk/jasa kami kepada Bapak/Ibu. Adapun rincian penawaran sebagai berikut:
    </p>
    <p>
      <table border="1" style="width:100%; border-collapse: collapse;">
        <thead>
          <tr>
            <th style="padding: 8px;">No</th>
            <th style="padding: 8px;">Nama Barang/Jasa</th>
            <th style="padding: 8px;">Qty</th>
            <th style="padding: 8px;">Harga Satuan</th>
            <th style="padding: 8px;">Total</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="padding: 8px; text-align: center;">1</td>
            <td style="padding: 8px;"><b>... (Nama)</b></td>
            <td style="padding: 8px; text-align: center;"><b>...</b></td>
            <td style="padding: 8px;"><b>Rp ...</b></td>
            <td style="padding: 8px;"><b>Rp ...</b></td>
          </tr>
          <tr>
            <td style="padding: 8px; text-align: center;">2</td>
            <td style="padding: 8px;"><b>... (Nama)</b></td>
            <td style="padding: 8px; text-align: center;"><b>...</b></td>
            <td style="padding: 8px;"><b>Rp ...</b></td>
            <td style="padding: 8px;"><b>Rp ...</b></td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Harga di atas sudah termasuk <b>... (Pajak/Ongkir/dll)</b>. Penawaran ini berlaku sampai dengan <b>... (Tanggal Berlaku)</b>.
    </p>
    <p style="text-align: justify; ">
      Demikian surat penawaran ini kami sampaikan. Atas perhatian dan kerjasamanya kami ucapkan terima kasih.
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
              <span style="white-space: nowrap">${account?.name ?? ''}</span>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
    <br><br><br>
  """;

  return html;
}
