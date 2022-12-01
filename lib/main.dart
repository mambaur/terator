import 'dart:io';
import 'dart:math';

import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Terator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final quill.QuillController _controller = quill.QuillController.basic();

  convert(String htmlData, String name) async {
    // if (!await Permission.contacts.request().isGranted) {
    //   print('Request failed');
    //   return;
    // }

    // Name is File Name that you want to give the file
    var targetPath = await _localPath;
    var targetFileName = name;

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlData, targetPath!, targetFileName);
    print(generatedPdfFile);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(generatedPdfFile.toString()),
    ));
  }

  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android
        // if (await Permission.storage.request().isGranted) {
        //   directory = Directory('/storage/emulated/0/Download');
        //   if (!await directory.exists()) {
        //     directory = await getExternalStorageDirectory();
        //   }
        // }

        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }

        // directory = await getTemporaryDirectory();
        // directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
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
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                // print(_controller.document.toDelta());
                quill.Delta delta = _controller.document.toDelta();
                // print(delta.toJson());

                String htmlData = DeltaToHTML.encodeJson(delta.toJson());
                convert(htmlData, "PDF${Random().nextInt(1000)}");
                print(htmlData);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Card(
            child: quill.QuillToolbar.basic(
              // toolbarSectionSpacing: 0,
              // toolbarIconAlignment: WrapAlignment.spaceEvenly,
              multiRowsDisplay: false,
              showHeaderStyle: true,
              toolbarIconSize: 25,

              controller: _controller,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: quill.QuillEditor.basic(
                controller: _controller,
                readOnly: false, // true for view only mode
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
