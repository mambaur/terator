import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/date_setting.dart';
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

  bool withSignature = false;

  convert(String htmlData, String name) async {
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        html, targetPath!, targetFileName);
    if (kDebugMode) print(generatedPdfFile);
    await update(htmlData);
    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
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
        // if platform is android

        // directory = Directory('/storage/emulated/0/Download');
        // if (!await directory.exists()) {
        //   directory = await getExternalStorageDirectory();
        // }

        // directory = await getTemporaryDirectory();
        directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Can-not get download folder path");
    }
    return directory?.path;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor"),
      ),
      // insert element for ttd
      body: Column(
        children: [
          Expanded(
            child: HtmlEditor(
              controller: controller,
              callbacks: Callbacks(onImageUpload: (file) {
                // print(file.base64);
              }, onInit: () {
                controller.setText(widget.letter.html ?? '');
              }),
              htmlToolbarOptions: HtmlToolbarOptions(),
              htmlEditorOptions: HtmlEditorOptions(
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
          Clipboard.setData(ClipboardData(text: data)).then((_) {
            Fluttertoast.showToast(msg: 'Html berhasil disalin.');
          });
          convert(data, "Test 4");
        },
        backgroundColor: bInfo,
        child: const Icon(Icons.save),
      ),
    );
  }
}
