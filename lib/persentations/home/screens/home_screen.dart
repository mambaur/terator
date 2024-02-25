import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';
import 'package:terator/persentations/letters/screens/letter_screen.dart';

enum StatusAd { initial, loaded }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? myBanner;
  List<Map<String, dynamic>> lettersData = letterDataMap(null);

  List<Map<String, dynamic>> searchLetterData(String q) {
    return lettersData
        .where((e) => (e["title"]).toLowerCase().contains(q.toLowerCase()))
        .toList();
  }

  BannerAdListener listener() => BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('Ad Loaded.');
          }
          setState(() {
            statusAd = StatusAd.loaded;
          });
        },
      );

  StatusAd statusAd = StatusAd.initial;

  List<Map<String, dynamic>> listLetters = [];

  @override
  void initState() {
    if (!kDebugMode) {
      myBanner = BannerAd(
        adUnitId: kDebugMode
            ? '/6499/example/banner'
            : 'ca-app-pub-2465007971338713/8992395637',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: listener(),
      );
      myBanner!.load();
    }

    listLetters = LetterData.listLetters(q: '');
    super.initState();
  }

  @override
  void dispose() {
    if (myBanner != null) {
      myBanner!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: const Text(
                        'Hai, Selamat Datang!',
                        style: TextStyle(
                            fontSize: 20,
                            color: bDark,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: const Text(
                        'Di Surat Generator',
                        style: TextStyle(fontSize: 14, color: bDark),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 15, right: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 55,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TypeAheadField<Map<String, dynamic>>(
                              builder: (context, controller, focusNode) {
                                return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // contentPadding: const EdgeInsets.all(15),
                                        hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 14),
                                        hintText: 'Lagi mau bikin surat apa?'));
                              },
                              suggestionsCallback: (pattern) async {
                                return searchLetterData(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  leading:
                                      const Icon(Icons.description_outlined),
                                  title: Text(suggestion['title']),
                                );
                              },
                              onSelected: (suggestion) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return LetterChooseAccountScreen(
                                    keyLetter: suggestion['key'],
                                    title: suggestion['title'],
                                  );
                                }));
                              },
                            ),
                          ),
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      // width: size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/img/banner.jpg',
                            width: size.width,
                            // height: size.height * 0.12,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ])),
            // SliverList(
            //     delegate: SliverChildListDelegate([
            //   statusAd == StatusAd.loaded
            //       ? Container(
            //           margin: const EdgeInsets.only(
            //               left: 15, right: 15, bottom: 15),
            //           alignment: Alignment.center,
            //           width: myBanner!.size.width.toDouble(),
            //           height: myBanner!.size.height.toDouble(),
            //           child: AdWidget(ad: myBanner!),
            //         )
            //       : const SizedBox(),
            //   Container(
            //     margin:
            //         const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            //     // width: size.width,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(5),
            //       child: Image.asset('assets/img/banner.jpg',
            //           width: size.width,
            //           // height: size.height * 0.12,
            //           fit: BoxFit.cover),
            //     ),
            //   ),
            // ])),
            SliverList(
                delegate: SliverChildListDelegate([
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 25, top: 25),
                shrinkWrap: true,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 4,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterScreen(
                          letters: listLetters[0]["letters"],
                          title: listLetters[0]["title"],
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.asset('assets/icons/school.png'),
                          )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Sekolah',
                              style: TextStyle(fontSize: 12, color: bDark))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterScreen(
                          letters: listLetters[1]["letters"],
                          title: listLetters[1]["title"],
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/icons/work.png'),
                          )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Pekerjaan',
                              style: TextStyle(fontSize: 12, color: bDark))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterScreen(
                          letters: listLetters[2]["letters"],
                          title: listLetters[2]["title"],
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset('assets/icons/village.png'),
                          )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Desa',
                              style: TextStyle(fontSize: 12, color: bDark))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterScreen(
                          letters: listLetters[3]["letters"],
                          title: listLetters[3]["title"],
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset('assets/icons/business.png'),
                          )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Bisnis',
                              style: TextStyle(fontSize: 12, color: bDark))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterScreen(
                          letters: listLetters[4]["letters"],
                          title: listLetters[4]["title"],
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset('assets/icons/common.png'),
                          )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Umum',
                              style: TextStyle(fontSize: 12, color: bDark))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/icons/keuangan.png'),
                        )),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text('Keuangan',
                            style: TextStyle(fontSize: 12, color: bDark))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/icons/pribadi.png'),
                        )),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text('Pribadi',
                            style: TextStyle(fontSize: 12, color: bDark))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/icons/kesehatan.png'),
                        )),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text('Kesehatan',
                            style: TextStyle(fontSize: 12, color: bDark))
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // launchUrl(
                  //     Uri.parse("https://www.youtube.com/watch?v=0023umP7Rn0"),
                  //     mode: LaunchMode.externalApplication);
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lihat Tutorial",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: bDark)),
                            Text("Bikin surat hanya dalam 1 menit",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: bInfo),
                        child: const Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 20),
                      )
                    ],
                  ),
                ),
              ),
              statusAd == StatusAd.loaded
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      alignment: Alignment.center,
                      width: myBanner!.size.width.toDouble(),
                      height: myBanner!.size.height.toDouble(),
                      child: AdWidget(ad: myBanner!),
                    )
                  : const SizedBox(),
            ])),
          ]),
    );
  }
}
