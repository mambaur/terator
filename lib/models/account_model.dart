class AccountModel {
  int? id;
  String? name,
      parentName,
      placeAndDateOfBirth,
      gender,
      religion,
      lastEducation,
      educationClass,
      educationInstitution,
      heightOrWeight,
      telephone,
      email,
      maritalStatus,
      address,
      signatureImage,
      letterCityWritten,
      createdAt,
      updatedAt;

  AccountModel(
      {this.id,
      this.name,
      this.parentName,
      this.placeAndDateOfBirth,
      this.gender,
      this.religion,
      this.lastEducation,
      this.educationClass,
      this.educationInstitution,
      this.heightOrWeight,
      this.telephone,
      this.email,
      this.maritalStatus,
      this.address,
      this.signatureImage,
      this.letterCityWritten,
      this.createdAt,
      this.updatedAt});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      name: json['name'],
      parentName: json['parent_name'],
      placeAndDateOfBirth: json['place_and_date_of_birth'],
      gender: json['gender'],
      religion: json['religion'],
      lastEducation: json['last_education'],
      educationClass: json['education_class'],
      educationInstitution: json['education_institution'],
      heightOrWeight: json['height_or_weight'],
      telephone: json['telephone'],
      email: json['email'],
      maritalStatus: json['marital_status'],
      address: json['address'],
      signatureImage: json['signature_image'],
      letterCityWritten: json['letter_city_written'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
