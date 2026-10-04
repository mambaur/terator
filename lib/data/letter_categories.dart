import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';

/// Letter categories as shown on Beranda (and the onboarding stepper), in
/// display order. `index` points into `LetterData.listLetters()`.
const List<Map<String, dynamic>> letterCategories = [
  {
    'index': 0,
    'label': 'Sekolah',
    'icon': Icons.school_rounded,
    'gradient': kGradientSekolah,
    'asset': 'assets/icons/school.png',
  },
  {
    'index': 1,
    'label': 'Pekerjaan',
    'icon': Icons.work_rounded,
    'gradient': kGradientPekerjaan,
    'asset': 'assets/icons/work.png',
  },
  {
    'index': 2,
    'label': 'Desa',
    'icon': Icons.location_city_rounded,
    'gradient': kGradientDesa,
    'asset': 'assets/icons/village.png',
  },
  {
    'index': 3,
    'label': 'Bisnis',
    'icon': Icons.business_center_rounded,
    'gradient': kGradientBisnis,
    'asset': 'assets/icons/business.png',
  },
  {
    'index': 4,
    'label': 'Umum',
    'icon': Icons.public_rounded,
    'gradient': kGradientUmum,
    'asset': 'assets/icons/common.png',
  },
  {
    'index': 6,
    'label': 'Keuangan',
    'icon': Icons.account_balance_wallet_rounded,
    'gradient': kGradientKeuangan,
    'asset': 'assets/icons/keuangan.png',
  },
  {
    'index': 5,
    'label': 'Pribadi',
    'icon': Icons.person_rounded,
    'gradient': kGradientPribadi,
    'asset': 'assets/icons/pribadi.png',
  },
  {
    'index': 7,
    'label': 'Kesehatan',
    'icon': Icons.health_and_safety_rounded,
    'gradient': kGradientKesehatan,
    'asset': 'assets/icons/kesehatan.png',
  },
];
