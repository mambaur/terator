// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_view/flutter_signature_view.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/repositories/account_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

class AccountCreateScreen extends StatefulWidget {
  const AccountCreateScreen({super.key});

  @override
  State<AccountCreateScreen> createState() => _AccountCreateScreenState();
}

class _AccountCreateScreenState extends State<AccountCreateScreen>
    with TickerProviderStateMixin {
  final AccountRepository _accountRepo = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  late final TabController _tabController;
  bool isReloadBack = false;
  final double _currentSliderValue = 5;
  Color penColor = Colors.black;
  double strokeWith = 3.0;
  StrokeCap strokeCap = StrokeCap.round;

  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _placeAndDateOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  final _religionController = TextEditingController();
  final _lastEducationController = TextEditingController();
  final _educationClassController = TextEditingController();
  final _educationNumberController = TextEditingController();
  final _educationFacultyController = TextEditingController();
  final _educationStudyProgramController = TextEditingController();
  final _educationAddressController = TextEditingController();
  final _educationInstitutionController = TextEditingController();
  final _heightOrWeightController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _addressController = TextEditingController();
  final _letterCityWrittenController = TextEditingController();

  Future submit() async {
    final invalidTab = _firstInvalidTab();
    if (invalidTab != null) {
      if (_tabController.index != invalidTab) {
        _tabController.animateTo(invalidTab);
        await Future.delayed(const Duration(milliseconds: 300));
      }
      _formKey.currentState?.validate();
      CustomSnackbar.show(context,
          type: SnackbarType.warning,
          message: 'Periksa kembali isian yang wajib diisi.');
      return;
    }
    if (!_formKey.currentState!.validate()) {
      CustomSnackbar.show(context,
          type: SnackbarType.warning,
          message: 'Periksa kembali isian yang wajib diisi.');
      return;
    }
    LoadingOverlay.show(context);
    String? image;

    if (!_signatureView.isEmpty) {
      Uint8List? data = await _signatureView.exportBytes();
      String base64Image = base64.encode(data!);
      image = base64Image;
    }

    await _accountRepo.insert({
      "name": _nameController.text,
      "parent_name": _parentNameController.text,
      "place_and_date_of_birth": _placeAndDateOfBirthController.text,
      "gender": _genderController.text,
      "religion": _religionController.text,
      "last_education": _lastEducationController.text,
      "education_number": _educationNumberController.text,
      "education_faculty": _educationFacultyController.text,
      "education_study_program": _educationStudyProgramController.text,
      "education_address": _educationAddressController.text,
      "education_class": _educationClassController.text,
      "education_institution": _educationInstitutionController.text,
      "height_or_weight": _heightOrWeightController.text,
      "telephone": _telephoneController.text,
      "email": _emailController.text,
      "marital_status": _maritalStatusController.text,
      "address": _addressController.text,
      "signature_image": image,
      "letter_city_written": _letterCityWrittenController.text,
      "created_at": DateSetting.timestamp(),
      "updated_at": DateSetting.timestamp()
    });

    LoadingOverlay.hide();
    isReloadBack = true;
    Navigator.pop(context, isReloadBack);
    CustomSnackbar.show(context,
        type: SnackbarType.success, message: 'Akun berhasil ditambahkan!');
  }

  int? _firstInvalidTab() {
    final requiredByTab = <List<TextEditingController>>[
      [_nameController, _placeAndDateOfBirthController, _genderController],
      <TextEditingController>[],
      [_telephoneController, _letterCityWrittenController],
      <TextEditingController>[],
    ];
    for (int i = 0; i < requiredByTab.length; i++) {
      for (final c in requiredByTab[i]) {
        if (c.text.trim().isEmpty) {
          return i;
        }
      }
    }
    return null;
  }

  late SignatureView _signatureView;

  void refreshCanvas() {
    _signatureView = SignatureView(
      backgroundColor: Colors.transparent,
      penStyle: Paint()
        ..color = penColor
        ..strokeCap = strokeCap
        ..strokeWidth = _currentSliderValue,
    );
    _signatureView.createState();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    refreshCanvas();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: 'Tambah Akun Baru',
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _KeepAlive(child: _buildAkunTab()),
                  _KeepAlive(child: _buildPendidikanTab()),
                  _KeepAlive(child: _buildLainnyaTab()),
                  _KeepAlive(child: _buildSignatureTab()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSaveBar(),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        // First tab lines up with the 20px content padding below.
        padding: const EdgeInsets.symmetric(horizontal: 20),
        labelPadding: const EdgeInsets.only(right: 24),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: kPrimary,
        unselectedLabelColor: Colors.black54,
        indicatorColor: kPrimary,
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        tabs: const [
          Tab(icon: Icon(Icons.person_rounded, size: 20), text: 'Akun'),
          Tab(icon: Icon(Icons.school_rounded, size: 20), text: 'Pendidikan'),
          Tab(icon: Icon(Icons.more_horiz_rounded, size: 20), text: 'Lainnya'),
          Tab(icon: Icon(Icons.draw_rounded, size: 20), text: 'Tanda Tangan'),
        ],
      ),
    );
  }

  Widget _buildAkunTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionCard(
          icon: Icons.person_rounded,
          title: 'Data Akun',
          subtitle: 'Identitas Akun',
          gradient: kGradientPrimary,
          children: [
            _buildInput(_nameController, 'Nama Lengkap',
                isRequired: true, icon: Icons.badge_outlined),
            _buildInput(
                _placeAndDateOfBirthController, 'Tempat & Tanggal Lahir',
                isRequired: true,
                hint: 'Contoh: Surabaya, 1 Januari 1998',
                icon: Icons.cake_outlined),
            _buildInput(_genderController, 'Jenis Kelamin',
                isRequired: true,
                hint: 'Laki-laki / Perempuan',
                icon: Icons.wc_outlined),
            _buildInput(_religionController, 'Agama',
                icon: Icons.auto_awesome_outlined),
            _buildInput(_maritalStatusController, 'Status Perkawinan',
                icon: Icons.favorite_outline),
            _buildInput(_parentNameController, 'Nama Ortu/Wali',
                icon: Icons.family_restroom_outlined, isLast: true),
          ],
        ),
      ],
    );
  }

  Widget _buildPendidikanTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionCard(
          icon: Icons.school_rounded,
          title: 'Pendidikan',
          subtitle: 'Riwayat Pendidikan',
          gradient: kGradientSekolah,
          children: [
            _buildInput(_educationNumberController, 'NIS/NIM/No Pelajar',
                icon: Icons.numbers_outlined),
            _buildInput(_lastEducationController, 'Pendidikan Terakhir',
                icon: Icons.history_edu_outlined),
            _buildInput(_educationClassController, 'Kelas/Semester/Tingkatan',
                icon: Icons.class_outlined),
            _buildInput(
                _educationInstitutionController, 'Institusi/Sekolah/Kampus',
                icon: Icons.account_balance_outlined),
            _buildInput(_educationFacultyController, 'Fakultas',
                icon: Icons.domain_outlined),
            _buildInput(_educationStudyProgramController, 'Program Studi',
                icon: Icons.menu_book_outlined),
            _buildInput(
                _educationAddressController, 'Alamat Institusi/Sekolah/Kampus',
                icon: Icons.location_on_outlined, isLast: true),
          ],
        ),
      ],
    );
  }

  Widget _buildLainnyaTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionCard(
          icon: Icons.more_horiz_rounded,
          title: 'Lainnya',
          subtitle: 'Data Lainnya',
          gradient: kGradientDesa,
          children: [
            _buildInput(_telephoneController, 'No. Telp',
                isRequired: true, icon: Icons.phone_outlined),
            _buildInput(_emailController, 'Email', icon: Icons.email_outlined),
            _buildInput(_heightOrWeightController, 'Tinggi / Berat Badan',
                hint: '60/165 cm', icon: Icons.straighten_outlined),
            _buildInput(
                _letterCityWrittenController, 'Kota tempat menulis surat',
                isRequired: true, icon: Icons.place_outlined),
            _buildInput(_addressController, 'Alamat',
                icon: Icons.home_outlined, isLast: true),
          ],
        ),
      ],
    );
  }

  Widget _buildSignatureTab() {
    final double size = (MediaQuery.of(context).size.width - 80) >= 256
        ? 256
        : (MediaQuery.of(context).size.width - 80);
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.cardDecoration(),
          child: Column(
            children: [
              AppTheme.sectionHeader(
                icon: Icons.draw_rounded,
                title: 'Tanda Tangan',
                subtitle: 'Tambahkan tanda tangan akun',
                gradient: kGradientBisnis,
              ),
              const SizedBox(height: 8),
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusMd),
                  border: Border.all(color: Colors.grey.shade200, width: 2),
                  color: kSurfaceVariant,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kRadiusMd - 1),
                      child: _signatureView,
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: kShadowSm,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: kError,
                            size: 20,
                          ),
                          onPressed: () {
                            _signatureView.clear();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kShadowSm,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: kGradientPrimary),
            borderRadius: BorderRadius.circular(kRadiusMd),
            boxShadow: kShadowPrimary,
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadiusMd),
              ),
            ),
            icon: const Icon(Icons.save_rounded, color: Colors.white),
            label: const Text(
              'Simpan Akun',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () => submit(),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          AppTheme.sectionHeader(
            icon: icon,
            title: title,
            subtitle: subtitle,
            gradient: gradient,
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label, {
    bool isRequired = false,
    String? hint,
    IconData? icon,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: TextFormField(
        controller: controller,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label tidak boleh kosong.';
                }
                return null;
              }
            : null,
        decoration: AppTheme.inputDecoration(
          label: label,
          hint: hint,
          isRequired: isRequired,
          prefixIcon: icon,
        ),
      ),
    );
  }
}

class _KeepAlive extends StatefulWidget {
  final Widget child;
  const _KeepAlive({required this.child});

  @override
  State<_KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<_KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
