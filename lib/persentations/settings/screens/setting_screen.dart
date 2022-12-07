import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/settings/screens/about_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              ListTile(
                onTap: () => _launchUrl(_urlDeveloper),
                title: const Text('Aplikasi Lainnya'),
                leading: const Icon(
                  Icons.shop_outlined,
                  color: bInfo,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
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
              ListTile(
                onTap: () => _launchUrl(_urlApp),
                title: const Text('Cek Update'),
                leading: const Icon(
                  Icons.update,
                  color: bInfo,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              const ListTile(
                title: Text('Versi 1.0.0'),
                leading: Icon(
                  Icons.smartphone,
                  color: bInfo,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
