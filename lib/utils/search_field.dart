import 'dart:async';

import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';

/// Search box used at the top of list screens (File Saya, Akun Surat,
/// Surat Tersimpan).
/// [onSearch] fires 300ms after the user stops typing, and right away when
/// the text is cleared.
class SearchField extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onSearch;
  final EdgeInsets padding;

  const SearchField({
    super.key,
    required this.hint,
    required this.onSearch,
    this.padding = const EdgeInsets.fromLTRB(20, 16, 20, 0),
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onChanged(String value) {
    setState(() {}); // toggles the clear button
    _debounce?.cancel();
    _debounce =
        Timer(const Duration(milliseconds: 300), () => widget.onSearch(value));
  }

  void _clear() {
    _debounce?.cancel();
    _controller.clear();
    setState(() {});
    widget.onSearch('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kRadiusMd),
      borderSide: BorderSide(color: Colors.grey.shade200),
    );
    return Padding(
      padding: widget.padding,
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: kTextMuted, fontSize: 14),
          prefixIcon:
              const Icon(Icons.search_rounded, color: kTextMuted, size: 22),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: kTextMuted, size: 20),
                  onPressed: _clear,
                ),
          filled: true,
          fillColor: kCardWhite,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: border,
          enabledBorder: border,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusMd),
            borderSide: const BorderSide(color: kPrimary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
