import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/persentations/letters/screens/letter_editor_screen.dart';
import 'package:terator/persentations/navbar.dart';
import 'package:terator/repositories/account_repository.dart';

class LetterChooseAccountScreen extends StatefulWidget {
  final String keyLetter, title;
  const LetterChooseAccountScreen(
      {super.key, required this.keyLetter, required this.title});

  @override
  State<LetterChooseAccountScreen> createState() =>
      _LetterChooseAccountScreenState();
}

class _LetterChooseAccountScreenState extends State<LetterChooseAccountScreen> {
  final AccountRepository _accountRepo = AccountRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: 'Surat Untuk Siapa?',
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: FutureBuilder<List<AccountModel>>(
        future: _accountRepo.all(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
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
                      'Belum Ada Akun Surat',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Tambahkan akun terlebih dahulu untuk mulai membuat surat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppTheme.gradientButton(
                      label: 'Tambahkan Akun',
                      icon: Icons.person_add_rounded,
                      onTap: () {
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const Navbar(
                              selectedIndex: 2,
                            ),
                          ),
                          ModalRoute.withName('/account-screen'),
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 28),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: ((context, index) {
                final account = snapshot.data![index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  decoration: AppTheme.cardDecoration(),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(kRadiusLg),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(kRadiusLg),
                      onTap: () {
                        if (account.signatureImage != null) {
                          _showSignatureOptionModal(account);
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return LetterEditorScreen(
                              title: widget.title,
                              keyLetter: widget.keyLetter,
                              account: account,
                              withSignature: false,
                            );
                          }));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            AppTheme.avatarInitial(account.name ?? ''),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: kTextMuted, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: kPrimary),
          );
        },
      ),
    );
  }

  Future<void> _showSignatureOptionModal(AccountModel account) {
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
                  color: kPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(kRadiusSm),
                ),
                child:
                    const Icon(Icons.draw_rounded, color: kPrimary, size: 22),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tanda Tangan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Apakah kamu ingin menggunakan tanda tangan ${account.name}?',
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
                    'Tidak',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return LetterEditorScreen(
                        title: widget.title,
                        keyLetter: widget.keyLetter,
                        account: account,
                        withSignature: false,
                      );
                    }));
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: kGradientPrimary),
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
                      'Ya, Gunakan',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return LetterEditorScreen(
                          title: widget.title,
                          keyLetter: widget.keyLetter,
                          account: account,
                          withSignature: true,
                        );
                      }));
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
