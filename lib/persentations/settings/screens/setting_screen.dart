import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:terator/persentations/settings/screens/about_screen.dart';
import 'package:terator/persentations/settings/screens/disclaimer_screen.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/persentations/subscription/widgets/premium_gate.dart';
import 'package:terator/utils/custom_snackbar.dart';
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
  // final String _feedbackUrl = 'https://forms.gle/CXNMpwH6XottdEC58';
  // final String _rekomendasi = 'https://forms.gle/etyhdKKXN3TvcE6d9';

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          BannerAdWidget(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            placement: BannerPlacement.settingPage,
          ),

          // ─── Premium Status Card ───
          BlocBuilder<SubscriptionCubit, SubscriptionState>(
            builder: (context, state) {
              return _buildPremiumStatusCard(context, state);
            },
          ),
          const SizedBox(height: 16),

          // ─── Settings Group ───
          Container(
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: [
                // ─── Contoh Fitur Premium ───
                // _buildPremiumDemoTile(context),
                // _divider(),
                _buildSettingTile(
                  icon: Icons.apps_rounded,
                  color: kInfoBlue,
                  title: 'Aplikasi Lainnya',
                  onTap: () => _launchUrl(_urlDeveloper),
                ),
                // _divider(),
                // _buildSettingTile(
                //   icon: Icons.rate_review_rounded,
                //   color: kWarning,
                //   title: 'Berikan Kritik & Saran',
                //   onTap: () => _launchUrl(_feedbackUrl),
                // ),
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
                // _divider(),
                // _buildSettingTile(
                //   icon: Icons.mail_rounded,
                //   color: const Color(0xFFEC4899),
                //   title: 'Rekomendasikan Surat',
                //   onTap: () => _launchUrl(_rekomendasi),
                // ),
                _divider(),
                // ─── Restore Pembelian ───
                _buildSettingTile(
                  icon: Icons.restore_rounded,
                  color: const Color(0xFF0EA5E9),
                  title: 'Restore Pembelian',
                  onTap: () async {
                    final cubit = context.read<SubscriptionCubit>();
                    final result = await cubit.restorePurchases();
                    if (context.mounted) {
                      CustomSnackbar.show(context,
                          type: result
                              ? SnackbarType.success
                              : SnackbarType.warning,
                          message: result
                              ? 'Pembelian berhasil di-restore! 🎉'
                              : 'Tidak ditemukan pembelian sebelumnya.');
                    }
                  },
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

  // ─── Premium Status Card ───
  Widget _buildPremiumStatusCard(
      BuildContext context, SubscriptionState state) {
    final isPremium = state.isPremium;
    return GestureDetector(
      onTap: () {
        PremiumGate.show(context);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isPremium
                ? [const Color(0xFFD97706), const Color(0xFFF59E0B)]
                : kGradientPrimary,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(kRadiusLg),
          boxShadow: isPremium
              ? [
                  BoxShadow(
                    color: const Color(0xFFD97706).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : kShadowPrimary,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(kRadiusSm),
              ),
              child: Icon(
                isPremium
                    ? Icons.workspace_premium_rounded
                    : Icons.diamond_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPremium ? 'Premium Aktif ✓' : 'Akun Gratis',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isPremium
                        ? 'Semua fitur premium telah aktif'
                        : 'Upgrade ke Premium untuk fitur lengkap',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withValues(alpha: 0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ─── Contoh Fitur Premium Tile ───
  // ignore: unused_element
  Widget _buildPremiumDemoTile(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (state.isPremium) {
                // User sudah premium — tampilkan konten
                CustomSnackbar.show(context,
                    message:
                        "🎉 Selamat! Kamu memiliki akses penuh ke fitur premium!",
                    type: SnackbarType.success);
              } else {
                // User belum premium — tampilkan premium gate
                PremiumGate.show(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                      ),
                      borderRadius: BorderRadius.circular(kRadiusSm),
                    ),
                    child: const Icon(Icons.star_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Contoh Fitur Premium',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: kTextPrimary,
                      ),
                    ),
                  ),
                  // ─── PRO Badge ───
                  if (!state.isPremium)
                    Container(
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
                  else
                    const Icon(Icons.check_circle_rounded,
                        color: kSuccess, size: 20),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: kTextMuted, size: 14),
                ],
              ),
            ),
          ),
        );
      },
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
