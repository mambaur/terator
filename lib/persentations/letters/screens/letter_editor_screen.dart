import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/generator.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/navbar.dart';
import 'package:terator/repositories/letter_repository.dart';

class LetterEditorScreen extends StatefulWidget {
  final AccountModel account;
  final String keyLetter;
  final String title;
  final bool withSignature;
  const LetterEditorScreen(
      {super.key,
      required this.account,
      required this.keyLetter,
      required this.withSignature,
      required this.title});

  @override
  State<LetterEditorScreen> createState() => _LetterEditorScreenState();
}

class _LetterEditorScreenState extends State<LetterEditorScreen> {
  final LetterRepository _letterRepo = LetterRepository();
  final HtmlEditorController controller = HtmlEditorController();
  final _titleController = TextEditingController();
  RewardedInterstitialAd? myRerwardedAd;

  bool withSignature = false;

  convert(String htmlData, String name) async {
    try {
      await requestStoragePermission();
      // ignore: use_build_context_synchronously
      LoadingOverlay.show(context);
      var targetPath = await _localPath;
      var targetFileName = name;
      var html = '<div style="margin: 50px">$htmlData</div>';

      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          html, targetPath!, targetFileName);

      // if (kDebugMode) print(generatedPdfFile.readAsBytes());

      Uint8List fileByte = await generatedPdfFile.readAsBytes();
      await DocumentFileSavePlus.saveFile(fileByte,
          "${getRandomString(5)}_$targetFileName.pdf", "appliation/pdf");

      await store(htmlData);
      // ignore: use_build_context_synchronously
      LoadingOverlay.hide(context);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const Navbar(
                  selectedIndex: 1,
                )),
        ModalRoute.withName('/account-screen'),
      );

      CoolAlert.show(
        backgroundColor: Colors.white,
        context: context,
        type: CoolAlertType.success,
        title: "Sukses!!!",
        text: "Surat kamu berhasil di generate dan di download!",
      );
    } catch (e, s) {
      if (kDebugMode) print('error ' + e.toString());
      // ignore: use_build_context_synchronously
      LoadingOverlay.hide(context);
      // Clipboard.setData(ClipboardData(text: '${e.toString()}\n${s.toString()}'))
      //     .then((_) {
      //   Fluttertoast.showToast(msg: 'Error telah disalin.');
      // });
    }

    await showRewardAd();
  }

  Future store(String html) async {
    final response = await _letterRepo.insert({
      "account_id": widget.account.id,
      "name": widget.title,
      "title": _titleController.text,
      "html": html,
      "with_signature": withSignature ? 1 : 0,
      "created_at": DateSetting.timestamp(),
      "updated_at": DateSetting.timestamp()
    });
    if (kDebugMode) print("Responsee $response");
  }

  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android

        // directory = Directory('/storage/emulated/0/Download');
        // if (!await directory.exists()) {
        //   directory = await getExternalStorageDirectory();
        // }

        directory = await getTemporaryDirectory();
        // directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      if (kDebugMode) print("Can-not get download folder path");
    }
    return directory?.path;
  }

  Future<void> showRewardAd() async {
    if (myRerwardedAd != null) {
      myRerwardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createRewardedAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createRewardedAd();
      }, onAdWillDismissFullScreenContent: (ad) {
        ad.dispose();
        _createRewardedAd();
      });

      myRerwardedAd!.show(onUserEarnedReward: (ad, reward) {});
    }
  }

  void _createRewardedAd() {
    RewardedInterstitialAd.load(
        adUnitId: "ca-app-pub-2465007971338713/5704134732", // production
        // adUnitId: "/21775744923/example/rewarded_interstitial", // test
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
            onAdLoaded: (ad) => setState(() => myRerwardedAd = ad),
            onAdFailedToLoad: (_) => setState(() => myRerwardedAd = null)));
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isDenied == true || status.isGranted != true) {
      Fluttertoast.showToast(
          msg:
              'Mohon terima akses penyimpanan, agar surat kamu bisa di generate!');
      requestStoragePermission();
    } else {
      print('request storage approve');
    }
  }

  @override
  void initState() {
    print('holla');
    _createRewardedAd();
    // requestStoragePermission();
    super.initState();
  }

  @override
  void dispose() {
    LoadingOverlay.hide(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // insert element for ttd
      body: HtmlEditor(
        controller: controller,
        callbacks: Callbacks(onInit: () {
          String text = LetterData.html(widget.keyLetter,
              account: widget.account,
              image: widget.withSignature
                  ? "<div style='margin-top:10px;margin-bottom:10px;text-align: center;'><img style='width:50%;' src='data:image/png;base64,${widget.account.signatureImage}'></div>"
                  : null);
          controller.setText("$text<br><br><br>");
        }),
        // htmlToolbarOptions: const HtmlToolbarOptions(),
        htmlToolbarOptions:
            const HtmlToolbarOptions(toolbarPosition: ToolbarPosition.custom),
        htmlEditorOptions: const HtmlEditorOptions(
          hint: "Tulis surat disini...",
          //initalText: "text content initial, if any",
        ),
        otherOptions: OtherOptions(
          height: MediaQuery.of(context).size.height,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // String data = await controller.getText();
          // Clipboard.setData(ClipboardData(text: data)).then((_) {
          //   Fluttertoast.showToast(msg: 'Html berhasil disalin.');
          // });
          _showSubmitModal();
        },
        backgroundColor: bInfo,
        child: const Icon(Icons.save),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _showSubmitModal() {
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
                      'Nama File!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Beri nama file yang akan kamu generate',
                      style: TextStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: bSecondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: bInfo),
                          ),
                          labelStyle: TextStyle(color: bSecondary),
                          labelText: 'Nama File'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bInfo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Simpan & Download',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (_titleController.text == '') {
                                  Fluttertoast.showToast(
                                      msg: "Nama file tidak boleh kosong");
                                  return;
                                }
                                Navigator.pop(context);

                                String data = await controller.getText();
                                convert(data, _titleController.text);
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
