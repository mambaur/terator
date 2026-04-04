import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/account/screens/account_screen.dart';
import 'package:terator/persentations/faq/screens/faq_screen.dart';
import 'package:terator/persentations/home/screens/home_screen.dart';
import 'package:terator/persentations/my_files/screens/my_file_screen.dart';
import 'package:terator/persentations/settings/screens/setting_screen.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/persentations/subscription/widgets/premium_gate.dart';
import 'package:terator/utils/custom_snackbar.dart';

class Navbar extends StatefulWidget {
  final int? selectedIndex;
  const Navbar({super.key, this.selectedIndex});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  DateTime preBackpress = DateTime.now();
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyFileScreen(),
    AccountScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    }
    super.initState();
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 1:
        return 'File Saya';
      case 2:
        return 'Akun Surat';
      case 3:
        return 'Pengaturan';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _selectedIndex == 0
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: AppTheme.gradientAppBar,
              ),
              title: Row(
                children: [
                  Image.asset(
                    'assets/img/terator-logo-white.png',
                    height: 36,
                  ),
                ],
              ),
              actions: [
                // ─── Subscription Button ───
                _buildSubscriptionButton(),
                // ─── FAQ Button ───
                Container(
                  width: 44,
                  height: 44,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(kRadiusSm),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return const FaqScreen();
                      }));
                    },
                    icon: const Icon(Icons.help_outline_rounded,
                        color: Colors.white, size: 22),
                  ),
                ),
              ],
            )
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: AppTheme.gradientAppBar,
              ),
              title: Text(
                _getTitle(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              actions: [
                // ─── Subscription Button ───
                _buildSubscriptionButton(),
                // ─── FAQ Button ───
                Container(
                  width: 44,
                  height: 44,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(kRadiusSm),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return const FaqScreen();
                      }));
                    },
                    icon: const Icon(Icons.help_outline_rounded,
                        color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kRadiusXl),
          boxShadow: kShadowLg,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kRadiusXl),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.dashboard_rounded,
                  label: 'Beranda',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.folder_rounded,
                  label: 'File Saya',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.person_rounded,
                  label: 'Akun',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.settings_rounded,
                  label: 'Pengaturan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Subscription AppBar Button ───
  Widget _buildSubscriptionButton() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        return Container(
          width: 44,
          height: 44,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: state.isPremium
                ? const Color(0xFFF59E0B).withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(kRadiusSm),
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  //   return const SubscriptionScreen();
                  // }));

                  if (state.isPremium) {
                    CustomSnackbar.show(context,
                        message:
                            "🎉 Selamat! Kamu memiliki akses penuh ke fitur premium!",
                        type: SnackbarType.success);
                  } else {
                    PremiumGate.show(context);
                  }
                },
                icon: Icon(
                  state.isPremium
                      ? Icons.workspace_premium_rounded
                      : Icons.diamond_outlined,
                  color:
                      state.isPremium ? const Color(0xFFFCD34D) : Colors.white,
                  size: 22,
                ),
              ),
              if (state.isPremium)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFCD34D),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? kPrimary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(kRadiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? kPrimary : kTextMuted,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: kPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
