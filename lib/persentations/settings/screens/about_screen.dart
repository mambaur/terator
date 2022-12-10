import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String crgStudio = 'https://caraguna.com';
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
        title: const Text(''),
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
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/terator_logo.png',
                      height: 80,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Terator adalah aplikasi yang membantu kamu membuat surat sesuai kebutuhan dengan cepat dan mudah hanya dengan satu klik saja.',
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        'Kamu juga dapat menambahkan tanda tangan digital di surat dengan elegan.',
                        textAlign: TextAlign.justify),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        'Terator juga dapat membuat surat untuk orang lain, karena tersedia multiple akun yang dapat kamu masukkan.',
                        textAlign: TextAlign.justify),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        'Download dan bagikan surat kamu ke semua orang sekarang juga!.',
                        textAlign: TextAlign.justify),
                    const SizedBox(
                      height: 45,
                    ),
                    const Text('Powered by', textAlign: TextAlign.justify),
                    GestureDetector(
                      onTap: () => _launchUrl(crgStudio),
                      child: Text(
                        'CRG Studio',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue.shade700),
                      ),
                    ),
                  ],
                ),
              )
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
