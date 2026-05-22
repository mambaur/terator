# Letter Template Rules

Guidance for adding a new Indonesian formal letter (surat) template to Terator. Read this end-to-end before writing a new template — every existing template follows these rules and any new one must too.

All user-visible strings (titles, body copy, labels, placeholders) **must be in Bahasa Indonesia**. This file's prose is English because it is developer/AI guidance, but every string inside the returned HTML must be Indonesian.

---

## 1. Where a template lives

Each template is exactly one Dart file under a category folder:

```
lib/data/letter_functions/
├── bisnis/         → business letters
├── desa/           → village/RT-RW letters
├── kesehatan/      → health letters
├── keuangan/       → financial letters
├── pekerjaan/      → employment letters
├── pribadi/        → personal letters
├── sekolah/        → school letters
└── umum/           → general-purpose letters
```

Pick the folder that matches the letter's domain. If none fits, prefer `umum/` rather than inventing a new category — adding a category also requires touching [letter_data.dart](../letter_data.dart).

**File name** = the letter key in `snake_case` (e.g. `surat_izin_sakit.dart`). The file name, the function name (camelCase), and the registry `key` must agree.

---

## 2. Required function signature

Every template file exports **one** top-level function with this exact signature:

```dart
import 'package:intl/intl.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/models/letter_model.dart';

String suratXxxYyy(
    LetterModel? letter, String? img, AccountModel? account) {
  String dateNow2 = DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());

  String html = """
    ... HTML here ...
  """;

  return html;
}
```

Rules:

- Function returns a single `String` of HTML — no widgets, no async, no I/O.
- Parameter order is **always** `(LetterModel? letter, String? img, AccountModel? account)`. Do not reorder, do not rename, do not drop unused parameters — the registry calls them positionally.
- All three parameters are nullable. Always guard with `?.` and provide a sensible empty fallback (`?? ''`).
- Use a triple-quoted raw-ish string (`"""..."""`) with `${...}` interpolation. Do not concatenate with `+`.
- Use the date format `DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now())` for the letter date (Indonesian locale is initialized in `main.dart`).

---

## 3. Account fields available

Pull identity data from `AccountModel` instead of leaving blanks. Always use `account?.field ?? ''`.

| Field                       | Typical label in surat          |
|-----------------------------|---------------------------------|
| `name`                      | Nama                            |
| `parentName`                | Nama Orang Tua / Wali           |
| `placeAndDateOfBirth`       | Tempat / Tgl. Lahir             |
| `gender`                    | Jenis Kelamin                   |
| `religion`                  | Agama                           |
| `maritalStatus`             | Status (menikah/belum menikah)  |
| `address`                   | Alamat                          |
| `telephone`                 | Nomor Telepon                   |
| `email`                     | Email                           |
| `lastEducation`             | Pendidikan Terakhir             |
| `educationInstitution`      | Nama Sekolah/Kampus             |
| `educationClass`            | Kelas                           |
| `educationFaculty`          | Fakultas                        |
| `educationStudyProgram`     | Program Studi / Jurusan         |
| `educationNumber`           | NIS / NIM                       |
| `educationAddress`          | Alamat Sekolah/Kampus           |
| `heightOrWeight`            | Tinggi / Berat Badan            |
| `signatureImage`            | (base64; injected via `img`)    |
| `letterCityWritten`         | Kota tempat surat ditulis       |

Anything NOT in this list must use the manual-placeholder pattern (Section 4) — do **not** invent new account fields. Adding a field requires a DB migration.

---

## 4. Manual placeholder pattern

For values that are not on `AccountModel` (e.g. recipient name, nominal amount, dates of leave, company name), embed a bold placeholder so the user can fill it in inside the WYSIWYG editor:

```html
<b>... (Nama Pimpinan)</b>
<b>... (Jumlah Hari)</b>
<b>Rp ... (Nominal Hutang)</b>
```

Rules:

- Always wrap in `<b>...</b>` so it is visually obvious in the editor.
- Start with literal `...` then a space and a parenthesized Indonesian label.
- Keep the label short and descriptive (`(Nama Perusahaan)`, not `(masukkan nama perusahaan yang dituju)`).
- Currency: prefix with `Rp ` inside the bold, e.g. `<b>Rp ... (Nominal)</b>`.
- Never leave a bare empty `<td></td>` for fields the user is expected to fill — use the placeholder so the user sees what to type.

---

## 5. Signature injection (`img`)

The `img` parameter is either `null` or a fully-formed `<img src='data:image/png;base64,...'>` tag — already wrapped, do not wrap it again.

Use one of the two idioms below depending on layout:

**Single-column signature (most common)** — placeholder gives vertical room when there is no signature:

```html
${img ?? '<br><br><br><br><br>'}
```

**Two-column signature (e.g. domisili, where Pemohon and Pejabat both sign)** — only render placeholder spacing on the column that owns the signature:

```html
${img == null ? '<br><br><br><br><br>' : ''}
...
${img ?? ''}
```

Never reference `account?.signatureImage` directly — the `img` parameter is the canonical, already-decoded version.

---

## 6. Standard letter structure

Most templates follow this skeleton. Compose new templates by reusing these blocks rather than inventing layout.

### 6.1 Letter date (top-right) — used when the letter starts with "Kepada Yth."

```html
<p style="text-align: right; ">${account?.letterCityWritten ?? ''}, $dateNow2</p>
<p><br></p>
```

### 6.2 Title (centered, bold) — used when the letter is a "Surat Pernyataan / Keterangan / Kwitansi"

```html
<p style="text-align: center;">
  <b>SURAT PERNYATAAN XXX</b>
</p>
<p><br></p>
```

Pick **either** 6.1 or 6.2 as the opener depending on letter type:
- Letters addressed to a specific recipient (lamaran, izin, permohonan) → date opener (6.1).
- Self-declared statements / certifications (pernyataan, keterangan, kwitansi) → centered title (6.2). For these the date goes inside the signature block (Section 6.6).

### 6.3 Recipient block (only for 6.1-style letters)

```html
<p>
  Kepada Yth.
  <br>
  <b>... (Nama Pimpinan)</b>
  <br>
  di Tempat
</p>
<p><br></p>
<p style="text-align: justify; ">Dengan Hormat,</p>
```

### 6.4 Opening line + identity table

```html
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
        <td style="white-space: nowrap">Alamat</td>
        <td>:&nbsp</td>
        <td style="width: 100%">${account?.address ?? ''}</td>
      </tr>
      <!-- add more rows from Section 3 as the letter requires -->
    </tbody>
  </table>
</p>
```

Identity-table rules:
- `<table border="0" style="width:100%">` — always borderless, full width.
- Three columns per row: label (`white-space: nowrap`), colon (`:&nbsp`), value (`width: 100%`).
- Wrap the table in `<p>...</p>` (matches existing templates).
- Pick rows based on what the letter actually needs — don't dump every account field.

### 6.5 Body paragraphs

```html
<p style="text-align: justify; ">
  Dengan ini menyatakan bahwa ... <b>... (Detail)</b> ...
</p>
<p style="text-align: justify; ">
  Demikian surat ini saya buat dengan sebenar-benarnya, tanpa paksaan dari pihak manapun.
</p>
```

Rules:
- Every body paragraph uses `style="text-align: justify; "`.
- Inline placeholders use the `<b>... (Label)</b>` pattern from Section 4.
- End the body with a "Demikian ..." closing sentence — this is the Indonesian convention.

### 6.6 Signature block (single-column — used when the title was centered, 6.2)

```html
<p><br></p>
<table>
  <tbody>
    <tr>
      <td style="width: 100%">&nbsp;</td>
      <td style="vertical-align:top;text-align:center;">
        <span style="white-space: nowrap">${account?.letterCityWritten ?? ''}, $dateNow2</span>
        <br>
        <span style="white-space: nowrap">Yang menyatakan,</span>
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
```

The role label (`Yang menyatakan,` / `Hormat saya,` / `Penerima,` / `Pemohon,`) should match the letter type.

### 6.7 Signature block (two-column — when two parties sign, e.g. Pemohon + Ketua RT/RW)

See [desa/surat_keterangan_domisili.dart](desa/surat_keterangan_domisili.dart) for the canonical example. Key differences from 6.6:
- Three columns per row: left signer, spacer (`width: 100%`), right signer.
- Only the side that has the real signature uses `${img ?? ''}`; the other side prints its name without an image.
- Use the `${img == null ? '<br><br><br><br><br>' : ''}` idiom from Section 5 on the signing column.

### 6.8 Trailing spacer

Always end the HTML with `<br><br><br>` before the closing `"""`. This gives the PDF some bottom margin.

---

## 7. HTML conventions (compatible with html_editor_enhanced + flutter_html_to_pdf)

The HTML is rendered both in the WYSIWYG editor (`HtmlEditor` from `html_editor_enhanced`) and converted to PDF via `HtmlToPdfConverter`. Stick to the subset other templates already use — anything fancier may render in one but break the other.

Allowed and used by existing templates:
- `<p>`, `<br>`, `<b>`, `<ul>`/`<li>`, `<table>`/`<tbody>`/`<tr>`/`<td>`, `<span>`.
- Inline `style="..."` only. Allowed properties: `text-align`, `width`, `white-space`, `vertical-align`.
- `border="0"` as a table attribute (matches existing usage).

Avoid:
- `<div>` for layout — existing templates use `<p>` and `<table>` instead.
- External CSS, `<style>` blocks, `<head>`, `<html>`, `<body>` wrappers — the template is a fragment, not a document.
- Images other than the injected `img` (no logos, no decorative graphics).
- Web fonts, custom font sizes, colors. Let the editor's default styling apply.
- `class=` attributes — no stylesheet is loaded.
- JavaScript, `<script>`, `<iframe>`, `onclick`, etc.

Punctuation note: existing tables use `:&nbsp` (no trailing semicolon on the entity). This is intentional and matches every existing template — keep it as-is for consistency.

---

## 8. Registering the new template

After creating the file in `lib/data/letter_functions/<category>/`, wire it up in [lib/data/letter_data.dart](../letter_data.dart):

1. **Import** at the top of the file:
   ```dart
   import 'package:terator/data/letter_functions/<category>/surat_xxx.dart';
   ```
2. **List entry** — add an object to the matching category in `LetterData.listLetters()`:
   ```dart
   {"key": "surat_xxx", "title": "Surat Xxx"},
   ```
   Use `subtitle` only when the existing entries in that category already use one (e.g. school letters distinguish "SMP/SMA" vs "Kuliah/Kampus").
3. **HTML mapping** — add an object to `letterDataMap(...)` so the key resolves to the template function:
   ```dart
   {
     "key": "surat_xxx",
     "title": "Surat Xxx",
     "html": suratXxx(letter, image, account),
   },
   ```
4. **Premium (optional)** — if the letter is paid, add the key to `premiumLetterMap`:
   ```dart
   'surat_xxx': true,
   ```
   Free letters are simply absent from the map; do not add them with `false`.

The `key` string must be byte-identical in all three places (and ideally match the file name). Mismatches cause `LetterData.html(...)` to silently return an empty string.

---

## 9. Checklist before considering the template done

- [ ] File lives under the correct category folder; name is `surat_xxx.dart`.
- [ ] Function signature is exactly `String suratXxx(LetterModel? letter, String? img, AccountModel? account)`.
- [ ] `intl`, `AccountModel`, and `LetterModel` are imported.
- [ ] Every account-derived value is guarded with `?.` and `?? ''`.
- [ ] Every non-account value is a `<b>... (Label)</b>` placeholder in Bahasa Indonesia.
- [ ] All copy (title, body, role labels, placeholders) is in Bahasa Indonesia.
- [ ] Date uses `DateFormat("d MMMM yyyy", "id_ID")`.
- [ ] Opener matches letter type: addressed letter → date-right + "Kepada Yth."; declaration → centered bold title.
- [ ] Signature block uses the `${img ?? '<br><br><br><br><br>'}` idiom (or the two-column variant).
- [ ] HTML ends with `<br><br><br>` before the closing `"""`.
- [ ] No `<div>`, `<style>`, `<script>`, `class=`, external CSS, or custom fonts.
- [ ] Imported and registered in `letter_data.dart` (`listLetters` **and** `letterDataMap`).
- [ ] If premium, added to `premiumLetterMap` with value `true`.
- [ ] `flutter analyze` is clean.

---

## 10. Reference examples

When in doubt, copy the structure from a template of the same type:

| Pattern                            | Reference                                                                 |
|------------------------------------|---------------------------------------------------------------------------|
| Letter to a recipient (date opener)| [kesehatan/surat_izin_sakit.dart](kesehatan/surat_izin_sakit.dart)        |
| Job application with attachment list | [pekerjaan/surat_lamaran_pekerjaan.dart](pekerjaan/surat_lamaran_pekerjaan.dart) |
| Self-declaration (centered title)  | [keuangan/surat_pernyataan_hutang.dart](keuangan/surat_pernyataan_hutang.dart) |
| Two-column signature (two signers) | [desa/surat_keterangan_domisili.dart](desa/surat_keterangan_domisili.dart) |
| Receipt-style (kwitansi)           | [keuangan/surat_kwitansi_pembayaran.dart](keuangan/surat_kwitansi_pembayaran.dart) |
