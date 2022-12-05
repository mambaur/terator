import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/letters/screens/letter_editor_screen.dart';

class LetterScreen extends StatefulWidget {
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Surat Izin Sekolah', style: TextStyle(color: bDark)),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.help_outline, color: bSecondary))
        ],
      ),
      body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 15,
              ),
              Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                        return LetterEditorScreen(
                          account: AccountModel(id: 1),
                        );
                      }));
                    },
                    title: Text('Surat Izin Tidak Masuk'),
                    leading: Icon(Icons.description_outlined, color: bInfo),
                    trailing: Icon(Icons.trending_flat, color: bSecondary),
                  )),
              Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                        return LetterEditorScreen(
                          account: AccountModel(id: 1),
                        );
                      }));
                    },
                    title: Text('Surat Izin Orang Tua'),
                    leading: Icon(Icons.description_outlined, color: bInfo),
                    trailing: Icon(Icons.trending_flat, color: bSecondary),
                  )),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
