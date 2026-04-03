// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_view/flutter_signature_view.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/repositories/account_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

class AccountUpdateScreen extends StatefulWidget {
  final AccountModel account;
  const AccountUpdateScreen({super.key, required this.account});

  @override
  State<AccountUpdateScreen> createState() => _AccountUpdateScreenState();
}

class _AccountUpdateScreenState extends State<AccountUpdateScreen> {
  final AccountRepository _accountRepo = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  bool isReloadBack = false;
  String? signatureText;

  final double _currentSliderValue = 5;
  Color penColor = Colors.black;
  double strokeWith = 3.0;
  StrokeCap strokeCap = StrokeCap.round;

  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _placeAndDateOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  final _religionController = TextEditingController();
  final _educationNumberController = TextEditingController();
  final _educationFacultyController = TextEditingController();
  final _educationStudyProgramController = TextEditingController();
  final _educationAddressController = TextEditingController();
  final _lastEducationController = TextEditingController();
  final _educationClassController = TextEditingController();
  final _educationInstitutionController = TextEditingController();
  final _heightOrWeightController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _addressController = TextEditingController();
  final _letterCityWrittenController = TextEditingController();

  Future submit() async {
    if (!_formKey.currentState!.validate()) return null;

    LoadingOverlay.show(context);
    String? image;

    if (!_signatureView.isEmpty) {
      Uint8List? data = await _signatureView.exportBytes();
      String base64Image = base64.encode(data!);
      image = base64Image;
    }
    await _accountRepo.update({
      "id": widget.account.id,
      "name": _nameController.text,
      "parent_name": _parentNameController.text,
      "place_and_date_of_birth": _placeAndDateOfBirthController.text,
      "gender": _genderController.text,
      "religion": _religionController.text,
      "last_education": _lastEducationController.text,
      "education_class": _educationClassController.text,
      "education_number": _educationNumberController.text,
      "education_faculty": _educationFacultyController.text,
      "education_study_program": _educationStudyProgramController.text,
      "education_address": _educationAddressController.text,
      "education_institution": _educationInstitutionController.text,
      "height_or_weight": _heightOrWeightController.text,
      "telephone": _telephoneController.text,
      "email": _emailController.text,
      "marital_status": _maritalStatusController.text,
      "address": _addressController.text,
      "signature_image": image ??
          (signatureText != null ? widget.account.signatureImage : null),
      "letter_city_written": _letterCityWrittenController.text,
      "updated_at": DateSetting.timestamp()
    });

    LoadingOverlay.hide();
    isReloadBack = true;
    Navigator.pop(context, isReloadBack);
    CustomSnackbar.show(context,
        type: SnackbarType.success, message: "Akun berhasil diupdate");
  }

  void initData() {
    _nameController.text = widget.account.name ?? '';
    _parentNameController.text = widget.account.parentName ?? '';
    _placeAndDateOfBirthController.text =
        widget.account.placeAndDateOfBirth ?? '';
    _genderController.text = widget.account.gender ?? '';
    _religionController.text = widget.account.religion ?? '';
    _lastEducationController.text = widget.account.lastEducation ?? '';
    _educationNumberController.text = widget.account.educationNumber ?? '';
    _educationClassController.text = widget.account.educationClass ?? '';
    _educationFacultyController.text = widget.account.educationFaculty ?? '';
    _educationStudyProgramController.text =
        widget.account.educationStudyProgram ?? '';
    _educationAddressController.text = widget.account.educationAddress ?? '';
    _educationInstitutionController.text =
        widget.account.educationInstitution ?? '';
    _heightOrWeightController.text = widget.account.heightOrWeight ?? '';
    _telephoneController.text = widget.account.telephone ?? '';
    _emailController.text = widget.account.email ?? '';
    _maritalStatusController.text = widget.account.maritalStatus ?? '';
    _addressController.text = widget.account.address ?? '';
    _letterCityWrittenController.text = widget.account.letterCityWritten ?? '';
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
    initData();
    signatureText = widget.account.signatureImage;
    super.initState();
    refreshCanvas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.modernAppBar(
        title: widget.account.name ?? 'Edit Akun',
        showBack: true,
        context: context,
      ),
      backgroundColor: kSurface,
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            // ─── Section: Data Akun ───
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

            const SizedBox(height: 16),

            // ─── Section: Pendidikan ───
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
                _buildInput(
                    _educationClassController, 'Kelas/Semester/Tingkatan',
                    icon: Icons.class_outlined),
                _buildInput(
                    _educationInstitutionController, 'Institusi/Sekolah/Kampus',
                    icon: Icons.account_balance_outlined),
                _buildInput(_educationFacultyController, 'Fakultas',
                    icon: Icons.domain_outlined),
                _buildInput(_educationStudyProgramController, 'Program Studi',
                    icon: Icons.menu_book_outlined),
                _buildInput(_educationAddressController,
                    'Alamat Institusi/Sekolah/Kampus',
                    icon: Icons.location_on_outlined, isLast: true),
              ],
            ),

            const SizedBox(height: 16),

            // ─── Section: Lainnya ───
            _buildSectionCard(
              icon: Icons.more_horiz_rounded,
              title: 'Lainnya',
              subtitle: 'Data Lainnya',
              gradient: kGradientDesa,
              children: [
                _buildInput(_telephoneController, 'No. Telp',
                    isRequired: true, icon: Icons.phone_outlined),
                _buildInput(_emailController, 'Email',
                    icon: Icons.email_outlined),
                _buildInput(_heightOrWeightController, 'Tinggi / Berat Badan',
                    hint: '60/165 cm', icon: Icons.straighten_outlined),
                _buildInput(
                    _letterCityWrittenController, 'Kota tempat menulis surat',
                    isRequired: true, icon: Icons.place_outlined),
                _buildInput(_addressController, 'Alamat',
                    icon: Icons.home_outlined, isLast: true),
              ],
            ),

            const SizedBox(height: 16),

            // ─── Section: Tanda Tangan ───
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
                    width: (MediaQuery.of(context).size.width - 80) >= 256
                        ? 256
                        : (MediaQuery.of(context).size.width - 80),
                    height: (MediaQuery.of(context).size.width - 80) >= 256
                        ? 256
                        : (MediaQuery.of(context).size.width - 80),
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
                        if (signatureText != null)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Image.memory(const Base64Decoder()
                                .convert(signatureText ?? '')),
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
                                setState(() {
                                  signatureText = null;
                                });
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

            const SizedBox(height: 24),

            // ─── Submit Button ───
            Container(
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
                  'Simpan Perubahan',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () => submit(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ─── Section Card Builder ───
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

  // ─── Input Field Builder ───
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
