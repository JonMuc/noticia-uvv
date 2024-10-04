class Token {
  String access_token;

  Token({
    required this.access_token,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      access_token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': access_token,
    };
  }
}

class UserToken {
  String username;
  String sub;

  UserToken({
     required this.username,
     required this.sub,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      username: json['email'],
      sub: json['sub'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': username,
      'sub': sub,
    };
  }
}
