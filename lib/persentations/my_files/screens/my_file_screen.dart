// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:terator/core/generator.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/persentations/my_files/cubits/file_cubit/file_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/persentations/my_files/screens/my_file_edit_screen.dart';
import 'package:terator/repositories/letter_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

enum StatusAd { initial, loaded }

class MyFileScreen extends StatefulWidget {
  const MyFileScreen({super.key});

  @override
  State<MyFileScreen> createState() => _MyFileScreenState();
}

class _MyFileScreenState extends State<MyFileScreen> {
  final LetterRepository _letterRepo = LetterRepository();
  final ScrollController _scrollController = ScrollController();
  InterstitialAd? _interstitialAd;

  void convert(String htmlData, String name) async {
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await HtmlToPdfConverter().convertHtmlToPdf(
        html: html, targetDirectory: targetPath!, targetName: targetFileName);

    await FlutterFileSaver().writeFileAsBytes(
      fileName: "$targetFileName - ${getRandomString(5).toUpperCase()}.pdf",
      bytes: await generatedPdfFile.readAsBytes(),
    );

    LoadingOverlay.hide();
    Navigator.pop(context);

    CustomSnackbar.show(context,
        type: SnackbarType.success, message: "Surat kamu berhasil di download");
  }

  Future<void> shareFile(String htmlData, String name) async {
    LoadingOverlay.show(context);
    var targetPath = await _localPath;
    var targetFileName = name;
    var html = '<div style="margin: 50px">$htmlData</div>';

    var generatedPdfFile = await HtmlToPdfConverter().convertHtmlToPdf(
        html: html,
        targetDirectory: targetPath!,
        targetName: "${getRandomString(5)}_$targetFileName");

    LoadingOverlay.hide();
    Navigator.pop(context);
    SharePlus.instance.share(ShareParams(
        files: [XFile(generatedPdfFile.path)], text: 'Share $name'));
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

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && !context.read<FileCubit>().hasReachMax) {
      context.read<FileCubit>().getFiles(isInit: false);
    }
  }

  Future<void> _refresh() async {
    context.read<FileCubit>().getFiles(isInit: true);
  }

  Future<void> delete(LetterModel letter) async {
    LoadingOverlay.show(context);
    await _letterRepo.delete(letter.id!);
    _refresh();
    LoadingOverlay.hide();

    CustomSnackbar.show(context,
        type: SnackbarType.success, message: "Surat berhasil dihapus");
  }

  DateFormat format = DateFormat("yyyy-MM-dd hh:mm:ss");
  String diffHumanDate(String date) {
    String dateDiffHuman =
        DateFormat("d MMMM yyyy hh:mm:ss", "id_ID").format(format.parse(date));
    return dateDiffHuman;
  }

  BannerAd? myBanner;

  BannerAdListener listener() => BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('Ad Loaded.');
          }
          setState(() {
            statusAd = StatusAd.loaded;
          });
        },
      );

  StatusAd statusAd = StatusAd.initial;

  @override
  void initState() {
    context.read<FileCubit>().getFiles(isInit: true);

    if (!kDebugMode) {
      myBanner = BannerAd(
        adUnitId: 'ca-app-pub-2465007971338713/8992395637',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: listener(),
      );
      myBanner!.load();

      InterstitialAd.load(
          adUnitId: kDebugMode
              ? 'ca-app-pub-3940256099942544/1033173712'
              : 'ca-app-pub-2465007971338713/3304515640',
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              debugPrint('$ad loaded.');
              _interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('InterstitialAd failed to load: $error');
            },
          ));
    }

    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    if (myBanner != null) {
      myBanner!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: kPrimary,
        displacement: 20,
        onRefresh: () => _refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: statusAd == StatusAd.loaded
                  ? Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                      alignment: Alignment.center,
                      width: myBanner!.size.width.toDouble(),
                      height: myBanner!.size.height.toDouble(),
                      child: AdWidget(ad: myBanner!),
                    )
                  : const SizedBox(),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<FileCubit, FileState>(
                builder: (context, state) {
                  if (state.status == FileStatusCubit.success) {
                    if (state.letters!.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: kViolet.withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.folder_open_rounded,
                                  size: 56,
                                  color: kViolet,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Belum Ada File',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: kTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Generate surat pertamamu\ndi menu Beranda!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kTextSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: state.hasReachMax
                          ? state.letters!.length
                          : state.letters!.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.letters!.length) {
                          final letter = state.letters![index];
                          return Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                            decoration: AppTheme.cardDecoration(),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(kRadiusLg),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(kRadiusLg),
                                onTap: () {
                                  _showDetailFileModal(letter);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: kError.withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(kRadiusSm),
                                        ),
                                        child: const Icon(
                                          Icons.picture_as_pdf_rounded,
                                          color: kError,
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              letter.title ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: kTextPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              letter.name ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: kTextSecondary,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.access_time_rounded,
                                                  size: 12,
                                                  color: kTextMuted,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  diffHumanDate(
                                                      letter.createdAt ?? ''),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: kTextMuted,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.more_vert_rounded,
                                        color: kTextMuted,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: kPrimary,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: const Center(
                        child: CircularProgressIndicator(color: kPrimary),
                      ),
                    );
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Future<void> _showDetailFileModal(LetterModel letter) {
    return AppTheme.showModernBottomSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            letter.title ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            letter.name ?? '',
            style: const TextStyle(color: kTextSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),
          _buildActionTile(
            icon: Icons.edit_rounded,
            color: kInfoBlue,
            title: 'Edit Surat',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return MyFileEditScreen(letter: letter);
              })).then((value) {
                if (value == true) {
                  _refresh();
                }
              });
            },
          ),
          _buildActionTile(
            icon: Icons.share_rounded,
            color: kSuccess,
            title: 'Berbagi',
            onTap: () async {
              if (_interstitialAd != null) {
                await _interstitialAd!.show();
              }
              shareFile(letter.html ?? '', letter.title ?? '');
            },
          ),
          _buildActionTile(
            icon: Icons.download_rounded,
            color: kPrimary,
            title: 'Download',
            onTap: () async {
              if (_interstitialAd != null) {
                await _interstitialAd!.show();
              }
              convert(letter.html ?? '', letter.title ?? '');
            },
          ),
          _buildActionTile(
            icon: Icons.delete_rounded,
            color: kError,
            title: 'Hapus',
            onTap: () {
              Navigator.pop(context);
              _showDeleteDialog(letter);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(kRadiusMd),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(kRadiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: kTextPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: kTextMuted, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(LetterModel letter) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusLg),
          ),
          title: const Text(
            'Hapus Surat?',
            style: TextStyle(fontWeight: FontWeight.w600, color: kTextPrimary),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus "${letter.title}"?',
            style: const TextStyle(color: kTextSecondary),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: kTextSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [kError, Color(0xFFF87171)]),
                borderRadius: BorderRadius.circular(kRadiusSm),
              ),
              child: TextButton(
                child: const Text(
                  'Hapus',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  delete(letter);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
