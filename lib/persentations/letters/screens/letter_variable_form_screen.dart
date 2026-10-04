import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/letter_variable.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';

/// Optional step before choosing an Akun Surat: fills the template's
/// variables. Empty fields (or "Lewati") keep the bold placeholders.
class LetterVariableFormScreen extends StatefulWidget {
  final String keyLetter;
  final String title;
  final List<LetterVariable> variables;

  const LetterVariableFormScreen({
    super.key,
    required this.keyLetter,
    required this.title,
    required this.variables,
  });

  @override
  State<LetterVariableFormScreen> createState() =>
      _LetterVariableFormScreenState();
}

class _LetterVariableFormScreenState extends State<LetterVariableFormScreen> {
  late final Map<String, TextEditingController> _controllers = {
    for (final v in widget.variables) v.key: TextEditingController(),
  };
  final Map<String, String> _choices = {};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, String> get _values => {
        for (final v in widget.variables)
          v.key: v.type == LetterVariableType.choice
              ? (_choices[v.key] ?? '')
              : _controllers[v.key]!.text.trim(),
      }..removeWhere((_, value) => value.isEmpty);

  void _next({required bool skip}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LetterChooseAccountScreen(
          keyLetter: widget.keyLetter,
          title: widget.title,
          vars: skip ? const {} : _values,
        ),
      ),
    );
  }

  Future<void> _pickDate(LetterVariable v) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    final pattern = v.type == LetterVariableType.dateWithDay
        ? 'EEEE, d MMMM yyyy'
        : 'd MMMM yyyy';
    setState(() {
      _controllers[v.key]!.text = DateFormat(pattern, 'id_ID').format(picked);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filled = _values.length;
    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppTheme.modernAppBar(
        title: 'Isi Data Surat',
        showBack: true,
        context: context,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kBgLavender,
              borderRadius: BorderRadius.circular(kRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.edit_note_rounded, color: kPrimary, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Semua isian bersifat opsional. Isian yang dikosongkan '
                        'akan tetap menjadi teks tebal yang bisa kamu edit di '
                        'editor.',
                        style: TextStyle(
                            fontSize: 12, color: kTextSecondary, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: widget.variables.map(_buildField).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: BoxDecoration(
            color: kCardWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          // Fixed height so the outlined and gradient buttons match.
          child: SizedBox(
            height: 52,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadiusMd),
                      ),
                    ),
                    onPressed: () => _next(skip: true),
                    child: const Text(
                      'Lewati',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: AppTheme.gradientButton(
                    label: filled > 0
                        ? 'Lanjut ($filled/${widget.variables.length})'
                        : 'Lanjut',
                    icon: Icons.arrow_forward_rounded,
                    padding: EdgeInsets.zero,
                    onTap: () => _next(skip: false),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(LetterVariable v) {
    Widget field;
    switch (v.type) {
      case LetterVariableType.choice:
        field = DropdownButtonFormField<String>(
          initialValue: _choices[v.key],
          isExpanded: true,
          decoration: AppTheme.inputDecoration(
            label: v.label,
            prefixIcon: Icons.list_rounded,
          ),
          items: v.options
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          onChanged: (value) => setState(() {
            if (value == null) {
              _choices.remove(v.key);
            } else {
              _choices[v.key] = value;
            }
          }),
        );
        break;
      case LetterVariableType.date:
      case LetterVariableType.dateWithDay:
        field = TextFormField(
          controller: _controllers[v.key],
          readOnly: true,
          onTap: () => _pickDate(v),
          decoration: AppTheme.inputDecoration(
            label: v.label,
            hint: 'Pilih tanggal',
            prefixIcon: Icons.calendar_today_rounded,
          ).copyWith(
            suffixIcon: _controllers[v.key]!.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18),
                    onPressed: () =>
                        setState(() => _controllers[v.key]!.clear()),
                  ),
          ),
        );
        break;
      case LetterVariableType.currency:
        field = TextFormField(
          controller: _controllers[v.key],
          keyboardType: TextInputType.number,
          inputFormatters: [_ThousandsFormatter()],
          onChanged: (_) => setState(() {}),
          decoration: AppTheme.inputDecoration(
            label: v.label,
            hint: v.hint ?? 'Contoh: 1.500.000',
            prefixIcon: Icons.payments_outlined,
          ).copyWith(prefixText: 'Rp '),
        );
        break;
      case LetterVariableType.number:
        field = TextFormField(
          controller: _controllers[v.key],
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (_) => setState(() {}),
          decoration: AppTheme.inputDecoration(
            label: v.label,
            hint: v.hint,
            prefixIcon: Icons.numbers_rounded,
          ),
        );
        break;
      case LetterVariableType.multiline:
      case LetterVariableType.text:
        final multiline = v.type == LetterVariableType.multiline;
        field = TextFormField(
          controller: _controllers[v.key],
          minLines: 1,
          maxLines: multiline ? 4 : 1,
          keyboardType:
              multiline ? TextInputType.multiline : TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          decoration: AppTheme.inputDecoration(
            label: v.label,
            hint: v.hint,
            prefixIcon: multiline ? Icons.notes_rounded : Icons.edit_outlined,
          ),
        );
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: field,
    );
  }
}

/// Formats digits as Indonesian thousands ("1500000" → "1.500.000").
class _ThousandsFormatter extends TextInputFormatter {
  final NumberFormat _format = NumberFormat.decimalPattern('id_ID');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return const TextEditingValue();
    if (digits.length > 15) return oldValue;
    final text = _format.format(int.parse(digits));
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
