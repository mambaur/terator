import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  final String _feedbackUrl = 'https://forms.gle/CXNMpwH6XottdEC58';
  BannerAd? myBanner;

  BannerAdListener listener() => BannerAdListener(
        // Called when an ad is successfully received.
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
        // test banner
        // adUnitId: '/6499/example/banner',

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
      // appBar: AppBar(
      //   title: const Text('Pengaturan'),
      //   centerTitle: true,
      //   foregroundColor: bDark,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      // backgroundColor: Colors.white,
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              statusAd == StatusAd.loaded
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      alignment: Alignment.center,
                      width: myBanner!.size.width.toDouble(),
                      height: myBanner!.size.height.toDouble(),
                      child: AdWidget(ad: myBanner!),
                    )
                  : const SizedBox(),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () => _launchUrl(_urlDeveloper),
                      title: const Text('Aplikasi Lainnya'),
                      leading: const Icon(
                        Icons.shop_outlined,
                        color: bInfo,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () => _launchUrl(_feedbackUrl),
                      title: const Text('Berikan Kritik & Saran'),
                      leading: const Icon(
                        Icons.feedback_outlined,
                        color: bInfo,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return const AboutScreen();
                        }));
                      },
                      title: const Text('Tentang Aplikasi'),
                      leading: const Icon(
                        Icons.info_outline,
                        color: bInfo,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return const DisclaimerScreen();
                        }));
                      },
                      title: const Text('Disclaimer'),
                      leading: const Icon(
                        Icons.front_hand_outlined,
                        color: bInfo,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () => _launchUrl(_urlApp),
                      title: const Text('Cek Update'),
                      leading: const Icon(
                        Icons.update,
                        color: bInfo,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text('Versi 1.0.0'),
                      leading: Icon(
                        Icons.smartphone,
                        color: bInfo,
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
