import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/settings.dart';

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
    print(123123);

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
      print(22222222222);
      // print(jsonEncode(result));
      // print(result.statusCode);
      return true;

    }catch(e){
      print(e);
      return false;

    }
  }
}