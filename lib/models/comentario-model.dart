class Comentario {
  final String id;
  final String content;
  final String idNoticia;
  final String idUsuario;
  final String nomeUsuario;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final int version;

  Comentario({
    required this.id,
    required this.content,
    required this.idNoticia,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.createdAt,
    required this.modifiedAt,
    required this.version,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
      id: json['_id'],
      content: json['content'],
      idNoticia: json['idNoticia'],
      nomeUsuario: json['nomeUsuario'],
      idUsuario: json['idUsuario'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'idNoticia': idNoticia,
      'idUsuario': idUsuario,
      'nomeUsuario': nomeUsuario,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      '__v': version,
    };
  }
}