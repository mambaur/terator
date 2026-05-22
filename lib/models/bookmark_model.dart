class BookmarkModel {
  int? id;
  String? letterKey;
  String? title;
  String? subtitle;
  String? categoryTitle;
  String? createdAt;

  BookmarkModel({
    this.id,
    this.letterKey,
    this.title,
    this.subtitle,
    this.categoryTitle,
    this.createdAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'],
      letterKey: json['letter_key'],
      title: json['title'],
      subtitle: json['subtitle'],
      categoryTitle: json['category_title'],
      createdAt: json['created_at'],
    );
  }
}
