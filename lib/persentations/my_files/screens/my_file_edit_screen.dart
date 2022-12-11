import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/generator.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/repositories/letter_repository.dart';

class MyFileEditScreen extends StatefulWidget {
  final LetterModel letter;
  const MyFileEditScreen({super.key, required this.letter});

  @override
  State<MyFileEditScreen> createState() => _MyFileEditScreenState();
}

class _MyFileEditScreenState extends State<MyFileEditScreen> {
  final LetterRepository _letterRepo = LetterRepository();
  final HtmlEditorController controller = HtmlEditorController();
  final titleController = TextEditingController();
  bool isRefreshBack = false;
  RewardedInterstitialAd? myRerwardedAd;

  bool withSignature = false;

  convert(String htmlData, String name) async {
    await showRewardAd();
    // ignore: use_build_context_synchronously
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        html, targetPath!, targetFileName);

    Uint8List fileByte = await generatedPdfFile.readAsBytes();
    await DocumentFileSavePlus.saveFile(fileByte,
        "${getRandomString(5)}_$targetFileName.pdf", "appliation/pdf");

    // if (kDebugMode) print(generatedPdfFile);
    await update(htmlData);
    isRefreshBack = true;
    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context, isRefreshBack);

    CoolAlert.show(
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      title: "Sukses!!!",
      text: "Surat kamu berhasil di Update dan di download!",
    );
  }

  Future update(String html) async {
    await _letterRepo.update({
      "id": widget.letter.id,
      "html": html,
      "updated_at": DateSetting.timestamp()
    });
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
        // adUnitId: "ca-app-pub-2465007971338713/5704134732", // production
        adUnitId: "/21775744923/example/rewarded_interstitial", // test
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
            onAdLoaded: (ad) => setState(() => myRerwardedAd = ad),
            onAdFailedToLoad: (_) => setState(() => myRerwardedAd = null)));
  }

  @override
  void initState() {
    _createRewardedAd();
    super.initState();
  }

  @override
  void dispose() {
    LoadingOverlay.show(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.letter.title ?? ''),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, isRefreshBack);
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      // insert element for ttd
      body: Column(
        children: [
          Expanded(
            child: HtmlEditor(
              controller: controller,
              callbacks: Callbacks(onInit: () {
                String text = widget.letter.html ?? '';
                controller.setText("$text<br><br><br>");
              }),
              htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.custom),
              htmlEditorOptions: const HtmlEditorOptions(
                hint: "Your text here...",
                //initalText: "text content initial, if any",
              ),
              otherOptions: OtherOptions(
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String data = await controller.getText();
          // Clipboard.setData(ClipboardData(text: data)).then((_) {
          //   Fluttertoast.showToast(msg: 'Html berhasil disalin.');
          // });
          convert(data, widget.letter.title ?? '');
        },
        backgroundColor: bInfo,
        child: const Icon(Icons.save),
      ),
    );
  }
}
