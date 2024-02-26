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
              title: "Helo world",
              description:
                  "Sunt cupidatat dolor mollit ea ad. Aute labore incididunt non ipsum Lorem enim aute incididunt. Est ullamco voluptate voluptate excepteur aliqua sit eiusmod. Aliquip id non velit pariatur cupidatat laboris dolor. Culpa ut non exercitation irure voluptate."),
          FaqItem(
              title: "Helo world",
              description:
                  "Sit consectetur occaecat adipisicing aute. Sint ad irure elit occaecat cupidatat id consequat consequat sunt mollit enim. Lorem aute enim voluptate fugiat nostrud ut veniam deserunt adipisicing ut incididunt. Veniam est et excepteur in sunt et do sunt."),
        ],
      ),
    );
  }
}
