class LetterModel {
  int? id, accountId;
  String? name, title, html, withSignature, createdAt, updatedAt;

  LetterModel(
      {this.id,
      this.accountId,
      this.name,
      this.title,
      this.html,
      this.withSignature,
      this.createdAt,
      this.updatedAt});

  factory LetterModel.fromJson(Map<String, dynamic> json) {
    return LetterModel(
      id: json['id'],
      accountId: json['account_id'],
      name: json['name'],
      title: json['title'],
      html: json['html'],
      withSignature: json['with_signature'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
