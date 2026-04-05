import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String nexadream = 'https://nexadream.id';
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: 'Tentang Aplikasi',
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // ─── Logo Section ───
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kPrimary.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/img/terator_logo.png',
                    height: 64,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'TERATOR',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kTextPrimary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Template Surat Generator',
                  style: TextStyle(
                    fontSize: 13,
                    color: kTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          BannerAdWidget(
            margin: EdgeInsets.only(top: 16),
            placement: BannerPlacement.aboutPage,
          ),

          const SizedBox(height: 16),

          // ─── Description ───
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureItem(
                  icon: Icons.bolt_rounded,
                  color: kWarning,
                  title: 'Cepat & Mudah',
                  desc:
                      'Buat surat sesuai kebutuhan hanya dengan satu klik saja.',
                ),
                const SizedBox(height: 16),
                _featureItem(
                  icon: Icons.draw_rounded,
                  color: kPrimary,
                  title: 'Tanda Tangan Digital',
                  desc:
                      'Tambahkan tanda tangan digital di surat dengan elegan.',
                ),
                const SizedBox(height: 16),
                _featureItem(
                  icon: Icons.group_rounded,
                  color: kViolet,
                  title: 'Multi Akun',
                  desc:
                      'Buat surat untuk orang lain dengan fitur multiple akun.',
                ),
                const SizedBox(height: 16),
                _featureItem(
                  icon: Icons.share_rounded,
                  color: kSuccess,
                  title: 'Bagikan',
                  desc: 'Download dan bagikan surat kamu ke semua orang!',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ─── Powered By ───
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: [
                const Text(
                  'Powered by',
                  style: TextStyle(
                    color: kTextSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => _launchUrl(nexadream),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: kGradientPrimary,
                    ).createShader(bounds),
                    child: const Text(
                      'PT Nexadream\nInovasi Digital',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _featureItem({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(kRadiusSm),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: kTextPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  color: kTextSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
