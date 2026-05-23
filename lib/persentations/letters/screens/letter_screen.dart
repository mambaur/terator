import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:terator/persentations/letters/screens/letter_detail_screen.dart';

class LetterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> letters;
  final String title;
  const LetterScreen({super.key, required this.letters, required this.title});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredLetters {
    if (_query.trim().isEmpty) return widget.letters;
    final q = _query.toLowerCase().trim();
    return widget.letters
        .where((e) =>
            (e['title'] as String).toLowerCase().contains(q) ||
            ((e['subtitle'] as String?) ?? '').toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredLetters;
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: widget.title,
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            slivers: [
              // ─── Search bar ───
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 48,
                    decoration: BoxDecoration(
                      color: kCardWhite,
                      borderRadius: BorderRadius.circular(kRadiusMd),
                      boxShadow: kShadowSm,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded,
                            color: kTextMuted, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) =>
                                setState(() => _query = value),
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: false,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                              ),
                              hintText: 'Cari template...',
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (_query.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            child: const Icon(Icons.close_rounded,
                                color: kTextMuted, size: 18),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // ─── Count ───
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Text(
                    '${filtered.length} template tersedia',
                    style: const TextStyle(
                      fontSize: 13,
                      color: kTextSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // ─── Empty state when no match ───
              if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: kPrimary.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search_off_rounded,
                              size: 48, color: kPrimary),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Template tidak ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Coba kata kunci yang berbeda',
                          style: TextStyle(
                            color: kTextSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final letter = filtered[index];
                      final isPremiumLetter =
                          premiumLetterMap[letter["key"]] == true;
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
                                    keyLetter: letter["key"],
                                    title: letter["title"],
                                    subtitle: letter["subtitle"],
                                    categoryTitle: widget.title,
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
                                      borderRadius:
                                          BorderRadius.circular(kRadiusSm),
                                    ),
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: kPrimary,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          letter["title"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: kTextPrimary,
                                          ),
                                        ),
                                        if (letter["subtitle"] != null) ...[
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: kViolet.withValues(
                                                  alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              letter["subtitle"],
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
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                    childCount: filtered.length,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BannerAdWidget(
              margin: const EdgeInsets.only(left: 15, right: 15),
              placement: BannerPlacement.settingPage,
            ),
          ),
        ],
      ),
    );
  }
}
