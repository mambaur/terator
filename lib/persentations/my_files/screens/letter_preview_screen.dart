import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/styles.dart';

class LetterPreviewScreen extends StatefulWidget {
  final String htmlContent;
  final String title;

  const LetterPreviewScreen({
    super.key,
    required this.htmlContent,
    required this.title,
  });

  @override
  State<LetterPreviewScreen> createState() => _LetterPreviewScreenState();
}

class _LetterPreviewScreenState extends State<LetterPreviewScreen> {
  bool _isLoading = true;
  File? _pdfFile;
  Uint8List? _pdfBytes;

  @override
  void initState() {
    super.initState();
    _generatePdf();
  }

  Future<void> _generatePdf() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final html = '<div style="margin: 50px">${widget.htmlContent}</div>';
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final generatedPdf = await HtmlToPdfConverter().convertHtmlToPdf(
        html: html,
        targetDirectory: tempDir.path,
        targetName: 'preview_$timestamp',
      );

      final bytes = await generatedPdf.readAsBytes();

      if (mounted) {
        setState(() {
          _pdfFile = generatedPdf;
          _pdfBytes = bytes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) print('Preview error: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Cleanup temp file
    if (_pdfFile != null && _pdfFile!.existsSync()) {
      _pdfFile!.delete().catchError((_) => _pdfFile!);
    }
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
      backgroundColor: const Color.fromARGB(255, 176, 181, 185),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Memuat preview...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : _pdfBytes == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.white70,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Gagal memuat preview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Coba lagi nanti',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
              : _buildPdfViewer(),
    );
  }

  Widget _buildPdfViewer() {
    // Display the HTML content in a WebView-like scrollable card
    // Since we already have the HTML, we render it as a styled preview
    return PDFView(
      filePath: _pdfFile?.path,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      backgroundColor: Colors.transparent,
    );
  }
}
