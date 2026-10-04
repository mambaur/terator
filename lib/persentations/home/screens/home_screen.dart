import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_categories.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:terator/persentations/bookmarks/cubit/bookmark_cubit.dart';
import 'package:terator/persentations/bookmarks/screens/letter_bookmark_list_screen.dart';
import 'package:terator/persentations/letters/screens/letter_detail_screen.dart';
import 'package:terator/persentations/letters/screens/letter_screen.dart';
import 'package:terator/persentations/navbar.dart';
import 'package:terator/repositories/account_repository.dart';
import 'package:terator/repositories/letter_repository.dart';
import 'package:url_launcher/url_launcher.dart';

enum StatusAd { initial, loaded }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _statsHeight = 76;

  final String _youtubeUrl =
      'https://nexadream.id/tutorial-generate-surat-terator';
  List<Map<String, dynamic>> lettersData = letterDataMap(null);

  List<Map<String, dynamic>> searchLetterData(String q) {
    return lettersData
        .where((e) => (e["title"]).toLowerCase().contains(q.toLowerCase()))
        .toList();
  }

  List<Map<String, dynamic>> listLetters = [];

  // Null until loaded. Beranda is rebuilt each time its tab is opened, so
  // loading once in initState keeps these current.
  int? _letterCount;
  int? _accountCount;

  @override
  void initState() {
    listLetters = LetterData.listLetters(q: '');
    super.initState();
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    final letters = await LetterRepository().count();
    final accounts = await AccountRepository().count();
    if (!mounted) return;
    setState(() {
      _letterCount = letters;
      _accountCount = accounts;
    });
  }

  /// Indonesian time-of-day greeting.
  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) return 'Selamat Pagi';
    if (hour >= 11 && hour < 15) return 'Selamat Siang';
    if (hour >= 15 && hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ─── Hero Section + Quick Stats (card overlaps hero by half) ───
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: _statsHeight / 2),
                  child: _buildHeroSection(context),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildQuickStats(),
                ),
              ],
            ),
          ),

          // ─── Ad Banner ───
          SliverToBoxAdapter(
            child: BannerAdWidget(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
              placement: BannerPlacement.homePage,
            ),
          ),

          // ─── Category Section Title ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
              child: Row(
                children: [
                  const Text(
                    'Kategori Surat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kTextPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Category Grid ───
          SliverToBoxAdapter(
            child: _buildCategoryGrid(context),
          ),

          // ─── Popular Templates ───
          SliverToBoxAdapter(
            child: _buildPopularSection(context),
          ),

          // ─── Bookmarked Templates ───
          SliverToBoxAdapter(
            child: _buildBookmarkSection(context),
          ),

          // ─── Tutorial Card ───
          SliverToBoxAdapter(
            child: _buildTutorialCard(),
          ),

          // Bottom padding for floating nav
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }

  // ─── Hero Section ───
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20 + _statsHeight / 2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: kGradientPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_greeting! 👋',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tersedia 100+ template surat',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 18),
          // Search Bar — TypeAheadField wraps the whole box so the results
          // dropdown is as wide as the search bar, not just the text input.
          TypeAheadField<Map<String, dynamic>>(
            builder: (context, controller, focusNode) {
              // Tapping the icon/padding focuses the input too.
              return GestureDetector(
                onTap: focusNode.requestFocus,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kRadiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded,
                          color: kTextMuted, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: false,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: false,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            hintText: 'Cari template surat...',
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              return searchLetterData(pattern);
            },
            itemBuilder: (context, suggestion) {
              bool isPremiumLetter =
                  premiumLetterMap[suggestion['key']] == true;
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.description_outlined,
                      color: kPrimary, size: 20),
                ),
                title: Text(
                  suggestion['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: isPremiumLetter
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
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
                    : null,
              );
            },
            onSelected: (suggestion) {
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return LetterDetailScreen(
                  keyLetter: suggestion['key'],
                  title: suggestion['title'],
                  subtitle: suggestion['subtitle'],
                );
              }));
            },
          ),
        ],
      ),
    );
  }

  // ─── Quick Stats ───
  Widget _buildQuickStats() {
    return Container(
      height: _statsHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _statCard(
              icon: Icons.description_rounded,
              color: kPrimary,
              value: _letterCount,
              label: 'Surat Dibuat',
              onTap: () => Navbar.switchTab(context, 1),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _statCard(
              icon: Icons.people_alt_rounded,
              color: kViolet,
              value: _accountCount,
              label: 'Akun Surat',
              onTap: () => Navbar.switchTab(context, 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color color,
    required int? value,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(kRadiusLg),
        boxShadow: kShadowMd,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(kRadiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(kRadiusSm),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value?.toString() ?? '-',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary)),
                      Text(label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: kTextSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Category Grid ───
  Widget _buildCategoryGrid(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: letterCategories.length,
      itemBuilder: (context, i) {
        final cat = letterCategories[i];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return LetterScreen(
                letters: listLetters[cat['index']]["letters"],
                title: listLetters[cat['index']]["title"],
              );
            }));
          },
          child: Container(
            decoration: BoxDecoration(
              color: kCardWhite,
              borderRadius: BorderRadius.circular(kRadiusLg),
              boxShadow: kShadowSm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: cat['gradient'],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(kRadiusSm),
                  ),
                  child: Icon(cat['icon'], color: Colors.white, size: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  cat['label'],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: kTextPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Popular Templates Section ───
  Widget _buildPopularSection(BuildContext context) {
    // Grab a few popular template names from different categories
    final List<Map<String, dynamic>> popularItems = [
      {
        'key': 'surat_izin_tidak_masuk_sekolah',
        'title': 'Surat Izin Tidak Masuk Sekolah',
        'icon': Icons.school_rounded,
        'color': kGradientSekolah,
      },
      {
        'key': 'surat_lamaran_pekerjaan',
        'title': 'Surat Lamaran Pekerjaan',
        'icon': Icons.work_rounded,
        'color': kGradientPekerjaan,
      },
      {
        'key': 'surat_pengunduran_diri',
        'title': 'Surat Pengunduran Diri',
        'icon': Icons.exit_to_app_rounded,
        'color': kGradientBisnis,
      },
      {
        'key': 'surat_keterangan_domisili',
        'title': 'Surat Keterangan Domisili',
        'icon': Icons.location_city_rounded,
        'color': kGradientDesa,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
          child: Row(
            children: [
              const Text(
                'Surat Populer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.local_fire_department_rounded,
                  color: kWarning, size: 20),
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: popularItems.length,
            itemBuilder: (context, i) {
              final item = popularItems[i];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return LetterDetailScreen(
                      keyLetter: item['key'],
                      title: item['title'],
                    );
                  }));
                },
                child: Container(
                  width: 200,
                  margin: EdgeInsets.only(
                      right: i < popularItems.length - 1 ? 12 : 0),
                  padding: const EdgeInsets.all(14),
                  decoration: AppTheme.gradientCard(item['color']),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            Icon(item['icon'], color: Colors.white, size: 20),
                      ),
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── Bookmark Section ───
  Widget _buildBookmarkSection(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state.bookmarks.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
              child: Row(
                children: [
                  const Text(
                    'Surat Tersimpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kTextPrimary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) =>
                              const LetterBookmarkListScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kPrimary,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.arrow_forward_rounded,
                            color: kPrimary, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ...state.bookmarks.take(3).map((bookmark) {
              final isPremiumLetter =
                  premiumLetterMap[bookmark.letterKey] == true;
              return Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: kPrimary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(kRadiusSm),
                            ),
                            child: const Icon(
                              Icons.bookmark_rounded,
                              color: kPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              bookmark.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: kTextPrimary,
                              ),
                            ),
                          ),
                          if (isPremiumLetter)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
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
                          else
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: kTextMuted, size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  // ─── Tutorial Card ───
  Widget _buildTutorialCard() {
    return GestureDetector(
      onTap: () => _launchUrl(_youtubeUrl),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: kCardWhite,
          borderRadius: BorderRadius.circular(kRadiusLg),
          boxShadow: kShadowSm,
          border: Border.all(color: kPrimary.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: kGradientPrimary),
                borderRadius: BorderRadius.circular(kRadiusMd),
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lihat Tutorial',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: kTextPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Bikin surat hanya dalam 1 menit',
                    style: TextStyle(
                      color: kTextSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: kTextMuted, size: 16),
          ],
        ),
      ),
    );
  }
}
