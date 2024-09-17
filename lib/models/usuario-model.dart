class Usuario {
  String nome;
  String email;
  String password;
  String id;
  int v;

  Usuario({
    required this.nome,
    required this.email,
    required this.password,
    required this.id,
    required this.v,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      email: json['email'],
      password: json['password'],
      id: json['_id'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'password': password,
      '_id': id,
      '__v': v,
    };
  }
}
