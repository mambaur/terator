import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';
import 'package:terator/persentations/letters/screens/letter_screen.dart';
import 'package:url_launcher/url_launcher.dart';

enum StatusAd { initial, loaded }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _youtubeUrl = 'https://bit.ly/generate-surat-terator';
  BannerAd? myBanner;
  List<Map<String, dynamic>> lettersData = letterDataMap(null);

  List<Map<String, dynamic>> searchLetterData(String q) {
    return lettersData
        .where((e) => (e["title"]).toLowerCase().contains(q.toLowerCase()))
        .toList();
  }

  BannerAdListener listener() => BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('Ad Loaded.');
          }
          setState(() {
            statusAd = StatusAd.loaded;
          });
        },
      );

  StatusAd statusAd = StatusAd.initial;

  List<Map<String, dynamic>> listLetters = [];

  // Category data with gradients and icons
  List<Map<String, dynamic>> get _categories => [
        {
          'index': 0,
          'label': 'Sekolah',
          'icon': Icons.school_rounded,
          'gradient': kGradientSekolah,
          'asset': 'assets/icons/school.png',
        },
        {
          'index': 1,
          'label': 'Pekerjaan',
          'icon': Icons.work_rounded,
          'gradient': kGradientPekerjaan,
          'asset': 'assets/icons/work.png',
        },
        {
          'index': 2,
          'label': 'Desa',
          'icon': Icons.location_city_rounded,
          'gradient': kGradientDesa,
          'asset': 'assets/icons/village.png',
        },
        {
          'index': 3,
          'label': 'Bisnis',
          'icon': Icons.business_center_rounded,
          'gradient': kGradientBisnis,
          'asset': 'assets/icons/business.png',
        },
        {
          'index': 4,
          'label': 'Umum',
          'icon': Icons.public_rounded,
          'gradient': kGradientUmum,
          'asset': 'assets/icons/common.png',
        },
        {
          'index': 6,
          'label': 'Keuangan',
          'icon': Icons.account_balance_wallet_rounded,
          'gradient': kGradientKeuangan,
          'asset': 'assets/icons/keuangan.png',
        },
        {
          'index': 5,
          'label': 'Pribadi',
          'icon': Icons.person_rounded,
          'gradient': kGradientPribadi,
          'asset': 'assets/icons/pribadi.png',
        },
        {
          'index': 7,
          'label': 'Kesehatan',
          'icon': Icons.health_and_safety_rounded,
          'gradient': kGradientKesehatan,
          'asset': 'assets/icons/kesehatan.png',
        },
      ];

  @override
  void initState() {
    if (!kDebugMode) {
      myBanner = BannerAd(
        adUnitId: kDebugMode
            ? '/6499/example/banner'
            : 'ca-app-pub-2465007971338713/8992395637',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: listener(),
      );
      myBanner!.load();
    }

    listLetters = LetterData.listLetters(q: '');
    super.initState();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    if (myBanner != null) {
      myBanner!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ─── Hero Section ───
          SliverToBoxAdapter(
            child: _buildHeroSection(context),
          ),

          // ─── Quick Stats ───
          SliverToBoxAdapter(
            child: _buildQuickStats(),
          ),

          // ─── Category Section Title ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: kGradientPrimary,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
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

          // ─── Tutorial Card ───
          SliverToBoxAdapter(
            child: _buildTutorialCard(),
          ),

          // ─── Ad Banner ───
          SliverToBoxAdapter(
            child: statusAd == StatusAd.loaded
                ? Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                    alignment: Alignment.center,
                    width: myBanner!.size.width.toDouble(),
                    height: myBanner!.size.height.toDouble(),
                    child: AdWidget(ad: myBanner!),
                  )
                : const SizedBox(),
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: kGradientPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hai, Selamat Datang! 👋',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Buat surat dengan mudah dan cepat',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 18),
          // Search Bar
          Container(
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
                const Icon(Icons.search_rounded, color: kTextMuted, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: TypeAheadField<Map<String, dynamic>>(
                    builder: (context, controller, focusNode) {
                      return TextField(
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
                      );
                    },
                    suggestionsCallback: (pattern) async {
                      return searchLetterData(pattern);
                    },
                    itemBuilder: (context, suggestion) {
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
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                    onSelected: (suggestion) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterChooseAccountScreen(
                          keyLetter: suggestion['key'],
                          title: suggestion['title'],
                        );
                      }));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Quick Stats ───
  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kCardWhite,
                borderRadius: BorderRadius.circular(kRadiusLg),
                boxShadow: kShadowSm,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(kRadiusSm),
                    ),
                    child: const Icon(Icons.description_rounded,
                        color: kPrimary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('50+',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary)),
                      Text('Template',
                          style:
                              TextStyle(fontSize: 12, color: kTextSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kCardWhite,
                borderRadius: BorderRadius.circular(kRadiusLg),
                boxShadow: kShadowSm,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kViolet.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(kRadiusSm),
                    ),
                    child: const Icon(Icons.category_rounded,
                        color: kViolet, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('8',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary)),
                      Text('Kategori',
                          style:
                              TextStyle(fontSize: 12, color: kTextSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
      itemCount: _categories.length,
      itemBuilder: (context, i) {
        final cat = _categories[i];
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
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kViolet, kPrimaryLight],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
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
                    return LetterChooseAccountScreen(
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
