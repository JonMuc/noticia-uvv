class News {
  int likes;
  String id;
  String title;
  String url;
  String imgUrl;
  String nomePortal;
  int? likeCount;

  News({
    required this.likes,
    required this.id,
    required this.title,
    required this.url,
    required this.imgUrl,
    required this.nomePortal,
    this.likeCount,
  });

  // Factory method to create an instance from JSON
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      likes: json['likes'],
      id: json['_id'],
      title: json['title'],
      url: json['URL'],
      imgUrl: json['ImgURL'],
      nomePortal: json['NomePortal'],
      likeCount: json['likeCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      '_id': id,
      'title': title,
      'URL': url,
      'ImgURL': imgUrl,
      'NomePortal': nomePortal,
      'likeCount': likeCount,
    };
  }
}
