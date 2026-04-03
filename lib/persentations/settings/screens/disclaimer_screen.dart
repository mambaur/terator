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
      appBar: AppTheme.modernAppBar(
        title: 'Disclaimer',
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // ─── Icon Header ───
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kWarning.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.gavel_rounded,
                    size: 40,
                    color: kWarning,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Disclaimer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kTextPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Harap baca dengan seksama',
                  style: TextStyle(
                    fontSize: 13,
                    color: kTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ─── Content ───
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.cardDecoration(),
            child: Column(
              children: [
                _disclaimerItem(
                  number: '1',
                  text:
                      'Kami hanya membantu proses pembuatan surat sesuai kategori yang dipilih, dan kami tidak bertanggung jawab atas segala sesuatu yang berhubungan dengan legalitas atau sanksi apabila terjadi suatu kesalahan apapun dan termasuk kesalahan yang kaitannya dengan hukum.',
                ),
                const SizedBox(height: 16),
                _disclaimerItem(
                  number: '2',
                  text:
                      'Surat yang kami sediakan masih memiliki banyak kekurangan, sehingga pengguna memiliki akses penuh untuk merubah semua text dari template surat.',
                ),
                const SizedBox(height: 16),
                _disclaimerItem(
                  number: '3',
                  text:
                      'Dengan menggunakan aplikasi kami, Anda dengan ini menyetujui Disclaimer kami dan menyetujui segala ketentuannya.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _disclaimerItem({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: kGradientPrimary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: kTextSecondary,
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
