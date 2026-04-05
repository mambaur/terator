import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:terator/persentations/faq/screens/faq_item.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: 'FAQ',
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(20),
        children: [
          BannerAdWidget(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            placement: BannerPlacement.settingPage,
          ),

          // ─── Header ───
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: AppTheme.gradientCard(kGradientPrimary),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(kRadiusSm),
                  ),
                  child: const Icon(Icons.quiz_rounded,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pertanyaan Umum',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Temukan jawaban untuk pertanyaan yang sering diajukan',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const FaqItem(
            number: 1,
            title: "Apakah membuat surat di terator gratis?",
            description:
                "Iya benar, anda dapat membuat surat pada Aplikasi Terator secara gratis.",
          ),
          const FaqItem(
            number: 2,
            title: "Apakah surat dapat di Download?",
            description:
                "Anda dapat mendownload dan membagikan surat yang sudah anda generate dengan mudah ke teman, saudara, maupun keluarga anda.",
          ),
          const FaqItem(
            number: 3,
            title: "Apa maksudnya multiple account?",
            description:
                "Artinya, anda dapat membuat surat untuk beberapa orang sekaligus dalam satu aplikasi.",
          ),
          const FaqItem(
            number: 4,
            title:
                "Apakah saya bisa merekomendasikan surat agar menjadi template di terator?",
            description:
                "Tentu, anda dapat mengirimkan surat anda sendiri ke kami untuk dijadikan sebagai template surat, silahkan masuk ke menu Rekomendasikan Surat pada halaman Pengaturan. Kemudian isi form dan upload surat anda, kami akan segera memproses surat agar menjadi template dan dapat bermanfaat untuk orang lain.",
          ),
          const FaqItem(
            number: 5,
            title: "Berapa lama proses pembuatan surat?",
            description:
                "Anda dapat membuat surat hanya dengan 1 menit saja, pilih template, tentukan untuk siapa suratnya, edit sesuai keinginan, lalu tinggal generate dan simpan.",
          ),
          const FaqItem(
            number: 6,
            title: "Apakah template surat akan selalu terupdate?",
            description:
                "Kami akan berusaha semaksimal mungkin untuk selalu memperbarui template surat agar anda semakin mudah membuat surat sesuai keinginan.",
          ),
        ],
      ),
    );
  }
}
