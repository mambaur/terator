import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/bookmark_model.dart';
import 'package:terator/persentations/bookmarks/cubit/bookmark_cubit.dart';
import 'package:terator/persentations/letters/screens/letter_detail_screen.dart';
import 'package:terator/utils/category_chips.dart';
import 'package:terator/utils/custom_snackbar.dart';
import 'package:terator/utils/search_field.dart';

class LetterBookmarkListScreen extends StatefulWidget {
  const LetterBookmarkListScreen({super.key});

  @override
  State<LetterBookmarkListScreen> createState() =>
      _LetterBookmarkListScreenState();
}

class _LetterBookmarkListScreenState extends State<LetterBookmarkListScreen> {
  String _query = '';

  /// Index into `LetterData.listLetters()`, or null for "Semua".
  int? _categoryIndex;

  /// Template keys of the selected category, or null for "Semua".
  Set<String>? _categoryKeys;

  void _selectCategory(int? index) {
    setState(() {
      _categoryIndex = index;
      _categoryKeys = index == null
          ? null
          : (LetterData.listLetters()[index]['letters'] as List<dynamic>)
              .map((l) => l['key'].toString())
              .toSet();
    });
  }

  List<BookmarkModel> _filter(List<BookmarkModel> bookmarks) {
    final q = _query.trim().toLowerCase();
    return bookmarks.where((b) {
      if (_categoryKeys != null && !_categoryKeys!.contains(b.letterKey)) {
        return false;
      }
      if (q.isEmpty) return true;
      return [b.title, b.subtitle, b.categoryTitle]
          .any((v) => v != null && v.toLowerCase().contains(q));
    }).toList();
  }

  Future<void> _confirmRemoveAll(BuildContext context) async {
    final cubit = context.read<BookmarkCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusLg),
        ),
        title: const Text(
          'Hapus Semua Bookmark?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: kTextPrimary,
          ),
        ),
        content: const Text(
          'Semua surat tersimpan akan dihapus dari bookmark. Tindakan ini tidak dapat dibatalkan.',
          style: TextStyle(color: kTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(
              'Batal',
              style: TextStyle(color: kTextSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Hapus Semua',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await cubit.removeAll();
    if (!context.mounted) return;
    CustomSnackbar.show(
      context,
      message: 'Semua bookmark berhasil dihapus.',
      type: SnackbarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: 'Surat Tersimpan',
        showBack: true,
        context: context,
        actions: [
          BlocBuilder<BookmarkCubit, BookmarkState>(
            buildWhen: (prev, curr) =>
                prev.bookmarks.isEmpty != curr.bookmarks.isEmpty,
            builder: (context, state) {
              if (state.bookmarks.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Hapus semua bookmark',
                onPressed: () => _confirmRemoveAll(context),
                icon: const Icon(
                  Icons.delete_sweep_rounded,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: kSurface,
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state.status == BookmarkStatusCubit.loading) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimary),
            );
          }
          if (state.bookmarks.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: kPrimary.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border_rounded,
                        size: 56,
                        color: kPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum Ada Surat Tersimpan',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Simpan template surat favoritmu dengan menekan ikon bookmark pada halaman detail surat.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final bookmarks = _filter(state.bookmarks);
          return Column(
            children: [
              SearchField(
                hint: 'Cari surat tersimpan...',
                onSearch: (q) => setState(() => _query = q),
              ),
              CategoryChips(
                selectedIndex: _categoryIndex,
                onSelected: _selectCategory,
              ),
              Expanded(
                child: bookmarks.isEmpty
                    ? _buildNotFound()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 12, bottom: 24),
                        itemCount: bookmarks.length,
                        itemBuilder: (context, index) =>
                            _buildItem(context, bookmarks[index]),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotFound() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 56, color: kPrimary),
            SizedBox(height: 16),
            Text(
              'Surat Tidak Ditemukan',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: kTextPrimary,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Coba kata kunci atau kategori lain',
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, BookmarkModel bookmark) {
    final isPremiumLetter = premiumLetterMap[bookmark.letterKey] == true;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      decoration: AppTheme.cardDecoration(),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(kRadiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(kRadiusLg),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => LetterDetailScreen(
                  keyLetter: bookmark.letterKey ?? '',
                  title: bookmark.title ?? '',
                  subtitle: bookmark.subtitle,
                  categoryTitle: bookmark.categoryTitle,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(kRadiusSm),
                  ),
                  child: const Icon(
                    Icons.bookmark_rounded,
                    color: kPrimary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookmark.title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: kTextPrimary,
                        ),
                      ),
                      if (bookmark.categoryTitle != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: kViolet.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            bookmark.categoryTitle!,
                            style: const TextStyle(
                              color: kViolet,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                isPremiumLetter
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kTextMuted,
                        size: 16,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
