import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';

class MyFileScreen extends StatefulWidget {
  const MyFileScreen({super.key});

  @override
  State<MyFileScreen> createState() => _MyFileScreenState();
}

class _MyFileScreenState extends State<MyFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
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
                      _showDetailFileModal();
                    },
                    title: Text(
                      'Surat Izin Sekolah',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('Monday, 12 Januari 2022 12:00',
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    leading: Icon(Icons.picture_as_pdf, color: bSecondary),
                    trailing:
                        Icon(Icons.keyboard_arrow_down, color: bSecondary),
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
                      _showDetailFileModal();
                    },
                    title: Text(
                      'Surat Izin Sekolah',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('Monday, 12 Januari 2022 12:00',
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    leading: Icon(Icons.picture_as_pdf, color: bSecondary),
                    trailing:
                        Icon(Icons.keyboard_arrow_down, color: bSecondary),
                  )),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }

  Future<void> _showDetailFileModal() {
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
                      '📃 Surat Izin Sekolah',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text('Berbagi'),
                      leading: Icon(
                        Icons.share,
                        color: bInfo,
                      ),
                    ),
                    ListTile(
                      title: Text('Download'),
                      leading: Icon(
                        Icons.download,
                        color: bSecondary,
                      ),
                    ),
                    ListTile(
                      title: Text('Hapus'),
                      leading: Icon(
                        Icons.delete,
                        color: bDanger,
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
