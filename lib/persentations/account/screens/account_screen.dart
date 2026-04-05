// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/account/account_cubits/cubit/account_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/persentations/account/screens/account_create_screen.dart';
import 'package:terator/persentations/account/screens/account_update_screen.dart';
import 'package:terator/persentations/ads/widgets/banner_ad_widget.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/repositories/account_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

import '../../subscription/widgets/premium_gate.dart';

enum StatusAd { initial, loaded }

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ScrollController _scrollController = ScrollController();
  final AccountRepository _accountRepo = AccountRepository();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll &&
        !context.read<AccountCubit>().hasReachMax) {
      context.read<AccountCubit>().getAccounts(isInit: false);
    }
  }

  Future<void> _refresh() async {
    context.read<AccountCubit>().getAccounts(isInit: true);
  }

  Future<void> delete(AccountModel account) async {
    LoadingOverlay.show(context);
    await _accountRepo.delete(account.id!);
    _refresh();
    LoadingOverlay.hide();
    CustomSnackbar.show(context,
        type: SnackbarType.success, message: "Akun berhasil dihapus");
  }

  @override
  void initState() {
    context.read<AccountCubit>().getAccounts(isInit: true);

    _scrollController.addListener(onScroll);
    super.initState();
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
              child: BannerAdWidget(
                placement: BannerPlacement.accountPage,
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  if (state.status == AccountStatusCubit.success) {
                    if (state.accounts!.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: kPrimary.withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_add_alt_1_rounded,
                                  size: 56,
                                  color: kPrimary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Belum Ada Akun',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: kTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Tambahkan akun surat dengan\nmenekan tombol + di bawah',
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
                          ? state.accounts!.length
                          : state.accounts!.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.accounts!.length) {
                          final account = state.accounts![index];
                          return Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                            decoration: AppTheme.cardDecoration(),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(kRadiusLg),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(kRadiusLg),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (builder) {
                                    return AccountUpdateScreen(
                                        account: account);
                                  })).then((value) {
                                    if (value == true) {
                                      _refresh();
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    children: [
                                      AppTheme.avatarInitial(
                                        account.name ?? '',
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              account.name ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: kTextPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              account.address != null &&
                                                      account.address != ''
                                                  ? account.address!
                                                  : (account.telephone ?? ''),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: kTextSecondary,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _showDeleteModal(account),
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: kError.withValues(alpha: 0.6),
                                          size: 22,
                                        ),
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
      floatingActionButton: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, stateAccount) {
          int accountCount = 0;
          if (stateAccount.status == AccountStatusCubit.success) {
            accountCount = (stateAccount.accounts ?? []).length;
          }
          return BlocBuilder<SubscriptionCubit, SubscriptionState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(bottom: 84),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: kGradientPrimary),
                  borderRadius: BorderRadius.circular(kRadiusMd),
                  boxShadow: kShadowPrimary,
                ),
                child: Badge(
                  isLabelVisible: !state.isPremium && accountCount > 3,
                  alignment: Alignment.topLeft,
                  backgroundColor: Color(0xFFF59E0B),
                  label: Icon(
                    Icons.diamond,
                    color: Colors.white,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (!state.isPremium && accountCount > 3) {
                        PremiumGate.show(context);
                        return;
                      }

                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return const AccountCreateScreen();
                      })).then((value) {
                        if (value == true) {
                          _refresh();
                        }
                      });
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: const Icon(Icons.person_add_rounded,
                        color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showDeleteModal(AccountModel account) {
    return AppTheme.showModernBottomSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kError.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(kRadiusSm),
                ),
                child:
                    const Icon(Icons.warning_rounded, color: kError, size: 22),
              ),
              const SizedBox(width: 12),
              const Text(
                'Hapus Akun?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Apakah kamu yakin ingin menghapus akun "${account.name}"?',
            style: const TextStyle(
              fontSize: 14,
              color: kTextSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusMd),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [kError, Color(0xFFF87171)]),
                    borderRadius: BorderRadius.circular(kRadiusMd),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadiusMd),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Hapus',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      delete(account);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
