import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                      // _showDetailFileModal();
                    },
                    title: Text(
                      'Roziq Alwi',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('Surabaya',
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    leading: Icon(Icons.face, color: bSecondary),
                    trailing:
                        Icon(Icons.delete_forever_outlined, color: bSecondary),
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
                      // _showDetailFileModal();
                    },
                    title: Text(
                      'Zakia Fhadillah',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('Surabaya',
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    leading: Icon(Icons.face, color: bSecondary),
                    trailing:
                        Icon(Icons.delete_forever_outlined, color: bSecondary),
                  )),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: bInfo,
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
