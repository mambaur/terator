import 'package:flutter/material.dart';
import 'package:terator/data/kop_surat_designs.dart';
import 'package:terator/models/kop_surat_model.dart';
import 'package:terator/repositories/kop_surat_repository.dart';

/// Flutter approximation of the HTML built by `KopSuratDesigns.html` from the
/// same [KopSuratDesign] spec, used to preview a kop without rendering a PDF.
class KopDesignPreview extends StatelessWidget {
  final KopSuratModel kop;
  final String designId;
  final double scale;

  /// Show a placeholder for the secondary logo even when none is uploaded,
  /// so the design picker shows where both logos go.
  final bool showBothLogos;

  const KopDesignPreview({
    super.key,
    required this.kop,
    required this.designId,
    this.scale = 1,
    this.showBothLogos = false,
  });

  /// HTML px → preview px.
  static const double _ratio = 0.58;

  static Color _hex(String hex) =>
      Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));

  String get _name => kop.institutionName.trim().isEmpty
      ? 'NAMA INSTANSI'
      : kop.institutionName.toUpperCase();

  String get _address =>
      kop.address.trim().isEmpty ? 'Alamat instansi' : kop.address;

  String get _contact => [
        if (kop.telephone.trim().isNotEmpty) 'Telp. ${kop.telephone}',
        if (kop.email.trim().isNotEmpty) 'Email: ${kop.email}',
        if (kop.website.trim().isNotEmpty) kop.website,
      ].join(' | ');

  bool get _hasSecondary =>
      KopSuratRepository.logoImage(kop.secondaryLogoPath) != null;

  /// Logo at [path]; the main logo falls back to a grey placeholder.
  Widget _logo(String? path, double size, {bool placeholder = true}) {
    final s = size * _ratio * scale;
    final logo = KopSuratRepository.logoImage(path);
    if (logo != null) {
      return Image(
          image: logo,
          width: s,
          height: s,
          fit: BoxFit.contain,
          gaplessPlayback: true);
    }
    if (!placeholder) return SizedBox(width: s, height: s);
    return Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6 * scale),
      ),
      child: Icon(Icons.image_outlined,
          color: Colors.grey.shade400, size: s * 0.5),
    );
  }

  Widget _text(KopSuratDesign d) {
    final TextAlign textAlign;
    final CrossAxisAlignment align;
    switch (d.textAlign) {
      case 'left':
        textAlign = TextAlign.left;
        align = CrossAxisAlignment.start;
        break;
      case 'right':
        textAlign = TextAlign.right;
        align = CrossAxisAlignment.end;
        break;
      default:
        textAlign = TextAlign.center;
        align = CrossAxisAlignment.center;
    }

    final name = Text(_name,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: d.nameSize * 0.65 * scale,
            fontWeight: FontWeight.w800,
            color: _hex(d.nameColor),
            height: 1.2));
    final subtitle = kop.subtitle.trim().isEmpty
        ? null
        : Text(kop.subtitle,
            textAlign: textAlign,
            style: TextStyle(
                fontSize: 9.5 * scale,
                fontWeight: FontWeight.w700,
                color: Colors.black));

    Widget column = Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (d.subtitleFirst && subtitle != null) subtitle,
        name,
        if (!d.subtitleFirst && subtitle != null) subtitle,
        Text(_address,
            textAlign: textAlign,
            style: TextStyle(fontSize: 8 * scale, color: Colors.black87)),
        if (_contact.isNotEmpty)
          Text(_contact,
              textAlign: textAlign,
              style: TextStyle(fontSize: 8 * scale, color: Colors.black87)),
      ],
    );
    if (d.accentBar != null) {
      column = Container(
        padding: EdgeInsets.only(left: 6 * scale),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: _hex(d.accentBar!), width: 3 * scale),
          ),
        ),
        child: column,
      );
    }
    return SizedBox(width: double.infinity, child: column);
  }

  Widget _body(KopSuratDesign d) {
    final gap = SizedBox(width: 8 * scale);
    final text = _text(d);
    final logo1 = _logo(kop.logoPath, d.logoSize.toDouble());
    final logo2 = _hasSecondary || showBothLogos
        ? _logo(kop.secondaryLogoPath, d.logoSize.toDouble())
        : null;
    final logoPair = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo1,
        if (logo2 != null) ...[SizedBox(width: 4 * scale), logo2],
      ],
    );

    switch (d.layout) {
      case KopLogoLayout.sides:
        return Row(children: [
          logo1,
          gap,
          Expanded(child: text),
          gap,
          // Keep the slot so the text stays centered without a second logo.
          logo2 ?? _logo(null, d.logoSize.toDouble(), placeholder: false),
        ]);
      case KopLogoLayout.leftAndRight:
        return Row(children: [
          logo1,
          gap,
          Expanded(child: text),
          if (logo2 != null) ...[gap, logo2],
        ]);
      case KopLogoLayout.top:
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo1,
              if (logo2 != null) ...[SizedBox(width: 10 * scale), logo2],
            ],
          ),
          SizedBox(height: 4 * scale),
          text,
        ]);
      case KopLogoLayout.leftGroup:
        return Row(children: [logoPair, gap, Expanded(child: text)]);
      case KopLogoLayout.rightGroup:
        return Row(children: [Expanded(child: text), gap, logoPair]);
      case KopLogoLayout.none:
        return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = KopSuratDesigns.byId(designId);
    Widget body = _body(d);
    if (d.frameColor != null) {
      body = Container(
        padding: EdgeInsets.all(6 * scale),
        decoration: BoxDecoration(
          border: Border.all(color: _hex(d.frameColor!), width: 1 * scale),
        ),
        child: body,
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        body,
        for (var i = 0; i < d.lines.length; i++) ...[
          SizedBox(height: (i == 0 ? 6 : 1.5) * scale),
          Container(
            height: d.lines[i].thickness * 0.75 * scale,
            color: _hex(d.lines[i].color),
          ),
        ],
      ],
    );
  }
}
