import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════
// Legacy Bootstrap Colors (kept for compatibility)
// ═══════════════════════════════════════════════════
const Color bPrimary = Color(0xFF0D6EFD);
const Color bDanger = Color(0xFFDC3545);
const Color bSuccess = Color(0xFF198754);
const Color bWarning = Color(0xFFFFC107);
const Color bSecondary = Color(0xFF6C757D);
const Color bInfo = Color(0xFF0DCAF0);
const Color bDark = Color(0xFF343A40);

// Legacy App Colors (kept for compatibility)
const Color appLight = Color(0xFFF9FAFE);
const Color appBlue = Color(0xFF156abb);
const Color appBlueLight = Color(0xFF71b5f6);
const Color appSecondary = Color(0xFFf16752);
const Color appSecondaryLight = Color(0xFFf9aa4c);
const Color appPurple = Color(0xFFAD7FFB);
const Color appRed = Color(0xFFF594B7);
const Color appLightPurple = Color(0xFFCCD0F6);
const Color appDark = Color(0xFF0a0f0d);

// ═══════════════════════════════════════════════════
// New Modern Design System
// ═══════════════════════════════════════════════════

// Primary Palette — Indigo → Violet
const Color kPrimary = Color(0xFF4F46E5);
const Color kPrimaryLight = Color(0xFF818CF8);
const Color kPrimaryDark = Color(0xFF3730A3);
const Color kViolet = Color(0xFF7C3AED);
const Color kVioletLight = Color(0xFFA78BFA);

// Neutral / Surface
const Color kSurface = Color(0xFFF8FAFC);
const Color kSurfaceVariant = Color(0xFFF1F5F9);
const Color kCardWhite = Color(0xFFFFFFFF);
const Color kBgLavender = Color(0xFFEEF2FF);

// Text
const Color kTextPrimary = Color(0xFF1E293B);
const Color kTextSecondary = Color(0xFF64748B);
const Color kTextMuted = Color(0xFF94A3B8);

// Semantic
const Color kSuccess = Color(0xFF10B981);
const Color kError = Color(0xFFEF4444);
const Color kWarning = Color(0xFFF59E0B);
const Color kInfoBlue = Color(0xFF3B82F6);

// Category Gradients
const List<Color> kGradientPrimary = [Color(0xFF4F46E5), Color(0xFF7C3AED)];
const List<Color> kGradientSekolah = [Color(0xFF3B82F6), Color(0xFF06B6D4)];
const List<Color> kGradientPekerjaan = [Color(0xFFF59E0B), Color(0xFFF97316)];
const List<Color> kGradientDesa = [Color(0xFF10B981), Color(0xFF34D399)];
const List<Color> kGradientBisnis = [Color(0xFF8B5CF6), Color(0xFFA78BFA)];
const List<Color> kGradientUmum = [Color(0xFFEC4899), Color(0xFFF472B6)];
const List<Color> kGradientKeuangan = [Color(0xFF14B8A6), Color(0xFF5EEAD4)];
const List<Color> kGradientPribadi = [Color(0xFF6366F1), Color(0xFF818CF8)];
const List<Color> kGradientKesehatan = [Color(0xFFEF4444), Color(0xFFF87171)];

// Design Tokens
const double kRadiusSm = 8.0;
const double kRadiusMd = 12.0;
const double kRadiusLg = 16.0;
const double kRadiusXl = 20.0;
const double kRadiusFull = 50.0;

const EdgeInsets kPaddingPage = EdgeInsets.symmetric(horizontal: 20);
const EdgeInsets kPaddingCard = EdgeInsets.all(16);

// Box Shadows
List<BoxShadow> kShadowSm = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.04),
    blurRadius: 8,
    offset: const Offset(0, 2),
  ),
];

List<BoxShadow> kShadowMd = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.06),
    blurRadius: 16,
    offset: const Offset(0, 4),
  ),
];

List<BoxShadow> kShadowLg = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    blurRadius: 24,
    offset: const Offset(0, 8),
  ),
];

List<BoxShadow> kShadowPrimary = [
  BoxShadow(
    color: kPrimary.withValues(alpha: 0.3),
    blurRadius: 16,
    offset: const Offset(0, 6),
  ),
];

// ═══════════════════════════════════════════════════
// Reusable Widgets / Theme Helpers
// ═══════════════════════════════════════════════════

class AppTheme {
  // Gradient AppBar Decoration
  static BoxDecoration get gradientAppBar => const BoxDecoration(
        gradient: LinearGradient(
          colors: kGradientPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );

  // Modern card decoration
  static BoxDecoration cardDecoration({double radius = kRadiusLg}) =>
      BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: kShadowSm,
      );

  // Gradient card decoration
  static BoxDecoration gradientCard(List<Color> colors,
          {double radius = kRadiusLg}) =>
      BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  // Modern input decoration
  static InputDecoration inputDecoration({
    required String label,
    String? hint,
    bool isRequired = false,
    IconData? prefixIcon,
  }) =>
      InputDecoration(
        labelText: isRequired ? '$label *' : label,
        hintText: hint,
        labelStyle: const TextStyle(color: kTextSecondary, fontSize: 14),
        hintStyle: const TextStyle(color: kTextMuted, fontSize: 14),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: kPrimary, size: 20)
            : null,
        filled: true,
        fillColor: kSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMd),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMd),
          borderSide: const BorderSide(color: kPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMd),
          borderSide: const BorderSide(color: kError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMd),
          borderSide: const BorderSide(color: kError, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  // Gradient button
  static Widget gradientButton({
    required String label,
    required VoidCallback onTap,
    List<Color>? colors,
    double? width,
    EdgeInsets? padding,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors ?? kGradientPrimary,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(kRadiusMd),
          boxShadow: kShadowPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modern AppBar
  static PreferredSizeWidget modernAppBar({
    required String title,
    List<Widget>? actions,
    bool centerTitle = true,
    bool showBack = false,
    BuildContext? context,
  }) {
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: gradientAppBar,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      leading: showBack && context != null
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 20),
            )
          : null,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: actions,
    );
  }

  // Modern Bottom Sheet
  static Future<void> showModernBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  // Avatar with initial
  static Widget avatarInitial(String name,
      {double size = 44, List<Color>? gradient}) {
    String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient ?? kGradientPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.4,
          ),
        ),
      ),
    );
  }

  // Section header
  static Widget sectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
    List<Color>? gradient,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient ?? kGradientPrimary,
              ),
              borderRadius: BorderRadius.circular(kRadiusSm),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: kTextPrimary)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: kTextSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
