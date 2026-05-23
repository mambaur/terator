import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/bookmarks/cubit/bookmark_cubit.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/persentations/subscription/widgets/premium_gate.dart';
import 'package:terator/utils/custom_snackbar.dart';

class LetterDetailScreen extends StatefulWidget {
  final String keyLetter;
  final String title;
  final String? subtitle;
  final String? categoryTitle;
  const LetterDetailScreen({
    super.key,
    required this.keyLetter,
    required this.title,
    this.subtitle,
    this.categoryTitle,
  });

  @override
  State<LetterDetailScreen> createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {
  bool _isLoading = true;
  File? _pdfFile;

  // Dummy sample account so the preview shows realistic content
  AccountModel get _sampleAccount => AccountModel(
        name: 'Budi Santoso',
        parentName: 'Ahmad Santoso',
        placeAndDateOfBirth: 'Jakarta, 12 Januari 1995',
        gender: 'Laki-laki',
        religion: 'Islam',
        lastEducation: 'S1',
        educationNumber: '20240001',
        educationClass: 'XII IPA 1',
        educationInstitution: 'SMA Negeri 1 Jakarta',
        educationFaculty: 'Teknik Informatika',
        educationStudyProgram: 'Teknik Informatika',
        educationAddress: 'Jl. Pendidikan No. 10, Jakarta',
        heightOrWeight: '170/65',
        telephone: '081234567890',
        email: 'budi.santoso@example.com',
        maritalStatus: 'Belum Menikah',
        address: 'Jl. Merdeka No. 17, Jakarta Pusat',
        letterCityWritten: 'Jakarta',
      );

  @override
  void initState() {
    super.initState();
    // Defer until after first frame — the native PDF plugin's platform
    // channel can race with build on first open and leave the Future pending.
    WidgetsBinding.instance.addPostFrameCallback((_) => _generatePdf());
  }

  Future<void> _generatePdf() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final previewHtml = LetterData.html(
        widget.keyLetter,
        account: _sampleAccount,
      );
      final html = '<div style="margin: 105px 90px">$previewHtml</div>';

      // Single fixed filename — overwritten each open, deleted on dispose,
      // so only one preview file exists at a time for this screen.
      final generatedPdf = await HtmlToPdfConverter().convertHtmlToPdf(
        html: html,
        targetDirectory: tempDir.path,
        targetName: 'letter_detail_preview',
      );

      if (mounted) {
        setState(() {
          _pdfFile = generatedPdf;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) print('Preview error: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    if (_pdfFile != null && _pdfFile!.existsSync()) {
      _pdfFile!.delete().catchError((_) => _pdfFile!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremiumLetter = premiumLetterMap[widget.keyLetter] == true;

    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              final bool isBookmarked = state.keys.contains(widget.keyLetter);
              return IconButton(
                tooltip:
                    isBookmarked ? 'Hapus dari bookmark' : 'Simpan ke bookmark',
                icon: Icon(
                  isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await context.read<BookmarkCubit>().toggle(
                        letterKey: widget.keyLetter,
                        title: widget.title,
                        subtitle: widget.subtitle,
                        categoryTitle: widget.categoryTitle,
                      );
                  if (!context.mounted) return;
                  CustomSnackbar.show(
                    context,
                    type: SnackbarType.success,
                    message: isBookmarked
                        ? 'Template dihapus dari bookmark'
                        : 'Template disimpan ke bookmark',
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Header info chip row
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            color: kPrimary,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.categoryTitle != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(kRadiusSm),
                    ),
                    child: Text(
                      widget.categoryTitle!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (widget.categoryTitle != null) const SizedBox(width: 8),
                if (widget.subtitle != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(kRadiusSm),
                    ),
                    child: Text(
                      widget.subtitle!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                // const Spacer(),
                if (isPremiumLetter)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                      ),
                      borderRadius: BorderRadius.circular(kRadiusSm),
                    ),
                    child: const Text(
                      'PRO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Preview label
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 4,
          //         height: 18,
          //         decoration: BoxDecoration(
          //           gradient: const LinearGradient(
          //             colors: kGradientPrimary,
          //             begin: Alignment.topCenter,
          //             end: Alignment.bottomCenter,
          //           ),
          //           borderRadius: BorderRadius.circular(2),
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       const Text(
          //         'Preview Template',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w700,
          //           color: kTextPrimary,
          //         ),
          //       ),
          //       const Spacer(),
          //       const Icon(Icons.visibility_outlined,
          //           color: kTextMuted, size: 18),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 16,
          ),

          // PDF Preview (rendered from dummy account data)
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              decoration: BoxDecoration(
                color: kSurfaceVariant,
                borderRadius: BorderRadius.circular(kRadiusLg),
                boxShadow: kShadowSm,
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildPreviewBody(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: BoxDecoration(
            color: kCardWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
            builder: (context, subState) {
              return Container(
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
                    minimumSize: const Size.fromHeight(52),
                  ),
                  icon: const Icon(Icons.edit_document, color: Colors.white),
                  label: const Text(
                    'Gunakan Template',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.3,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    if (isPremiumLetter && !subState.isPremium) {
                      PremiumGate.show(context);
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => LetterChooseAccountScreen(
                          keyLetter: widget.keyLetter,
                          title: widget.title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: kPrimary),
            SizedBox(height: 16),
            Text(
              'Memuat preview...',
              style: TextStyle(color: kTextSecondary, fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (_pdfFile == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: kCardWhite,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: kTextMuted,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Gagal memuat preview',
              style: TextStyle(
                color: kTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coba lagi nanti',
              style: TextStyle(color: kTextMuted, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return PDFView(
      filePath: _pdfFile!.path,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      backgroundColor: Colors.transparent,
    );
  }
}
