import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_categories.dart';

/// Horizontal "Semua" + letter-category filter chips used on list screens
/// (File Saya, Surat Tersimpan). [selectedIndex] is an index into
/// `LetterData.listLetters()`, or null for "Semua".
class CategoryChips extends StatelessWidget {
  final int? selectedIndex;
  final ValueChanged<int?> onSelected;

  const CategoryChips({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
        children: [
          _chip(
            label: 'Semua',
            icon: Icons.apps_rounded,
            color: kPrimary,
            selected: selectedIndex == null,
            onTap: () => onSelected(null),
          ),
          for (final cat in letterCategories)
            _chip(
              label: cat['label'],
              icon: cat['icon'],
              color: (cat['gradient'] as List<Color>).first,
              selected: selectedIndex == cat['index'],
              onTap: () => onSelected(cat['index']),
            ),
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required IconData icon,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: selected ? color : kCardWhite,
            borderRadius: BorderRadius.circular(kRadiusFull),
            border: Border.all(color: selected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: selected ? Colors.white : color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : kTextPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
