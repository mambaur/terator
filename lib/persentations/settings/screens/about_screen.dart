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
            SliverList(delegate: SliverChildListDelegate([])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
