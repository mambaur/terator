import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/letters/screens/letter_editor_screen.dart';
import 'package:terator/persentations/navbar.dart';
import 'package:terator/repositories/account_repository.dart';

class LetterChooseAccountScreen extends StatefulWidget {
  final String keyLetter, title;
  const LetterChooseAccountScreen(
      {super.key, required this.keyLetter, required this.title});

  @override
  State<LetterChooseAccountScreen> createState() =>
      _LetterChooseAccountScreenState();
}

class _LetterChooseAccountScreenState extends State<LetterChooseAccountScreen> {
  final AccountRepository _accountRepo = AccountRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Surat Untuk Siapa?", style: TextStyle(color: bDark)),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<AccountModel>>(
          future: _accountRepo.all(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Image.asset("assets/img/empty.png")),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Yah, data akun kamu\nmasih kosong :(',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: bDark),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil<void>(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const Navbar(
                                          selectedIndex: 2,
                                        )),
                                ModalRoute.withName('/account-screen'),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15),
                              child: Text('+ Tambahkan Akun'),
                            ))
                      ]),
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.only(top: 15),
                itemBuilder: ((context, index) {
                  return Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.1),
                        //     blurRadius: 7,
                        //     offset: const Offset(1, 3),
                        //   )
                        // ],
                      ),
                      child: ListTile(
                        onTap: () {
                          if (snapshot.data![index].signatureImage != null) {
                            _showSignatureOptionModal(snapshot.data![index]);
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (builder) {
                              return LetterEditorScreen(
                                title: widget.title,
                                keyLetter: widget.keyLetter,
                                account: snapshot.data![index],
                                withSignature: false,
                              );
                            }));
                          }
                        },
                        title: Text(
                          snapshot.data![index].name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                            snapshot.data![index].address != null &&
                                    snapshot.data![index].address != ''
                                ? snapshot.data![index].address!
                                : (snapshot.data![index].telephone ?? ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        leading: const Icon(Icons.face, color: bSecondary),
                      ));
                }),
              );
            }
            return const SizedBox();
          }),
    );
  }

  Future<void> _showSignatureOptionModal(AccountModel account) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Tanda Tangan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Apakah kamu ingin menggunakan tanda tangan?',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text('Tidak',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return LetterEditorScreen(
                                    title: widget.title,
                                    keyLetter: widget.keyLetter,
                                    account: account,
                                    withSignature: false,
                                  );
                                }));
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bInfo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text('Iya',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return LetterEditorScreen(
                                    title: widget.title,
                                    keyLetter: widget.keyLetter,
                                    account: account,
                                    withSignature: true,
                                  );
                                }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
