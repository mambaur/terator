import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/settings/screens/about_screen.dart';
import 'package:terator/persentations/settings/screens/disclaimer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

enum StatusAd { initial, loaded }

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final String _urlDeveloper =
      'https://play.google.com/store/apps/dev?id=8918426189046119136';
  final String _urlApp =
      'https://play.google.com/store/apps/details?id=com.caraguna.terator';
  final String _contactUs = 'https://nexadream.id';
  BannerAd? myBanner;

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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    if (!kDebugMode) {
      myBanner = BannerAd(
        adUnitId: 'ca-app-pub-2465007971338713/8992395637',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: listener(),
      );
      myBanner!.load();
    }
    super.initState();
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          if (statusAd == StatusAd.loaded)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              width: myBanner!.size.width.toDouble(),
              height: myBanner!.size.height.toDouble(),
              child: AdWidget(ad: myBanner!),
            ),

          // ─── Settings Group ───
          Container(
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: [
                _buildSettingTile(
                  icon: Icons.apps_rounded,
                  color: kInfoBlue,
                  title: 'Aplikasi Lainnya',
                  onTap: () => _launchUrl(_urlDeveloper),
                ),
                _divider(),
                _buildSettingTile(
                  icon: Icons.info_rounded,
                  color: kPrimary,
                  title: 'Tentang Aplikasi',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return const AboutScreen();
                    }));
                  },
                ),
                _divider(),
                _buildSettingTile(
                  icon: Icons.gavel_rounded,
                  color: kViolet,
                  title: 'Disclaimer',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return const DisclaimerScreen();
                    }));
                  },
                ),
                _divider(),
                _buildSettingTile(
                  icon: Icons.system_update_rounded,
                  color: kSuccess,
                  title: 'Cek Update',
                  onTap: () => _launchUrl(_urlApp),
                ),
                _divider(),
                _buildSettingTile(
                  icon: Icons.mail_rounded,
                  color: const Color(0xFFEC4899),
                  title: 'Hubungi Kami',
                  onTap: () => _launchUrl(_contactUs),
                ),
                _divider(),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: kTextMuted.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(kRadiusSm),
                              ),
                              child: const Icon(Icons.smartphone_rounded,
                                  color: kTextMuted, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Versi ${snapshot.data?.version}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: kTextSecondary,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: kSuccess.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Terbaru',
                                style: TextStyle(
                                  color: kSuccess,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(kRadiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: kTextPrimary,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: kTextMuted, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      indent: 58,
      endIndent: 16,
      color: Colors.grey.shade100,
    );
  }
}
