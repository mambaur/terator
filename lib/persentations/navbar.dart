import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/account/screens/account_screen.dart';
import 'package:terator/persentations/home/screens/home_screen.dart';
import 'package:terator/persentations/my_files/screens/my_file_screen.dart';
import 'package:terator/persentations/settings/screens/setting_screen.dart';
import 'package:terator/persentations/subscription/cubit/subscription_cubit.dart';
import 'package:terator/persentations/subscription/widgets/premium_gate.dart';
import 'package:terator/utils/custom_snackbar.dart';

class Navbar extends StatefulWidget {
  final int? selectedIndex;
  const Navbar({super.key, this.selectedIndex});

  /// Switches the bottom-nav tab from a screen inside it
  /// (0 Beranda, 1 File Saya, 2 Akun Surat, 3 Pengaturan).
  static void switchTab(BuildContext context, int index) {
    context.findAncestorStateOfType<_NavbarState>()?._onItemTapped(index);
  }

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
          width: 36,
          height: 36,
          margin: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD97706), Color(0xFFFBBF24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD97706).withValues(alpha: 0.25),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              // Not an IconButton: its 48px minimum size would overflow the
              // 36px circle and push the icon off-center.
              Material(
                type: MaterialType.transparency,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    if (state.isPremium) {
                      CustomSnackbar.show(context,
                          message:
                              "🎉 Selamat! Kamu memiliki akses penuh ke fitur premium!",
                          type: SnackbarType.success);
                    } else {
                      PremiumGate.show(context);
                    }
                  },
                  child: Center(
                    child: Icon(
                      LucideIcons.crown,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              // Premium: dot on the top-right edge.
              if (state.isPremium)
                const Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 8,
                    height: 8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
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
