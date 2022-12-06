import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/core/loading_overlay.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/repositories/account_repository.dart';

class AccountCreateScreen extends StatefulWidget {
  const AccountCreateScreen({super.key});

  @override
  State<AccountCreateScreen> createState() => _AccountCreateScreenState();
}

class _AccountCreateScreenState extends State<AccountCreateScreen> {
  final AccountRepository _accountRepo = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  bool isReloadBack = false;

  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _placeAndDateOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  final _religionController = TextEditingController();
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
    await _accountRepo.insert({
      "name": _nameController.text,
      "parent_name": _parentNameController.text,
      "place_and_date_of_birth": _placeAndDateOfBirthController.text,
      "gender": _genderController.text,
      "religion": _religionController.text,
      "last_education": _lastEducationController.text,
      "education_class": _educationClassController.text,
      "education_institution": _educationInstitutionController.text,
      "height_or_weight": _heightOrWeightController.text,
      "telephone": _telephoneController.text,
      "email": _emailController.text,
      "marital_status": _maritalStatusController.text,
      "address": _addressController.text,
      "letter_city_written": _letterCityWrittenController.text,
      "created_at": DateSetting.timestamp(),
      "updated_at": DateSetting.timestamp()
    });

    // ignore: use_build_context_synchronously
    LoadingOverlay.hide(context);
    isReloadBack = true;
    // ignore: use_build_context_synchronously
    Navigator.pop(context, isReloadBack);
    CoolAlert.show(
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      title: "Sukses!!!",
      text: "Akun berhasil ditambahkan!",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Akun Baru'),
        foregroundColor: bDark,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                          offset: const Offset(1, 3),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text('Data Akun'),
                        subtitle: Text('Identitas Akun'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama lengkap tidak boleh kosong.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Nama Lengkap *'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _placeAndDateOfBirthController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tempat & tanggal lahir tidak boleh kosong.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              hintText: 'Contoh: Surabaya, 1 Januari 1998',
                              labelText: 'Tempat & Tanggal Lahir *'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _genderController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jenis kelamin tidak boleh kosong.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              hintText: 'Laki-laki / Perempuan',
                              labelText: 'Jenis Kelamin *'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _religionController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Agama'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _maritalStatusController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Status Perkawinan'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _parentNameController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Nama Ortu/Wali'),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                          offset: const Offset(1, 3),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text('Pendidikan'),
                        subtitle: Text('Riwayat Pendidikan'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _lastEducationController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Pendidikan Terakhir'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _educationClassController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Kelas/Semester/Tingkatan'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _educationInstitutionController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Institusi/Sekolah/Kampus'),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                          offset: const Offset(1, 3),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text('Lainnya'),
                        subtitle: Text('Data Lainnya'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _telephoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'No. telp tidak boleh kosong.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'No. Telp *'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Email'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _heightOrWeightController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              hintText: '60/165 cm',
                              labelText: 'Tinggi / Berat Badan'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _letterCityWrittenController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kota tempat menulis surat tidak boleh kosong.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bDanger),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Kota tempat menulis surat *'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'Alamat'),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                          offset: const Offset(1, 3),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text('Tanda Tangan'),
                        subtitle: Text('Tambahkan tanda tanganmu dibawah ini'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bInfo),
                              ),
                              labelStyle: TextStyle(color: bSecondary),
                              labelText: 'No. Telp'),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: bInfo),
                      onPressed: () => submit(),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 15,
                )
              ])),
            ]),
      ),
    );
  }
}
