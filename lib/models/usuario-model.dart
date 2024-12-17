class Usuario {
  String? nome;
  String? email;
  String? password;
  String? id;
  bool? follow;
  int? v;
  List<LikedNews>? likedNews;

  Usuario({
     this.nome,
     this.email,
     this.password,
     this.follow,
     this.likedNews,
     this.id,
     this.v,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      email: json['email'],
      password: json['password'],
      follow: json['follow'],
      likedNews: (json['likedNews'] as List?)
          ?.map((item) => LikedNews.fromJson(item))
          .toList() ?? [],
      id: json['_id'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'password': password,
      'follow': follow,
      'likedNews': likedNews?.map((item) => item.toJson()).toList(),
      '_id': id,
      '__v': v,
    };
  }
}

class LikedNews {
  String id;
  String idNoticia;
  String idUsuario;
  int version;

  LikedNews({
    required this.id,
    required this.idNoticia,
    required this.idUsuario,
    required this.version,
  });

  // Método para converter JSON em um objeto LikedNews
  factory LikedNews.fromJson(Map<String, dynamic> json) {
    return LikedNews(
      id: json['_id'],
      idNoticia: json['idNoticia'],
      idUsuario: json['idUsuario'],
      version: json['__v'],
    );
  }

  // Método para converter um objeto LikedNews em JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'idNoticia': idNoticia,
      'idUsuario': idUsuario,
      '__v': version,
    };
  }
}
