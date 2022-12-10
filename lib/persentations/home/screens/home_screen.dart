import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/letters/screens/letter_screen.dart';
import 'package:terator/persentations/navbar.dart';

enum StatusAd { initial, loaded }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  BannerAd? myBanner;

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

  // AppUpdateInfo? _updateInfo;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.startFlexibleUpdate().then((_) {
          InAppUpdate.completeFlexibleUpdate().then((_) {
            // showSnack("Success!");
          }).catchError((e) {
            if (kDebugMode) print(e.toString());
          });
        }).catchError((e) {
          if (kDebugMode) print(e.toString());
        });
      }
    }).catchError((e) {
      if (kDebugMode) print(e.toString());
    });
  }

  @override
  void initState() {
    myBanner = BannerAd(
      // test banner
      adUnitId: '/6499/example/banner',

      // adUnitId: 'ca-app-pub-2465007971338713/8992395637',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener(),
    );
    myBanner!.load();
    checkForUpdate();
    super.initState();
  }

  @override
  void dispose() {
    myBanner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 7,
                        offset: const Offset(1, 3),
                      )
                    ],
                    // border: Border.all(
                    //     color: Style.hexToColor('#23074d')),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontSize: 14),
                              hintText: 'Cari template surat..'),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.search, color: bSecondary)
                    ],
                  ),
                ),
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.all(15),
                // width: size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset('assets/img/banner.jpg',
                      width: size.width,
                      // height: size.height * 0.12,
                      fit: BoxFit.cover),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 15, bottom: 25),
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
                            Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Navbar(
                                        selectedIndex: 1,
                                      )),
                              ModalRoute.withName('/account-screen'),
                            );
                          },
                          title: const Text('File Saya'),
                          leading: const Text('📂'),
                        )),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 5, right: 15, bottom: 25),
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
                          title: const Text('Akun'),
                          leading: const Text('👦'),
                        )),
                  )
                ],
              )
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              statusAd == StatusAd.loaded
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      alignment: Alignment.center,
                      width: myBanner!.size.width.toDouble(),
                      height: myBanner!.size.height.toDouble(),
                      child: AdWidget(ad: myBanner!),
                    )
                  : Container(),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: LetterData.listLetters(q: _searchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
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
                                    return LetterScreen(
                                      letters: snapshot.data![index]["letters"],
                                      title: snapshot.data![index]["title"],
                                    );
                                  }));
                                },
                                title: Text(snapshot.data![index]["title"]),
                                leading: const Icon(Icons.description_outlined,
                                    color: bInfo),
                                trailing: const Icon(Icons.trending_flat,
                                    color: bSecondary),
                              ));
                        },
                        separatorBuilder: (context, index) {
                          if (index == 2) {
                            return Container();
                            // return const Divider();
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ])),
          ]),
    );
  }
}
