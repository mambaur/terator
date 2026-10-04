import 'dart:convert';

import 'package:terator/models/kop_surat_model.dart';

/// Where the main logo and the optional secondary logo go.
enum KopLogoLayout {
  /// Main logo far left, secondary far right, text in between.
  sides,

  /// Main logo left, text next to it, secondary pushed to the far right.
  /// Unlike [sides], no empty column is kept when a logo is missing.
  leftAndRight,

  /// Both logos side by side above the text.
  top,

  /// Both logos side by side on the left, text after them.
  leftGroup,

  /// Text first, both logos side by side on the right.
  rightGroup,

  /// Text only, logos are not shown.
  none,
}

/// One separator line under the kop.
class KopLine {
  final double thickness;
  final String color;
  const KopLine(this.thickness, [this.color = '#000000']);
}

class KopSuratDesign {
  final String id;
  final String name;
  final String description;
  final KopLogoLayout layout;

  /// 'left' | 'center' | 'right'
  final String textAlign;
  final String nameColor;

  /// Font size of the institution name in the HTML (px).
  final int nameSize;

  /// Logo size in the HTML (px).
  final int logoSize;

  /// Subtitle printed above the institution name (e.g. "PEMERINTAH
  /// KABUPATEN ..." above the office name) instead of below it.
  final bool subtitleFirst;

  /// Colored bar on the left of the text block, or null.
  final String? accentBar;

  /// Border around the whole kop, or null.
  final String? frameColor;

  final List<KopLine> lines;

  const KopSuratDesign({
    required this.id,
    required this.name,
    required this.description,
    required this.layout,
    this.textAlign = 'center',
    this.nameColor = '#000000',
    this.nameSize = 20,
    this.logoSize = 80,
    this.subtitleFirst = false,
    this.accentBar,
    this.frameColor,
    this.lines = const [KopLine(2)],
  });

  bool get showsLogos => layout != KopLogoLayout.none;
}

/// HTML builders for each kop surat design. The output is prepended to the
/// letter HTML (editor + PDF), so it must only use inline styles.
/// `KopDesignPreview` renders the same [KopSuratDesign] specs in Flutter.
class KopSuratDesigns {
  static const String _navy = '#1E3A8A';
  static const String _green = '#166534';
  static const String _maroon = '#9F1239';
  static const String _teal = '#0F766E';

  static const List<KopSuratDesign> all = [
    KopSuratDesign(
      id: 'klasik',
      name: 'Klasik',
      description: 'Logo di kiri & kanan, teks di tengah, garis ganda. '
          'Cocok untuk instansi resmi.',
      layout: KopLogoLayout.sides,
      lines: [KopLine(3), KopLine(1)],
    ),
    KopSuratDesign(
      id: 'pemerintahan',
      name: 'Pemerintahan',
      description: 'Sub-judul di atas nama instansi, logo di kiri & kanan, '
          'garis tipis-tebal.',
      layout: KopLogoLayout.sides,
      nameSize: 22,
      subtitleFirst: true,
      lines: [KopLine(1), KopLine(4)],
    ),
    KopSuratDesign(
      id: 'tengah',
      name: 'Logo Tengah',
      description: 'Logo berdampingan di atas, teks rata tengah. '
          'Cocok untuk sekolah & organisasi.',
      layout: KopLogoLayout.top,
      logoSize: 72,
    ),
    KopSuratDesign(
      id: 'tengah_biru',
      name: 'Tengah Biru',
      description: 'Logo berdampingan di atas, nama instansi biru, '
          'garis ganda biru.',
      layout: KopLogoLayout.top,
      logoSize: 64,
      nameColor: _navy,
      lines: [KopLine(3, _navy), KopLine(1, _navy)],
    ),
    KopSuratDesign(
      id: 'pendidikan',
      name: 'Pendidikan',
      description: 'Logo di kiri & kanan, nama instansi hijau, garis ganda '
          'hijau. Cocok untuk sekolah & kampus.',
      layout: KopLogoLayout.sides,
      nameColor: _green,
      lines: [KopLine(3, _green), KopLine(1, _green)],
    ),
    KopSuratDesign(
      id: 'bingkai',
      name: 'Bingkai',
      description: 'Kop di dalam bingkai garis, logo di kiri & kanan.',
      layout: KopLogoLayout.sides,
      logoSize: 70,
      frameColor: '#000000',
      lines: [],
    ),
    KopSuratDesign(
      id: 'modern',
      name: 'Modern',
      description: 'Logo di kiri (logo kedua di kanan), teks rata kiri '
          'dengan aksen biru. Cocok untuk bisnis.',
      layout: KopLogoLayout.leftAndRight,
      textAlign: 'left',
      nameColor: _navy,
      logoSize: 72,
      lines: [KopLine(4, _navy)],
    ),
    KopSuratDesign(
      id: 'elegan',
      name: 'Elegan',
      description: 'Teks rata kiri dengan garis aksen merah marun di '
          'sampingnya, logo di kiri & kanan.',
      layout: KopLogoLayout.leftAndRight,
      textAlign: 'left',
      nameColor: _maroon,
      logoSize: 68,
      accentBar: _maroon,
      lines: [KopLine(1, _maroon)],
    ),
    KopSuratDesign(
      id: 'dua_logo_kiri',
      name: 'Dua Logo Kiri',
      description: 'Kedua logo berdampingan di kiri, teks rata kiri.',
      layout: KopLogoLayout.leftGroup,
      textAlign: 'left',
      logoSize: 64,
      lines: [KopLine(3), KopLine(1)],
    ),
    KopSuratDesign(
      id: 'rata_kanan',
      name: 'Rata Kanan',
      description: 'Kedua logo di kiri, teks rata kanan, aksen hijau tosca.',
      layout: KopLogoLayout.leftGroup,
      textAlign: 'right',
      nameColor: _teal,
      logoSize: 64,
      lines: [KopLine(3, _teal)],
    ),
    KopSuratDesign(
      id: 'minimalis',
      name: 'Minimalis',
      description: 'Teks rata kiri, logo kecil berdampingan di kanan, '
          'garis tipis.',
      layout: KopLogoLayout.rightGroup,
      textAlign: 'left',
      logoSize: 56,
      lines: [KopLine(1)],
    ),
    KopSuratDesign(
      id: 'tanpa_logo',
      name: 'Tanpa Logo',
      description: 'Hanya teks rata tengah dengan garis tebal, logo tidak '
          'ditampilkan.',
      layout: KopLogoLayout.none,
      nameSize: 22,
      lines: [KopLine(3)],
    ),
  ];

  /// CSS class on the wrapper div around every generated kop.
  static const String markerClass = 'terator-kop';

  static KopSuratDesign byId(String id) =>
      all.firstWhere((d) => d.id == id, orElse: () => all.first);

  static const _esc = HtmlEscape();

  /// [logoBase64] is the main logo, [secondaryLogoBase64] the optional
  /// second one. Either may be null.
  static String html(KopSuratModel kop,
      {String? logoBase64, String? secondaryLogoBase64}) {
    final d = byId(kop.designId);
    final logo1 = d.showsLogos ? logoBase64 : null;
    final logo2 = d.showsLogos ? secondaryLogoBase64 : null;
    final cell = d.logoSize + 10;

    var text = _lines(kop, d);
    if (d.accentBar != null) {
      text =
          "<div style='border-left:4px solid ${d.accentBar};padding-left:10px;'>$text</div>";
    }
    final logos = [
      if (logo1 != null) _img(logo1, d.logoSize),
      if (logo2 != null) _img(logo2, d.logoSize),
    ];

    String body;
    switch (d.layout) {
      case KopLogoLayout.sides:
        // Both cells are kept (even if empty) so the text stays centered.
        body = logos.isEmpty
            ? text
            : _row([
                _td(logo1 == null ? '' : _img(logo1, d.logoSize),
                    width: cell, align: 'center'),
                _td(text),
                _td(logo2 == null ? '' : _img(logo2, d.logoSize),
                    width: cell, align: 'center'),
              ]);
        break;
      case KopLogoLayout.leftAndRight:
        body = _row([
          if (logo1 != null)
            _td(_img(logo1, d.logoSize), width: cell, align: 'left'),
          _td(text),
          if (logo2 != null)
            _td(_img(logo2, d.logoSize), width: cell, align: 'right'),
        ]);
        break;
      case KopLogoLayout.top:
        body = logos.isEmpty
            ? text
            : "<div style='text-align:center;margin-bottom:4px;'>${logos.join('&nbsp;&nbsp;&nbsp;')}</div>$text";
        break;
      case KopLogoLayout.leftGroup:
        body = _row([
          if (logos.isNotEmpty)
            _td(logos.join('&nbsp;'),
                width: logos.length * cell, align: 'left', nowrap: true),
          _td(text),
        ]);
        break;
      case KopLogoLayout.rightGroup:
        body = _row([
          _td(text),
          if (logos.isNotEmpty)
            _td(logos.join('&nbsp;'),
                width: logos.length * cell, align: 'right', nowrap: true),
        ]);
        break;
      case KopLogoLayout.none:
        body = text;
        break;
    }

    if (d.frameColor != null) {
      body =
          "<div style='border:1.5px solid ${d.frameColor};padding:10px;'>$body</div>";
    }

    final lines = StringBuffer();
    for (var i = 0; i < d.lines.length; i++) {
      final l = d.lines[i];
      lines.write(
          "<div style='border-top:${l.thickness}px solid ${l.color};margin-top:${i == 0 ? 8 : 2}px;'></div>");
    }

    // Wrapped in a marker div so a saved letter's kop can be found and
    // swapped/removed later (see KopSuratRepository.stripKop).
    return "<div class='$markerClass'>$body$lines</div><p><br></p>";
  }

  static String _img(String base64, int size) =>
      "<img src='data:image/png;base64,$base64' style='width:${size}px;height:${size}px;object-fit:contain;'>";

  static String _row(List<String> cells) =>
      "<table style='width:100%;border-collapse:collapse;'><tbody><tr>${cells.join()}</tr></tbody></table>";

  static String _td(String content,
      {int? width, String? align, bool nowrap = false}) {
    final style = [
      if (width != null) 'width:${width}px',
      'vertical-align:middle',
      if (align != null) 'text-align:$align',
      if (nowrap) 'white-space:nowrap',
    ].join(';');
    return "<td style='$style;'>$content</td>";
  }

  static String _contactLine(KopSuratModel kop) {
    final parts = <String>[
      if (kop.telephone.trim().isNotEmpty)
        'Telp. ${_esc.convert(kop.telephone)}',
      if (kop.email.trim().isNotEmpty) 'Email: ${_esc.convert(kop.email)}',
      if (kop.website.trim().isNotEmpty) _esc.convert(kop.website),
    ];
    return parts.join(' &nbsp;|&nbsp; ');
  }

  /// Text lines of the kop, each skipped when empty.
  static String _lines(KopSuratModel kop, KopSuratDesign d) {
    final align = d.textAlign;
    final name = kop.institutionName.trim().isEmpty
        ? ''
        : "<div style='text-align:$align;font-size:${d.nameSize}px;font-weight:bold;text-transform:uppercase;color:${d.nameColor};line-height:1.2;'>${_esc.convert(kop.institutionName)}</div>";
    final subtitle = kop.subtitle.trim().isEmpty
        ? ''
        : "<div style='text-align:$align;font-size:14px;font-weight:bold;line-height:1.3;'>${_esc.convert(kop.subtitle)}</div>";

    final buf = StringBuffer();
    buf.write(d.subtitleFirst ? '$subtitle$name' : '$name$subtitle');
    if (kop.address.trim().isNotEmpty) {
      buf.write(
          "<div style='text-align:$align;font-size:12px;line-height:1.3;'>${_esc.convert(kop.address)}</div>");
    }
    final contact = _contactLine(kop);
    if (contact.isNotEmpty) {
      buf.write(
          "<div style='text-align:$align;font-size:12px;line-height:1.3;'>$contact</div>");
    }
    return buf.toString();
  }
}
