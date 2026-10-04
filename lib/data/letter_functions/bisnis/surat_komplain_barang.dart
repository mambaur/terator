import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratKomplainBarangVariables = [
  LetterVariable(
      key: 'nama_perusahaan_supplier', label: 'Nama Perusahaan/Supplier'),
  LetterVariable(
      key: 'alamat', label: 'Alamat', type: LetterVariableType.multiline),
  LetterVariable(key: 'nama_perusahaan', label: 'Nama Perusahaan'),
  LetterVariable(key: 'no_invoice', label: 'No. Invoice'),
  LetterVariable(
      key: 'tanggal_terima',
      label: 'Tanggal Terima',
      type: LetterVariableType.date),
  LetterVariable(key: 'nama_barang', label: 'Nama Barang'),
  LetterVariable(
      key: 'deskripsi_masalah',
      label: 'Deskripsi Masalah',
      type: LetterVariableType.multiline),
  LetterVariable(
      key: 'penyelesaian_yang_diminta',
      label: 'Penyelesaian yang Diminta',
      type: LetterVariableType.choice,
      options: ['Penggantian', 'Perbaikan', 'Pengembalian Dana']),
  LetterVariable(key: 'batas_waktu', label: 'Batas Waktu'),
];

String suratKomplainBarang(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_perusahaan_supplier', '... (Nama Perusahaan/Supplier)')}
      <br>
      di ${fillVar(vars, 'alamat', '... (Alamat)')}
    </p>
    <p><br></p>
    <p>Perihal: <b>Komplain Barang/Jasa</b></p>
    <p><br></p>
    <p style="text-align: justify; ">
      Dengan Hormat,
    </p>
    <p style="text-align: justify; ">
      Kami yang bertanda tangan di bawah ini selaku perwakilan dari ${fillVar(vars, 'nama_perusahaan', '... (Nama Perusahaan)')}, menyampaikan keluhan terkait barang/jasa yang telah kami terima dengan rincian:
    </p>
    <p>
      <table border="0" style="width:100%">
				<tbody>
					<tr>
						<td style="white-space: nowrap">No. Invoice</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'no_invoice', '... (No. Invoice)')}</td>
					</tr>
					<tr>
						<td style="white-space: nowrap">Tanggal Terima</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'tanggal_terima', '... (Tanggal)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Nama Barang</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'nama_barang', '... (Nama Barang)')}</td>
					</tr>
          <tr>
						<td style="white-space: nowrap">Masalah</td>
						<td>:&nbsp</td>
						<td style="width: 100%">${fillVar(vars, 'deskripsi_masalah', '... (Deskripsi Masalah)')}</td>
					</tr>
				</tbody>
			</table>
    </p>
    <p style="text-align: justify; ">
      Kami memohon agar masalah ini dapat segera ditindaklanjuti dengan ${fillVar(vars, 'penyelesaian_yang_diminta', '... (penggantian/perbaikan/pengembalian dana)')} selambat-lambatnya ${fillVar(vars, 'batas_waktu', '... (Batas Waktu)')}.
    </p>
    <p style="text-align: justify; ">
      Demikian surat ini kami sampaikan. Atas perhatian dan tindak lanjutnya kami ucapkan terima kasih.
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
