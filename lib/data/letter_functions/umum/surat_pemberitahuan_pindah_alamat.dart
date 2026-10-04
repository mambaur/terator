import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/models/letter_variable.dart';

const List<LetterVariable> suratPemberitahuanPindahAlamatVariables = [
  LetterVariable(
      key: 'nama_pimpinan_bagian_yang_dituju',
      label: 'Nama Pimpinan/Bagian yang Dituju'),
  LetterVariable(
      key: 'nama_instansi_perusahaan', label: 'Nama Instansi/Perusahaan'),
  LetterVariable(key: 'nomor_ktp_nik', label: 'Nomor KTP/NIK'),
  LetterVariable(
      key: 'nomor_pelanggan_anggota_jika_ada',
      label: 'Nomor Pelanggan/Anggota, Jika Ada'),
  LetterVariable(
      key: 'tanggal_efektif_pindah',
      label: 'Tanggal Efektif Pindah',
      type: LetterVariableType.date),
  LetterVariable(
      key: 'alamat_lama_lengkap',
      label: 'Alamat Lama Lengkap',
      type: LetterVariableType.multiline),
  LetterVariable(key: 'rt_rw', label: 'RT/RW'),
  LetterVariable(key: 'kelurahan_desa', label: 'Kelurahan/Desa'),
  LetterVariable(key: 'kecamatan', label: 'Kecamatan'),
  LetterVariable(key: 'kota_kabupaten', label: 'Kota/Kabupaten'),
  LetterVariable(key: 'kode_pos', label: 'Kode Pos'),
];

String suratPemberitahuanPindahAlamat(
    LetterModel? letter, String? img, AccountModel? account,
    [Map<String, String>? vars]) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    <p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
    <p><br></p>
    <p>
      Perihal&nbsp;&nbsp;&nbsp;&nbsp;: <b>Pemberitahuan Pindah Alamat</b>
    </p>
    <p><br></p>
    <p>
      Kepada Yth.
      <br>
      ${fillVar(vars, 'nama_pimpinan_bagian_yang_dituju', '... (Nama Pimpinan/Bagian yang Dituju)')}
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
            <td style="white-space: nowrap">Tempat/Tgl. Lahir</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.placeAndDateOfBirth ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. KTP/NIK</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_ktp_nik', '... (Nomor KTP/NIK)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">No. Pelanggan/Anggota</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'nomor_pelanggan_anggota_jika_ada', '... (Nomor Pelanggan/Anggota, Jika Ada)')}</td>
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
      Dengan ini bermaksud memberitahukan bahwa terhitung sejak tanggal ${fillVar(vars, 'tanggal_efektif_pindah', '... (Tanggal Efektif Pindah)')}, saya telah pindah alamat dari:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Alamat Lama</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'alamat_lama_lengkap', '... (Alamat Lama Lengkap)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Menjadi alamat baru sebagai berikut:
    </p>
    <p>
      <table border="0" style="width:100%">
        <tbody>
          <tr>
            <td style="white-space: nowrap">Alamat Baru</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${account?.address ?? ''}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">RT/RW</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'rt_rw', '... (RT/RW)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Kelurahan/Desa</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'kelurahan_desa', '... (Kelurahan/Desa)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Kecamatan</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'kecamatan', '... (Kecamatan)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Kota/Kabupaten</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'kota_kabupaten', '... (Kota/Kabupaten)')}</td>
          </tr>
          <tr>
            <td style="white-space: nowrap">Kode Pos</td>
            <td>:&nbsp</td>
            <td style="width: 100%">${fillVar(vars, 'kode_pos', '... (Kode Pos)')}</td>
          </tr>
        </tbody>
      </table>
    </p>
    <p style="text-align: justify; ">
      Sehubungan dengan hal tersebut, dengan hormat saya memohon kepada Bapak/Ibu untuk:
    </p>
    <p style="text-align: justify; ">
      1. Memperbarui data alamat saya dalam sistem/database yang ada;
      <br>
      2. Mengirimkan seluruh korespondensi, tagihan, dan dokumen ke alamat baru tersebut;
      <br>
      3. Memberikan konfirmasi atas perubahan data ini.
    </p>
    <p style="text-align: justify; ">
      Demikian surat pemberitahuan ini saya sampaikan. Atas perhatian dan kerja samanya, saya ucapkan terima kasih.
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
