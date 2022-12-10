import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:terator/core/generator.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/persentations/my_files/cubits/file_cubit/file_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/persentations/my_files/screens/my_file_edit_screen.dart';
import 'package:terator/repositories/letter_repository.dart';

enum StatusAd { initial, loaded }

class MyFileScreen extends StatefulWidget {
  const MyFileScreen({super.key});

  @override
  State<MyFileScreen> createState() => _MyFileScreenState();
}

class _MyFileScreenState extends State<MyFileScreen> {
  final LetterRepository _letterRepo = LetterRepository();
  final ScrollController _scrollController = ScrollController();

  convert(String htmlData, String name) async {
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        html, targetPath!, targetFileName);

    Uint8List fileByte = await generatedPdfFile.readAsBytes();
    await DocumentFileSavePlus.saveFile(fileByte,
        "${getRandomString(5)}_$targetFileName.pdf", "appliation/pdf");

    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    CoolAlert.show(
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      title: "Sukses!!!",
      text: "Surat kamu berhasil di download!",
    );
  }

  Future<void> shareFile(String htmlData, String name) async {
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        html, targetPath!, "${getRandomString(5)}_$targetFileName");

    // Uint8List fileByte = await generatedPdfFile.readAsBytes();
    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    Share.shareFiles([generatedPdfFile.path], text: 'Share $name');
  }

  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // directory = await getTemporaryDirectory();
        directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      if (kDebugMode) print("Can-not get download folder path");
    }
    return directory?.path;
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && !context.read<FileCubit>().hasReachMax) {
      context.read<FileCubit>().getFiles(isInit: false);
    }
  }

  Future<void> _refresh() async {
    context.read<FileCubit>().getFiles(isInit: true);
  }

  Future<void> delete(LetterModel letter) async {
    LoadingOverlay.show(context);
    await _letterRepo.delete(letter.id!);
    _refresh();
    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
    CoolAlert.show(
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      title: "Sukses!!!",
      text: "Surat berhasil dihapus!",
    );
  }

  DateFormat format = DateFormat("yyyy-MM-dd hh:mm:ss");
  String diffHumanDate(String date) {
    // print(format.parse(date));

    String dateDiffHuman =
        DateFormat("d MMMM yyyy hh:mm:ss", "id_ID").format(format.parse(date));
    return dateDiffHuman;
  }

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

  @override
  void initState() {
    context.read<FileCubit>().getFiles(isInit: true);

    myBanner = BannerAd(
      // test banner
      adUnitId: '/6499/example/banner',

      // adUnitId: 'ca-app-pub-2465007971338713/8992395637',
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
                BlocBuilder<FileCubit, FileState>(
                  builder: (context, state) {
                    if (state.status == FileStatusCubit.success) {
                      if (state.letters!.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Image.asset(
                                          "assets/img/file-empty.png")),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'File kamu masih kosong, generate surat sekarang!',
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
                            ? state.letters!.length
                            : state.letters!.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.letters!.length) {
                            return Container(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
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
                                    _showDetailFileModal(state.letters![index]);
                                  },
                                  title: Text(
                                    state.letters![index].title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.letters![index].name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                      Text(
                                          diffHumanDate(
                                              state.letters![index].createdAt ??
                                                  ''),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 10)),
                                      // Text(
                                      //     state.letters![index].createdAt ?? '',
                                      //     maxLines: 1,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: const TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  leading: const Icon(Icons.picture_as_pdf,
                                      color: bSecondary),
                                  trailing: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: bSecondary),
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
    );
  }

  Future<void> _showDetailFileModal(LetterModel letter) {
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
                    Text(
                      '📃 ${letter.title}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      letter.name ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return MyFileEditScreen(letter: letter);
                        })).then((value) {
                          if (value == true) {
                            _refresh();
                          }
                        });
                      },
                      title: const Text('Edit Surat'),
                      leading: const Icon(
                        Icons.edit,
                        color: bInfo,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        shareFile(letter.html ?? '', letter.title ?? '');
                      },
                      title: const Text('Berbagi'),
                      leading: const Icon(
                        Icons.share,
                        color: bSuccess,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        convert(letter.html ?? '', letter.title ?? '');
                      },
                      title: const Text('Download'),
                      leading: const Icon(
                        Icons.download,
                        color: bSecondary,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _showDeleteDialog(letter);
                      },
                      title: const Text('Hapus'),
                      leading: const Icon(
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

  Future<void> _showDeleteDialog(LetterModel letter) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apakah kamu yakin ingin menhapus ${letter.title}'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Batal',
                style: TextStyle(color: bSecondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Hapus',
                style: TextStyle(color: bInfo, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                delete(letter);
              },
            ),
          ],
        );
      },
    );
  }
}
