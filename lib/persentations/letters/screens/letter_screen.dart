import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:terator/persentations/letters/screens/letter_choose_account_screen.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/persentations/subscription/widgets/premium_gate.dart';

class LetterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> letters;
  final String title;
  const LetterScreen({super.key, required this.letters, required this.title});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: widget.title,
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            slivers: [
              // Header info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Text(
                    '${widget.letters.length} template tersedia',
                    style: const TextStyle(
                      fontSize: 13,
                      color: kTextSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final letter = widget.letters[index];
                    final isPremiumLetter =
                        premiumLetterMap[letter["key"]] == true;
                    return Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      decoration: AppTheme.cardDecoration(),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(kRadiusLg),
                        child:
                            BlocBuilder<SubscriptionCubit, SubscriptionState>(
                          builder: (context, state) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(kRadiusLg),
                              onTap: () {
                                if (!state.isPremium && isPremiumLetter) {
                                  PremiumGate.show(context);
                                  return;
                                }

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return LetterChooseAccountScreen(
                                    title: letter["title"],
                                    keyLetter: letter["key"],
                                  );
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kPrimary.withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(kRadiusSm),
                                      ),
                                      child: const Icon(
                                        Icons.description_outlined,
                                        color: kPrimary,
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
                                            letter["title"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: kTextPrimary,
                                            ),
                                          ),
                                          if (letter["subtitle"] != null) ...[
                                            const SizedBox(height: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: kViolet.withValues(
                                                    alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                letter["subtitle"],
                                                style: const TextStyle(
                                                  color: kViolet,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    isPremiumLetter
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFD97706),
                                                  Color(0xFFF59E0B)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
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
                                          )
                                        : const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: kTextMuted,
                                            size: 16,
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  childCount: widget.letters.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BannerAdWidget(
              margin: const EdgeInsets.only(left: 15, right: 15),
              placement: BannerPlacement.settingPage,
            ),
          ),
        ],
      ),
    );
  }
}
