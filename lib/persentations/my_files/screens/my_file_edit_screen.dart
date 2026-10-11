// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/generator.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/repositories/letter_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

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

  bool withSignature = false;

  void convert(String htmlData, String name) async {
    try {
      LoadingOverlay.show(context);
      // Web is dev-only: no native PDF export, just save the HTML.
      if (!kIsWeb) {
        var targetPath = await _localPath;
        var targetFileName = name;
        var html = '<div style="margin: 105px 90px">$htmlData</div>';

        var generatedPdfFile = await HtmlToPdfConverter().convertHtmlToPdf(
            html: html,
            targetDirectory: targetPath!,
            targetName: targetFileName);

        await FlutterFileSaver().writeFileAsBytes(
          fileName: "$targetFileName - ${getRandomString(5).toUpperCase()}.pdf",
          bytes: await generatedPdfFile.readAsBytes(),
        );
      }

      await update(htmlData);
      isRefreshBack = true;
      LoadingOverlay.hide();
      Navigator.pop(context, isRefreshBack);

      CustomSnackbar.show(context,
          type: SnackbarType.success, message: "Surat berhasil di Update");
    } catch (e) {
      LoadingOverlay.hide();
      if (kDebugMode) print(e.toString());
    }
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
        directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      if (kDebugMode) print("Can-not get download folder path");
    }
    return directory?.path;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    LoadingOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: widget.letter.title ?? '',
        showBack: true,
        context: context,
      ),
      // Editor sized to the space left between app bar and save bar, so
      // nothing overlaps it: on web the editor is an iframe that swallows
      // clicks on Flutter widgets drawn above it.
      body: LayoutBuilder(
        builder: (context, constraints) => HtmlEditor(
          controller: controller,
          callbacks: Callbacks(onInit: () {
            String text = widget.letter.html ?? '';
            controller.setText("$text<br><br><br>");
          }),
          htmlToolbarOptions:
              const HtmlToolbarOptions(toolbarPosition: ToolbarPosition.custom),
          htmlEditorOptions: const HtmlEditorOptions(
            hint: "Your text here...",
            // The Scaffold already shrinks the body above the keyboard; the
            // package's own keyboard resize would shrink it a second time.
            adjustHeightForKeyboard: false,
          ),
          otherOptions: OtherOptions(
            height: constraints.maxHeight,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: AppTheme.gradientButton(
            label: 'Simpan Surat',
            icon: Icons.save_rounded,
            onTap: () async {
              String data = await controller.getText();
              convert(data, widget.letter.title ?? '');
            },
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
