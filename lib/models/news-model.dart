class News {
  int likes;
  String id;
  String title;
  String url;
  String imgUrl;
  String nomePortal;
  int? likeCount;
  int? comments;
  bool? liked;
  bool? salvo;
  String? tag;

  News({
    required this.likes,
    required this.id,
    required this.title,
    required this.url,
    required this.imgUrl,
    required this.nomePortal,
    this.likeCount,
    this.liked,
    this.comments,
    this.salvo,
    this.tag,
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
      liked: json['liked'],
      comments: json['comments'],
      salvo: json['salvo'],
      tag: json['tag'],
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
      'liked': liked,
      'comments': comments,
      'salvo': salvo,
      'tag': tag,
    };
  }
}
