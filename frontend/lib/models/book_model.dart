class BookModel {
  String title;
  String author;
  String coverImagePath;
  String genre;
  String description;
  String pages;
  bool isFavorite;

  BookModel({
    required this.title,
    required this.author,
    required this.coverImagePath,
    required this.genre,
    required this.description,
    required this.pages,
    required this.isFavorite,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverImagePath: json['coverImagePath'] ?? '',
      genre: json['genre'] ?? '',
      description: json['description'] ?? '',
      pages: json['pages'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
