import 'dart:convert';

enum LetterVariableType {
  text,
  multiline,

  /// Picked with a date picker, rendered as "d MMMM yyyy".
  date,

  /// Picked with a date picker, rendered as "EEEE, d MMMM yyyy".
  dateWithDay,
  number,

  /// Digits only, rendered with thousand separators (the "Rp " prefix lives
  /// in the template).
  currency,

  /// One of [LetterVariable.options].
  choice,
}

/// A fillable field of a letter template. Each template file declares its own
/// `const List<LetterVariable> suratXxxVariables` and renders every field
/// through [fillVar], so a skipped field keeps its bold placeholder.
class LetterVariable {
  final String key;
  final String label;
  final LetterVariableType type;
  final String? hint;
  final List<String> options;

  const LetterVariable({
    required this.key,
    required this.label,
    this.type = LetterVariableType.text,
    this.hint,
    this.options = const [],
  });
}

const _htmlEscape = HtmlEscape(HtmlEscapeMode.element);

/// Returns the user's value for [key] (wrapped in [prefix]/[suffix]), or the
/// original bold [placeholder] when the value was left empty.
String fillVar(
  Map<String, String>? vars,
  String key,
  String placeholder, {
  String prefix = '',
  String suffix = '',
}) {
  final value = vars?[key]?.trim() ?? '';
  if (value.isEmpty) return '<b>$placeholder</b>';
  return '$prefix${_htmlEscape.convert(value).replaceAll('\n', '<br>')}$suffix';
}
