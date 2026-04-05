import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';

enum StatusAd { initial, loaded }

enum BannerPlacement {
  homePage,
  accountPage,
  myFilePage,
  settingPage,
  faqPage,
  letterPage,
  editAccountPage,
  aboutPage,
  disclaimerPage,
}

class BannerAdWidget extends StatefulWidget {
  final BannerPlacement? placement;
  final EdgeInsetsGeometry? margin;
  const BannerAdWidget({super.key, this.placement, this.margin});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        if (!state.isPremium) {
          return BannerAdWidgetUI(
            placement: widget.placement,
            margin: widget.margin,
          );
        }

        return const SizedBox();
      },
    );
  }
}

class BannerAdWidgetUI extends StatefulWidget {
  final BannerPlacement? placement;
  final EdgeInsetsGeometry? margin;
  const BannerAdWidgetUI({super.key, this.placement, this.margin});

  @override
  State<BannerAdWidgetUI> createState() => _BannerAdWidgetUIState();
}

class _BannerAdWidgetUIState extends State<BannerAdWidgetUI> {
  BannerAd? myBanner;
  StatusAd statusAd = StatusAd.initial;

  BannerAdListener listener() {
    return BannerAdListener(
      onAdLoaded: (Ad ad) {
        if (kDebugMode) print('Ad Loaded');
        setState(() {
          statusAd = StatusAd.loaded;
        });
      },
    );
  }

  Future<void> initBanner() async {
    myBanner = BannerAd(
      adUnitId: getAddUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener(),
    );
    myBanner!.load();
  }

  @override
  void initState() {
    initBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return statusAd == StatusAd.loaded
        ? Container(
            margin: widget.margin ??
                const EdgeInsets.only(left: 15, right: 15, top: 15),
            alignment: Alignment.center,
            width: myBanner!.size.width.toDouble(),
            height: myBanner!.size.height.toDouble(),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AdWidget(ad: myBanner!)),
          )
        : const SizedBox();
  }

  String getAddUnitId() {
    String debugUnitID = 'ca-app-pub-3940256099942544/6300978111';
    if (kDebugMode) return debugUnitID;

    switch (widget.placement) {
      case BannerPlacement.homePage:
        return 'ca-app-pub-2465007971338713/8992395637';
      case BannerPlacement.accountPage:
        return 'ca-app-pub-2465007971338713/7612008736';
      case BannerPlacement.myFilePage:
        return 'ca-app-pub-2465007971338713/4159848885';
      case BannerPlacement.settingPage:
        return 'ca-app-pub-2465007971338713/9140712825';
      case BannerPlacement.faqPage:
        return 'ca-app-pub-2465007971338713/1825329582';
      case BannerPlacement.letterPage:
        return 'ca-app-pub-2465007971338713/6917874164';
      case BannerPlacement.editAccountPage:
        return 'ca-app-pub-2465007971338713/2755267871';
      case BannerPlacement.aboutPage:
        return 'ca-app-pub-2465007971338713/4838505736';
      case BannerPlacement.disclaimerPage:
        return 'ca-app-pub-2465007971338713/8724013490';
      default:
        return debugUnitID;
    }
  }
}
