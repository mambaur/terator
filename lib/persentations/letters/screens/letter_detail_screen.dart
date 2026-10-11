import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terator/core/platform/html_preview.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/bookmarks/cubit/bookmark_cubit.dart';
import 'package:terator/persentations/kop_surat/screens/kop_surat_screen.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';
import 'package:terator/persentations/letters/screens/letter_variable_form_screen.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/persentations/subscription/widgets/premium_gate.dart';
import 'package:terator/repositories/kop_surat_repository.dart';
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
  final KopSuratRepository _kopRepo = KopSuratRepository();
  bool _isLoading = true;
  File? _pdfFile;
  // Web has no native PDF renderer — the HTML is shown directly instead.
  String? _webHtml;
  bool _kopEnabled = false;
  // The PDF preview is a native platform view; compositing the premium sheet
  // over it makes the sheet animation stutter, so it is hidden meanwhile.
  bool _hidePreview = false;

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
        position: 'Staff Administrasi',
        address: 'Jl. Merdeka No. 17, Jakarta Pusat',
        letterCityWritten: 'Jakarta',
      );

  @override
  void initState() {
    super.initState();
    // Defer until after first frame — the native PDF plugin's platform
    // channel can race with build on first open and leave the Future pending.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final enabled = await _kopRepo.enabledLetters();
      if (mounted) {
        setState(() => _kopEnabled = enabled.contains(widget.keyLetter));
      }
      _generatePdf();
    });
  }

  Future<void> _generatePdf() async {
    final isPremium = context.read<SubscriptionCubit>().state.isPremium;
    try {
      final kopHtml = await _kopRepo.htmlForLetter(
        widget.keyLetter,
        isPremium: isPremium,
      );
      final previewHtml = LetterData.html(
        widget.keyLetter,
        account: _sampleAccount,
      );
      final html = '<div style="margin: 105px 90px">$kopHtml$previewHtml</div>';

      if (kIsWeb) {
        if (mounted) {
          setState(() {
            _webHtml = html;
            _isLoading = false;
          });
        }
        return;
      }

      final tempDir = await getTemporaryDirectory();

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

  Future<void> _showPremiumGate() async {
    setState(() => _hidePreview = true);
    await PremiumGate.show(context);
    if (mounted) setState(() => _hidePreview = false);
  }

  Future<void> _toggleKop(bool value) async {
    if (value) {
      if (!context.read<SubscriptionCubit>().state.isPremium) {
        _showPremiumGate();
        return;
      }
      if (!(await _kopRepo.get()).isConfigured) {
        if (!mounted) return;
        CustomSnackbar.show(context,
            type: SnackbarType.warning,
            message: 'Atur kop surat terlebih dahulu');
        await Navigator.push(
            context, MaterialPageRoute(builder: (_) => const KopSuratScreen()));
        if (!(await _kopRepo.get()).isConfigured) return;
      }
    }
    await _kopRepo.setEnabled(widget.keyLetter, value);
    if (!mounted) return;
    setState(() {
      _kopEnabled = value;
      _isLoading = true;
    });
    _generatePdf();
  }

  void _useTemplate() {
    final variables = LetterData.variables(widget.keyLetter);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => variables.isEmpty
            ? LetterChooseAccountScreen(
                keyLetter: widget.keyLetter,
                title: widget.title,
              )
            : LetterVariableFormScreen(
                keyLetter: widget.keyLetter,
                title: widget.title,
                variables: variables,
              ),
      ),
    );
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
          _buildKopSwitch(),

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
                      _showPremiumGate();
                      return;
                    }
                    _useTemplate();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildKopSwitch() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, subState) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          padding: const EdgeInsets.fromLTRB(14, 6, 8, 6),
          decoration: AppTheme.cardDecoration(radius: kRadiusMd),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD97706).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(kRadiusSm),
                ),
                child: const Icon(Icons.article_rounded,
                    color: Color(0xFFD97706), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Gunakan Kop Surat',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: kTextPrimary,
                          ),
                        ),
                        if (!subState.isPremium) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'PRO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Text(
                      'Tampilkan kop surat di bagian atas surat ini',
                      style: TextStyle(fontSize: 11, color: kTextSecondary),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _kopEnabled && subState.isPremium,
                activeTrackColor: kPrimary,
                onChanged: _toggleKop,
              ),
            ],
          ),
        );
      },
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

    if (kIsWeb && _webHtml != null) return HtmlPreview(html: _webHtml!);

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

    return Offstage(
      offstage: _hidePreview,
      child: PDFView(
        filePath: _pdfFile!.path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
