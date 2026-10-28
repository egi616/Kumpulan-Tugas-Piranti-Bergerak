class Article {
  final String title;
  final String? description; //boleh nul ?
  final String? urlToImage;

  Article({
    required this.title, this.description, this.urlToImage
  });

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      title: json['title'] ?? "Tidak ada judul",
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
    );
  }
}