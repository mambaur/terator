import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
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
                      'Kami hanya membantu proses pembuatan surat sesuai kategori yang dipilih, dan kami tidak bertanggung jawab atas segala sesuatu yang berhubungan dengan legalitas atau sanksi apabila terjadi suatu kesalahan apapun dan termasuk kesalahan yang kaitannya dengan hukum.',
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        'Surat yang kami sediakan masih memiliki banyak kekurangan, sehingga pengguna memiliki akses penuh untuk merubah semua text dari template surat.',
                        textAlign: TextAlign.justify),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        'Dengan menggunakan aplikasi kami, Anda dengan ini menyetujui Disclaimer kami dan menyetujui segala ketentuannya.',
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
