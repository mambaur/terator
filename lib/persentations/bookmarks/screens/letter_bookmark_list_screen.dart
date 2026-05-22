import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/bookmarks/cubit/bookmark_cubit.dart';
import 'package:terator/persentations/letters/screens/letter_detail_screen.dart';

class LetterBookmarkListScreen extends StatelessWidget {
  const LetterBookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: 'Surat Tersimpan',
        showBack: true,
        context: context,
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

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = state.bookmarks[index];
              final isPremiumLetter =
                  premiumLetterMap[bookmark.letterKey] == true;
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
                                      color:
                                          kViolet.withValues(alpha: 0.1),
                                      borderRadius:
                                          BorderRadius.circular(6),
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
                                      colors: [
                                        Color(0xFFD97706),
                                        Color(0xFFF59E0B)
                                      ],
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
            },
          );
        },
      ),
    );
  }
}
