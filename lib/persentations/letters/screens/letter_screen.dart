import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';

class LetterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> letters;
  final String title;
  const LetterScreen({super.key, required this.letters, required this.title});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(color: bDark)),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help_outline, color: bSecondary))
        ],
      ),
      body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.letters.length,
                padding: const EdgeInsets.only(top: 15),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 7,
                            offset: const Offset(1, 3),
                          )
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return LetterChooseAccountScreen(
                              title: widget.letters[index]["title"],
                              keyLetter: widget.letters[index]["key"],
                            );
                          }));
                        },
                        title: Text(widget.letters[index]["title"]),
                        leading: const Icon(Icons.description_outlined,
                            color: bInfo),
                        trailing:
                            const Icon(Icons.trending_flat, color: bSecondary),
                      ));
                },
              ),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
