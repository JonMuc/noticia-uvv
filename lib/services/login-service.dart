import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:noticia_app/models/news-model.dart';
import 'package:noticia_app/models/token-model.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends ChangeNotifier {

  Future<Usuario> criarConta(String nome, String email, String senha) async{
    var url = "${Settings.apiNovaUrl}users";

    Map data = {
      'nome': nome,
      'email': email,
      'password': senha,
    };

    Dio dio = new Dio();
    dio.options.headers["content-type"] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    var result = await dio.post(url, data: data);
    var usuario = Usuario.fromJson(result.data);
    return usuario;
  }

  Future<bool> login(String email, String senha) async{
    var url = "${Settings.apiNovaUrl}auth/login";

    Map data = {
      'username': email,
      'password': senha,
    };

    try{
      Dio dio = new Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Access-Control-Allow-Origin"] = '*';
      dio.options.headers["Access-Control-Allow-Credentials"] = true;
      dio.options.headers["Access-Control-Allow-Headers"] = "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
      dio.options.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS";
      var result = await dio.post(url, data: data);
      obterUsuario(Token.fromJson(result.data));
      return true;
    }catch(e){
      print(e);
      return false;

    }
  }

  void obterUsuario(Token token) async{
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token.access_token);

    print(21312213);
    print(decodedToken);
    var userToken = UserToken.fromJson(decodedToken);

    var url = "${Settings.apiNovaUrl}users/" + userToken.sub;

    Dio dio = new Dio();
    dio.options.headers["content-type"] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    var result = await dio.get(url);
    var usuario = Usuario.fromJson(result.data);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("usuario", jsonEncode(usuario));
    print(89989889);

  }

  Future<bool> validarUsuario() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = sharedPreferences.get("usuario");

    print(123123223);
    print(result);

    return result == null ? false : true;
  }

  Future<Usuario> obterUsuarioLogado() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Usuario usuarioModel = Usuario.fromJson(jsonDecode(sharedPreferences.getString("usuario")!));
    return usuarioModel;
  }

  Future<List<News>> listarNoticias() async {
    var url = "${Settings.apiNovaUrl}noticias";

    Dio dio = new Dio();
    dio.options.headers["content-type"] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    var result = await dio.get(url);

    return (result.data as List)
        .map((obj) => News.fromJson(obj))
        .toList();
  }

  Future cutirNoticia(String idNoticia, bool curtiu) async {
    var usuario = await obterUsuarioLogado();

    var url = "${Settings.apiNovaUrl}likes";

    Map data = {
      'idNoticia': idNoticia,
      'idUsuario': usuario.id,
      'like': curtiu,
    };

    print(data);

    Dio dio = new Dio();
    dio.options.headers["content-type"] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    await dio.post(url, data : data);
  }
}