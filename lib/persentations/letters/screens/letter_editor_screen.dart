// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/generator.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/navbar.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/repositories/kop_surat_repository.dart';
import 'package:terator/repositories/letter_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

class LetterEditorScreen extends StatefulWidget {
  final AccountModel account;
  final String keyLetter;
  final String title;
  final bool withSignature;
  final Map<String, String> vars;
  const LetterEditorScreen(
      {super.key,
      required this.account,
      required this.keyLetter,
      required this.withSignature,
      required this.title,
      this.vars = const {}});

  @override
  State<LetterEditorScreen> createState() => _LetterEditorScreenState();
}

class _LetterEditorScreenState extends State<LetterEditorScreen> {
  final LetterRepository _letterRepo = LetterRepository();
  final HtmlEditorController controller = HtmlEditorController();
  final _titleController = TextEditingController();

  bool withSignature = false;

  void convert(String htmlData, String name) async {
    try {
      LoadingOverlay.show(context);
      // Web is dev-only: no native PDF export, just save the HTML.
      if (!kIsWeb) {
        var targetPath = await _localPath;
        var targetFileName = name;
        var html = '<div style="margin: 105px 90px">$htmlData</div>';

        File generatedPdfFile = await HtmlToPdfConverter().convertHtmlToPdf(
            html: html,
            targetDirectory: targetPath!,
            targetName: targetFileName);

        await FlutterFileSaver().writeFileAsBytes(
          fileName: "$targetFileName - ${getRandomString(5).toUpperCase()}.pdf",
          bytes: await generatedPdfFile.readAsBytes(),
        );
      }

      await store(htmlData);
      LoadingOverlay.hide();

      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const Navbar(
                  selectedIndex: 1,
                )),
        ModalRoute.withName('/account-screen'),
      );

      CustomSnackbar.show(context,
          type: SnackbarType.success, message: "Surat berhasil di generate");
    } catch (e) {
      if (kDebugMode) print('error $e');
      LoadingOverlay.hide();
    }
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
        directory = await getTemporaryDirectory();
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
        title: widget.title,
        showBack: true,
        context: context,
      ),
      // Editor sized to the space left between app bar and save bar, so
      // nothing overlaps it: on web the editor is an iframe that swallows
      // clicks on Flutter widgets drawn above it.
      body: LayoutBuilder(
        builder: (context, constraints) => HtmlEditor(
          controller: controller,
          callbacks: Callbacks(onInit: () async {
            String text = LetterData.html(widget.keyLetter,
                account: widget.account,
                vars: widget.vars,
                image: widget.withSignature
                    ? "<img style='width:100%;' src='data:image/png;base64,${widget.account.signatureImage}'>"
                    : null);
            final kop = await KopSuratRepository().htmlForLetter(
              widget.keyLetter,
              isPremium: context.read<SubscriptionCubit>().state.isPremium,
            );
            controller.setText("$kop$text<br><br><br>");
          }),
          htmlToolbarOptions: const HtmlToolbarOptions(defaultToolbarButtons: [
            FontSettingButtons(fontName: false),
            FontButtons(),
            ColorButtons(),
            ListButtons(listStyles: false),
            ParagraphButtons(
                textDirection: false, lineHeight: false, caseConverter: false)
          ]),
          htmlEditorOptions: const HtmlEditorOptions(
            hint: "Tulis surat disini...",
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
            onTap: _showSubmitModal,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Future<void> _showSubmitModal() async {
    // On web the editor iframe keeps keyboard focus, which leaves the
    // file-name field unusable; disable it while the sheet is open.
    if (kIsWeb) controller.disable();
    await AppTheme.showModernBottomSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(kRadiusSm),
                ),
                child: const Icon(Icons.save_alt_rounded,
                    color: kPrimary, size: 22),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Simpan Surat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kTextPrimary,
                    ),
                  ),
                  Text(
                    'Beri nama file yang akan kamu generate',
                    style: TextStyle(fontSize: 12, color: kTextSecondary),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded, color: kTextMuted),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _titleController,
            decoration: AppTheme.inputDecoration(
              label: 'Nama File',
              hint: 'Contoh: Surat Izin Sakit - Budi',
              prefixIcon: Icons.insert_drive_file_outlined,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: kGradientPrimary),
                borderRadius: BorderRadius.circular(kRadiusMd),
                boxShadow: kShadowPrimary,
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusMd),
                  ),
                ),
                icon: const Icon(Icons.download_rounded, color: Colors.white),
                label: const Text(
                  'SIMPAN & DOWNLOAD',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                onPressed: () async {
                  if (_titleController.text == '') {
                    Fluttertoast.showToast(msg: "Nama file tidak boleh kosong");
                    return;
                  }
                  Navigator.pop(context);

                  String data = await controller.getText();
                  convert(data, _titleController.text);
                },
              ),
            ),
          ),
        ],
      ),
    );
    if (kIsWeb) controller.enable();
  }
}
