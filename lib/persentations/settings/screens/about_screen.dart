import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terator'),
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
                  children: const [
                    Text(
                      'Terator adalah aplikasi yang membantu kamu membuat surat sesuai kebutuhan dengan cepat dan mudah hanya dengan satu klik saja.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        'Kamu juga dapat menambahkan tanda tangan digital di surat dengan elegan.',
                        textAlign: TextAlign.justify),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        'Terator juga dapat membuat surat untuk orang lain, karena tersedia multiple akun yang dapat kamu masukkan.',
                        textAlign: TextAlign.justify),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        'Download dan bagikan surat kamu ke semua orang sekarang juga!.',
                        textAlign: TextAlign.justify),
                  ],
                ),
              )
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
