import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/criar-conta-page.dart';
import 'package:noticia_app/views/dashboard-page.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.network("https://cdn-icons-png.flaticon.com/512/21/21601.png", width: 200,),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  logar();
                },
                child: Text('Entrar'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CriarContaPage()));
                },
                child: Text('Criar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logar() async{
    var service = new LoginService();
    var result = await service.login(emailController.text, passwordController.text);
    if(result){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos!')),
      );
    }

  }
}