# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Terator** (Template Surat Generator) is a Flutter mobile app that generates Indonesian formal letters (surat) — e.g. surat izin sakit, surat lamaran pekerjaan, surat keterangan domisili. The user creates an "Akun Surat" (a personal profile of identity fields), picks a letter template, the app fills the template with that profile data, lets the user further edit the HTML in a WYSIWYG editor, then exports the result as PDF.

All user-facing copy and template content is in **Bahasa Indonesia**. Keep new strings, template HTML, and snackbar messages in Indonesian to match the existing app.

**Web is dev-only** (UI preview): on `kIsWeb` all premium features are unlocked (`SubscriptionCubit`), ads/RevenueCat are skipped, sqflite uses `sqflite_common_ffi_web` (`web/sqlite3.wasm` + `web/sqflite_sw.js`), letter previews render HTML in an iframe ([lib/core/platform/](lib/core/platform/)) and PDF export is skipped. Never ship web.

Target platform is primarily **Android** (RevenueCat is configured Android-only; iOS is partially set up but subscriptions/paywall are not wired for iOS).

## Common Commands

```bash
# Get dependencies
flutter pub get

# Run on a connected device / emulator
flutter run

# Static analysis (uses analysis_options.yaml → flutter_lints)
flutter analyze

# Run tests (single test file under test/)
flutter test
flutter test test/widget_test.dart

# Format code
dart format lib/ test/

# Regenerate launcher icons after replacing assets/img/ic_launcher.png
flutter pub run flutter_launcher_icons

# Rename Android application id (was used to set com.caraguna.terator)
flutter pub run change_app_package_name:main com.new.id

# Release build (uses key.properties + android/app/terator-keystore.jks)
flutter build apk --release
flutter build appbundle --release
```

Android requires a `android/key.properties` file alongside `terator-keystore.jks` for release signing — without it the release build will fail. SDK targets: `minSdk = 24`, Java 17.

## Architecture

### Layered structure under [lib/](lib/)

- [lib/main.dart](lib/main.dart) — bootstraps `MobileAds`, Indonesian date locale (`initializeDateFormatting('id_ID', null)`), and wires three global `BlocProvider`s (AccountCubit, FileCubit, SubscriptionCubit). The home widget is `Navbar` wrapped in `UpgradeAlert` (force-update via the `upgrader` package).
- [lib/core/](lib/core/) — cross-cutting infrastructure: `database.dart` (sqflite schema + column-name constants), `styles.dart` (design tokens — colors `kPrimary`/`kViolet`, gradients per letter category, radii `kRadiusSm/Md/Lg/Xl`, `AppTheme` helpers like `modernAppBar`, `cardDecoration`, `showModernBottomSheet`, `inputDecoration`), `constants.dart` (RevenueCat keys + entitlement ID `"Terator Premium"`), `generator.dart` (random string for filenames), `date_setting.dart`, `loading_overlay.dart`, `failure.dart`.
- [lib/models/](lib/models/) — plain POJOs `AccountModel` and `LetterModel` with `fromJson` constructors mirroring sqflite column names (snake_case in DB, camelCase in Dart).
- [lib/repositories/](lib/repositories/) — thin sqflite CRUD wrappers (`AccountRepository`, `LetterRepository`) using `DatabaseInstance` from `core/database.dart`. Both implement paginated `all({limit, page})`.
- [lib/data/](lib/data/) — letter template registry. See "Letter template system" below.
- [lib/persentations/](lib/persentations/) — UI layer (note: directory is spelled "persentations", not "presentations"). Organized by feature (`home/`, `letters/`, `my_files/`, `account/`, `settings/`, `faq/`, `kop_surat/`, `onboarding/`, `bookmarks/`, `subscription/`, `ads/`). FAQ is reached from the settings screen. Each feature typically has `screens/` and (if stateful) `cubits/` or `cubit/`.
- [lib/utils/](lib/utils/) — shared widgets/helpers like `CustomSnackbar`.

### State management — flutter_bloc Cubits

There are three global cubits provided at app root, plus the navbar pattern:

- `AccountCubit` ([lib/persentations/account/account_cubits/cubit/](lib/persentations/account/account_cubits/cubit/)) — paginated list of saved Akun Surat. Mutations (create/update/delete) call the repository directly from screens, then call `getAccounts(isInit: true)` to refresh.
- `FileCubit` ([lib/persentations/my_files/cubits/file_cubit/](lib/persentations/my_files/cubits/file_cubit/)) — paginated list of saved generated letters. Same refresh pattern.
- `SubscriptionCubit` ([lib/persentations/subscription/cubit/subscription_cubit.dart](lib/persentations/subscription/cubit/subscription_cubit.dart)) — RevenueCat wrapper. Exposes `isPremium`, `showPaywall()`, `restorePurchases()`, `checkStatus()`. Initialized in `main.dart` via `..init()`.

Cubit state classes use `part`/`part of` files (`*_state.dart`) and the convention `enum FooStatusCubit { loading, success, error }`.

### Letter template system

This is the heart of the app and the part most likely to be extended.

1. **Template functions** live under [lib/data/letter_functions/](lib/data/letter_functions/) grouped by category folder: `sekolah/`, `pekerjaan/`, `desa/`, `bisnis/`, `umum/`, `pribadi/`, `keuangan/`, `kesehatan/`. Each file exports a single top-level function `String suratXxx(LetterModel? letter, String? img, AccountModel? account, [Map<String, String>? vars])` that returns an HTML string with values interpolated from the `account` (and optional signature `img` base64-encoded `<img>` tag), plus a `const List<LetterVariable> suratXxxVariables` declaring the fillable fields. Placeholders are rendered with `fillVar(vars, key, '... (Label)')` ([lib/models/letter_variable.dart](lib/models/letter_variable.dart)), which falls back to the bold placeholder when the user skipped the field. Full rules: [lib/data/letter_functions/TEMPLATE_RULES.md](lib/data/letter_functions/TEMPLATE_RULES.md).
2. **Central registry** [lib/data/letter_data.dart](lib/data/letter_data.dart) imports every template function and exposes:
   - `LetterData.listLetters({q})` — a hardcoded list of categories (with `id`, `title`, `letters: [{key, title, subtitle?}]`). Each `key` (e.g. `"surat_izin_sakit"`) is the routing identifier.
   - `LetterData.html(key, {image, letter, account, vars})` — looks up the entry by `key` and invokes its template function.
   - `LetterData.variables(key)` — the template's declared `LetterVariable`s.
   - `premiumLetterMap` — a `{key: true}` map gating individual letters behind a premium subscription. Free templates are simply absent from this map.
3. **Editor flow**: `LetterScreen` (category list) → `LetterDetailScreen` (preview, bookmark, kop switch) → `LetterVariableFormScreen` (optional "Isi Data Surat" form, skipped when the template has no variables) → `LetterChooseAccountScreen` (pick an Akun Surat to fill in) → `LetterEditorScreen` ([lib/persentations/letters/screens/letter_editor_screen.dart](lib/persentations/letters/screens/letter_editor_screen.dart)) loads the HTML into `HtmlEditor` (`html_editor_enhanced`), then on save calls `HtmlToPdfConverter().convertHtmlToPdf(...)` and `FlutterFileSaver().writeFileAsBytes(...)`, while also persisting the HTML into the `letters` table via `LetterRepository.insert`.

**To add a new letter template**: (1) create a new file under the appropriate `lib/data/letter_functions/<category>/` returning an HTML string and declaring its variables; (2) import it in `letter_data.dart`, add a new entry to the matching category's `letters` array, and add `"html"` + `"variables"` to `letterDataMap`; (3) if it should be premium, add the key to `premiumLetterMap`. No other wiring is needed — the existing screens render whatever the registry exposes.

### Kop surat (Premium)

Configured in Pengaturan → Kop Surat ([lib/persentations/kop_surat/](lib/persentations/kop_surat/)). `KopSuratRepository` ([lib/repositories/kop_surat_repository.dart](lib/repositories/kop_surat_repository.dart)) stores the text fields + default design in SharedPreferences, copies the logo into the app documents directory, and keeps the set of letter keys whose "Gunakan Kop Surat" switch (on `LetterDetailScreen`) is on. HTML for the 4 designs lives in [lib/data/kop_surat_designs.dart](lib/data/kop_surat_designs.dart), with a Flutter look-alike in `KopDesignPreview`. `htmlForLetter(key, isPremium:)` is prepended to the letter HTML in the detail preview and the editor.

### Onboarding

`OnboardingScreen` ([lib/persentations/onboarding/](lib/persentations/onboarding/)) is shown on first launch (`onboarding_done` flag in SharedPreferences, checked in `main.dart`) and can be reopened from Pengaturan → Panduan Aplikasi.

### Persistence — sqflite

Single local SQLite DB `surat_generator.db` opened by `DatabaseInstance` ([lib/core/database.dart](lib/core/database.dart)) with three tables: `accounts` (the Akun Surat / profile fields including `signature_image` as base64 and `position`/jabatan), `letters` (saved generated documents storing the rendered HTML) and `bookmarks`. `_databaseVersion = 3`; `onUpgrade` migrates step by step (v2 adds `bookmarks`, v3 adds `accounts.position`) — adding columns means bumping the version, adding an `if (oldVersion < N)` step, and updating `onCreate`.

### Subscriptions & premium gating

RevenueCat (Android only) via `purchases_flutter` + `purchases_ui_flutter`. The API key and entitlement ID `"Terator Premium"` live in [lib/core/constants.dart](lib/core/constants.dart). Premium gating shows a reusable bottom sheet via `PremiumGate.show(context)` ([lib/persentations/subscription/widgets/premium_gate.dart](lib/persentations/subscription/widgets/premium_gate.dart)) which calls `SubscriptionCubit.showPaywall()` (RevenueCat's native paywall UI). Check premium with `context.read<SubscriptionCubit>().state.isPremium` or via `BlocBuilder<SubscriptionCubit, SubscriptionState>`.

### Ads

Google Mobile Ads is initialized in `main.dart`. Banner ad widget at [lib/persentations/ads/widgets/banner_ad_widget.dart](lib/persentations/ads/widgets/banner_ad_widget.dart). Conceptually ads should be hidden for premium users — check `isPremium` before rendering when adding new ad placements.

## Conventions

- **Indonesian locale everywhere** — date formatting uses `DateFormat("d MMMM yyyy", "id_ID")`; UI copy is Indonesian.
- **Design system over raw values** — prefer `kPrimary`/`kRadiusMd`/`AppTheme.modernAppBar(...)` from [lib/core/styles.dart](lib/core/styles.dart) instead of hardcoding colors, radii, or building `AppBar` from scratch. The file also contains legacy Bootstrap colors (`bPrimary`, etc.) and old `app*` colors marked as kept-for-compatibility — for new UI use the `k*` tokens.
- **Typo in folder name**: `persentations/` (not `presentations/`) is intentional and used throughout imports — don't rename it.
- **Snackbars**: use `CustomSnackbar.show(context, message: ..., type: SnackbarType.success|error|warning)` from [lib/utils/custom_snackbar.dart](lib/utils/custom_snackbar.dart) rather than the raw `ScaffoldMessenger`.
- **Bottom sheets**: use `AppTheme.showModernBottomSheet(context: ..., child: ...)` for consistency.
- **Signature** is stored as a base64 string in `AccountModel.signatureImage` and injected into HTML as `<img src='data:image/png;base64,...'>` when `withSignature` is true.
