import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
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
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/repositories/letter_repository.dart';

class LetterEditorScreen extends StatefulWidget {
  final AccountModel account;
  const LetterEditorScreen({super.key, required this.account});

  @override
  State<LetterEditorScreen> createState() => _LetterEditorScreenState();
}

class _LetterEditorScreenState extends State<LetterEditorScreen> {
  final LetterRepository _letterRepo = LetterRepository();
  final HtmlEditorController controller = HtmlEditorController();
  final _titleController = TextEditingController();

  bool withSignature = false;

  convert(String htmlData, String name) async {
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        html, targetPath!, targetFileName);
    if (kDebugMode) print(generatedPdfFile);
    await store(htmlData);
    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    CoolAlert.show(
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      title: "Sukses!!!",
      text: "Surat kamu berhasil di generate dan di download!",
    );
  }

  Future store(String html) async {
    final response = await _letterRepo.insert({
      "account_id": widget.account.id,
      "name": "Surat Izin Sekolah",
      "title": _titleController.text,
      "html": html,
      "with_signature": withSignature ? 1 : 0,
      "created_at": DateSetting.timestamp(),
      "updated_at": DateSetting.timestamp()
    });
    print("Responsee " + response.toString());
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
        title: Text("Surat Izin Sekolah"),
        centerTitle: true,
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // insert element for ttd
      body: HtmlEditor(
        controller: controller,
        callbacks: Callbacks(onInit: () {
          // String text =
          //     LetterData.html('surat_izin_sekolah', image: image64);
          String text = LetterData.html('surat_izin_sekolah',
              image:
                  "<div style='margin-top:10px;margin-bottom:10px;text-align: right;'><img width='50px' src='$image64'></div>");
          controller.setText(text);
        }),
        htmlToolbarOptions: const HtmlToolbarOptions(),
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
                    Text(
                      'Beri nama file yang akan kamu generate',
                      style: const TextStyle(),
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
                                // Clipboard.setData(ClipboardData(text: data))
                                //     .then((_) {
                                //   Fluttertoast.showToast(
                                //       msg: 'Html berhasil disalin.');
                                // });
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

  String image64 =
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAYAAAD0eNT6AAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAIABJREFUeJzs3Xd4VGXax/HvmZlUSggkoUPovQlKs6CiCCoqILqC3dXVXcuu7ura29rr2teCgIgN7GLBgmsvLAgqiPTeQiCkz8x5/xjCSzRAMuc5OTOZ3+e6cr3XvnDucwMx92+ec85zQERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERE9sPyugFJWAGgA9ARaAlkAD6gFNgBrAB+AdZ41J+IiIgY0hL4G/AekSFvV+NrHfACMBGoX/sti4iISLSOIjL0Q1Rv6O/tqxB4Cuhau+2LiIhITRwEfIWzoV/VVwiYCrSovT+KiIiI7E8a8CjOP/Hv72sHcEEt/ZlERERkH7oAC3F38P/262WgQW384UREROT3DgQ2UbvDv+LrO6Cp+39EERER2dORwE68Gf4VX0uAVm7/QUVERCTiMLwf/hVfK4BcN/+wIiIiAkcDRXg/+BUCREREaskIoBjvB75CgIiISC05htgd/goBIiIiLhhJ7A9/hQARERGDRgEleD/YFQJERERqybHE3/BXCBARqYJeByzVNRaYDiSZLJqEn4FWazpb2aSTxDaKmW+vZ6G9weRpKiwFDgdWu1FcRCSeKABIdZwMTMPg8E8jiQt9g7jAP4gMUn/360vtrdwdnsNr4R9NnXJ3aRQCREQUAGS/TgGeAwKmCrawGjLZfwq9rGb7/b2vhBdweegtSgmaOj0oBIiIKADIPo0n8snf2PBvZWUw038GbaxG1T5mjr2MM4MvUmI2BKwEhhG5N0BEJOH4vG5AYtYpGB7+ra1GNR7+AIdZ7ZkcOIVUc60AtAU+QTcGikiC0gqAVOVUYCrGh//ptK7h8N+TVgJERMxRAJDf+gOR4e83VbC91ZgZ/jNobjVwXEshQETEDF0CkD2dQ+SGP2PDv4PVxNjwB10OEBExRSsAUuFc4D8YDIWR4X86zQwN/z1pJUBExBmtAAjAeRge/h2tLNeGP2glQETEKa0AyB+BxzE9/AOn05T6pkrulVYCRESiowCQ2M4nMvyNfR902jX8c2ph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t43XFRERiUcVAWAlMDfaInbY5vErP8MOO3/BTkGwHltKzV////KOyfr0LyIissuez9lNcVJo8febeOHeqDPEbot2tsPG7OsRl77zOcve+8poTRERkXi2ZwCYDOx0Umzand8x/9O1UR+/PVifdSXZTlr4nW2/rmbOtY8brSkiIhLv9gwA24FpToqFQza3THyPZQu2RHX8zwXtjX76L9yYx6wL7tCrf0VERH7jt1vt3QsEnRQsKijj+pPfYdXimj0auKakKRtKzT36V7RpG++ceys71202VlNERKSu+G0AWAI867Ro3sYi/j7yNX7+dmO1fn9xKIX5O7o4Pe1u+cvX8fpp17Jt6RpjNUVEROqSqjbbvxEodlq4YFspVx3/Bq8/vv999+du70552Mz7BFZ8+C2vn3oNBWv1yV9ERGRvqgoAa4G7TBQvLw3xxD8/5+bT3mXT6oIqf8+POzuwucz5Y38l2wqYc81jvP+XuyndUei4noiISF22t4/dtwPjgW4mTvLVrBXMm7OGsZf05YQLelG/UQoAy4tasmRnW0e1gyWl/PzSbOY+OoPS7Y4eYhAREUkYewsApcD5wByqXiWosZKiINPu+I5XH/mBY87sRq+xQ9jQrHPU9QrWbOKX1+fw0/T3Kd663USLIiIiCWNfF94/A24mck+AMUUFZcx8eD4zH55Pk67v0GpoH1oM7EmTbrmkZzXa63El+QXkLV7Fuq8XsuaLH9j0w69gO995UEREJBHt7867W4AhwNFunHzropVsXbSS+U+/AUByg3rUb96E5Ppp+FOSCZUFKS8sonBjHiXbqr6HQERERGpufwEgDEwEvgA6ut1MWUEheQW6gU9ERBLTzh35zH7reb777AM2b1jDutXL5hF5X88sYBKw1dS5qvPs3WbgGOBzoKmpE4uIiMj/+/idl/jPPVdRsKPSRnoddn0dAVwLXA48beJ81b3Bbykwish2wSIiImLQa9Me4d7rL/jt8P+tDOApIkHAsZrc4T+XSALRDjsiIiKGLJz7OU8/eH1NDrkZGOH0vDV9xG8ucAiw2umJRUREBJ558AbscLgmh1jA3U7PG80z/ouB/sDHTk8uIiKSyNatWsovP34fzaG9gL5Ozh3tJj+biSw/POzk5B56CVjvdRMiIpLYFi341snhg50c7GSXv3LgYuAE4meY5gGnAacARR73IiIi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";
}
