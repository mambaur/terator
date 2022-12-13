// ignore_for_file: use_build_context_synchronously

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/account/account_cubits/cubit/account_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/persentations/account/screens/account_create_screen.dart';
import 'package:terator/persentations/account/screens/account_update_screen.dart';
import 'package:terator/repositories/account_repository.dart';

enum StatusAd { initial, loaded }

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ScrollController _scrollController = ScrollController();
  final AccountRepository _accountRepo = AccountRepository();
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

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll &&
        !context.read<AccountCubit>().hasReachMax) {
      context.read<AccountCubit>().getAccounts(isInit: false);
    }
  }

  Future<void> _refresh() async {
    context.read<AccountCubit>().getAccounts(isInit: true);
  }

  Future<void> delete(AccountModel account) async {
    LoadingOverlay.show(context);
    await _accountRepo.delete(account.id!);
    _refresh();
    LoadingOverlay.hide(context);
    CoolAlert.show(
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      title: "Sukses!!!",
      text: "Akun berhasil dihapus!",
    );
  }

  @override
  void initState() {
    context.read<AccountCubit>().getAccounts(isInit: true);
    myBanner = BannerAd(
      // test banner
      // adUnitId: '/6499/example/banner',

      adUnitId: 'ca-app-pub-2465007971338713/8992395637',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener(),
    );
    myBanner!.load();

    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    myBanner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.blue.shade700,
        displacement: 20,
        onRefresh: () => _refresh(),
        child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                statusAd == StatusAd.loaded
                    ? Container(
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        alignment: Alignment.center,
                        width: myBanner!.size.width.toDouble(),
                        height: myBanner!.size.height.toDouble(),
                        child: AdWidget(ad: myBanner!),
                      )
                    : Container(),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    if (state.status == AccountStatusCubit.success) {
                      if (state.accounts!.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Image.asset(
                                          "assets/img/account-empty.png")),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Yah, data akun kamu masih kosong :(',
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 15),
                        itemCount: state.hasReachMax
                            ? state.accounts!.length
                            : state.accounts!.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.accounts!.length) {
                            return Container(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
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
                                      return AccountUpdateScreen(
                                          account: state.accounts![index]);
                                    })).then((value) {
                                      if (value == true) {
                                        _refresh();
                                      }
                                    });
                                  },
                                  title: Text(
                                    state.accounts![index].name ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                      state.accounts![index].address ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  leading:
                                      const Icon(Icons.face, color: bSecondary),
                                  trailing: IconButton(
                                    onPressed: () => _showDeleteModal(
                                        state.accounts![index]),
                                    icon: const Icon(
                                        Icons.delete_forever_outlined,
                                        color: bSecondary),
                                  ),
                                ));
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(15.0),
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                color: bInfo,
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.topCenter,
                        child: const CircularProgressIndicator(
                          color: bInfo,
                        ),
                      );
                    }
                  },
                ),
              ])),
              SliverList(delegate: SliverChildListDelegate([])),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return const AccountCreateScreen();
          })).then((value) {
            if (value == true) {
              _refresh();
            }
          });
        },
        backgroundColor: bInfo,
        child: const Icon(Icons.group_add),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _showDeleteModal(AccountModel account) {
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
                      'Peringatan!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Apakah kamu yakin ingin menghapus ${account.name}?',
                      style: const TextStyle(),
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
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              child: const Text('Batal',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Navigator.pop(context);
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
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                delete(account);
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
