import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/letters/screens/letter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          // controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            // context.read<SearchWordProvider>().q = value;
                            // _refresh();
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
                  child: CachedNetworkImage(
                      width: size.width,
                      height: size.height * 0.17,
                      imageUrl:
                          "https://static.vecteezy.com/system/resources/thumbnails/002/453/533/small_2x/big-sale-discount-banner-template-promotion-illustration-free-vector.jpg",
                      fit: BoxFit.cover),
                ),
              )
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: LetterData.listLetters(),
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
                            return const Divider();
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
