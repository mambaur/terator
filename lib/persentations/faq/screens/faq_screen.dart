import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
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
      appBar: AppBar(
        title: const Text('FAQ'),
        foregroundColor: bDark,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(15),
        children: const [
          FaqItem(
              title: "Apakah membuat surat di terator gratis?",
              description:
                  "Iya benar, anda dapat membuat surat pada Aplikasi Terator secara gratis."),
          FaqItem(
              title: "Apakah surat dapat di Download?",
              description:
                  "Anda dapat mendownload dan membagikan surat yang sudah anda generate dengan mudah ke teman, saudara, maupun keluarga anda."),
          FaqItem(
              title: "Apa maksudnya multiple account?",
              description:
                  "Artinya, anda dapat membuat surat untuk beberapa orang sekaligus dalam satu aplikasi."),
          FaqItem(
              title:
                  "Apakah saya bisa merekomendasikan surat agar menjadi template di terator?",
              description:
                  "Tentu, anda dapat mengirimkan surat anda sendiri ke kami untuk dijadikan sebagai template surat, silahkan masuk ke menu Rekomendasikan Surat pada halaman Pengaturan. Kemudian isi form dan upload surat anda, kami akan segera memproses surat agar menjadi template dan dapat bermanfaat untuk orang lain."),
          FaqItem(
              title: "Berapa lama proses pembuatan surat?",
              description:
                  "Anda dapat membuat surat hanya dengan 1 menit saja, pilih template, tentukan untuk siapa suratnya, edit sesuai keinginan, lalu tinggal generate dan simpan."),
          FaqItem(
              title: "Apakah template surat akan selalu terupdate?",
              description:
                  "Kami akan berusaha semaksimal mungkin untuk selalu memperbarui template surat agar anda semakin mudah membuat surat sesuai keinginan."),
        ],
      ),
    );
  }
}
