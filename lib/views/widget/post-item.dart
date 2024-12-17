import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/models/comentario-model.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/visualizar-perfil-page.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PostItem extends StatefulWidget {
  final String username;
  final String imageUrl;
  final String url;
  final String idNoticia;
  final String description;
  final String? pathLogo;
  final int? likes;
  final int? comments;
  final bool? liked;
  final bool? salvo;


  PostItem({Key? key, required this.username,
    required this.imageUrl,
    required this.url,
    required this.description,
    this.likes,
    this.liked,
    this.pathLogo,
    this.comments,
    required this.idNoticia,
    this.salvo}) : super(key: key);

  @override
  _PostItem createState() => _PostItem();
}

class _PostItem extends State<PostItem> {
  bool salvo = false;
  bool curtiu = false;
  int quantidadeCurtidas = 0;
  int quantidadeComentarios = 0;
  bool exibirComentario = false;
  final TextEditingController _controller = TextEditingController();

  List<Comentario?> listaComentarios = List<Comentario?>.filled(
      0, null,
      growable: true);

  @override
  void initState() {
    atualizarQuantidade();
    super.initState();
  }

  atualizarQuantidade(){
    setState(() {
      curtiu = widget.liked == null ? false : widget.liked!;
      quantidadeCurtidas = widget.likes == null ? 0 : widget.likes!;
      quantidadeComentarios = widget.comments == null ? 0 : widget.comments!;
      salvo = widget.salvo == null ? false : widget.salvo!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(widget.pathLogo!, width: 30, height: 30, fit: BoxFit.cover,),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          // Image.network(widget.imageUrl),
          GestureDetector(
            onTap: (){
              WebWebViewController controller = WebWebViewController(
                WebWebViewControllerCreationParams(),
              )..loadRequest(
                LoadRequestParams(
                  uri: Uri.parse(widget.url),
                ),
              );
              showModalBottomSheet(
                isScrollControlled: true,
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.6,
                    maxHeight: MediaQuery.of(context).size.height * 0.8
                ),
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: PlatformWebViewWidget(
                    PlatformWebViewWidgetCreationParams(controller: controller),
                  ).build(context),
                ),
              );
            },
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: widget.imageUrl,
            ),
          ),
          SizedBox(height: 10),
          Text(widget.description),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(curtiu ? Icons.favorite_outlined :  Icons.favorite_border),
                    onPressed: () {
                      realizarAvaliacao();
                    },
                  ),
                  Text(quantidadeCurtidas.toString() + ' curtidas'),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      abrirComentario();
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.comment),
                          onPressed: () {},
                        ),
                        Text(quantidadeComentarios.toString() + ' comentários'),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      salvarNoticia();
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(salvo ? Icons.save_as : Icons.save_as_outlined),
                          onPressed: () {
                            salvarNoticia();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          exibirComentario ? Column(
            children: [
              listaComentarios.length == 0 ? Container() : Container(
                height: 150,
                child: ListView.builder(
                  itemCount: listaComentarios.length,
                  itemBuilder: (context, index) {
                    final comentario = listaComentarios[index];
                    return ListTile(
                      leading: GestureDetector(
                        onTap: (){
                          visualizarUser(comentario!.idUsuario!);
                        },
                        child: Icon(
                          Icons.account_circle,
                          size: 40.0,
                          // color: Colors.white,
                        ),
                      ),
                      title: Text(comentario!.nomeUsuario!, style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(comentario!.content!),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: "Escreva um comentário",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: (){
                        enviarComentario();
                      },
                    ),
                  ],
                ),
              )
            ],
          ) : Container(),
          Divider(),
        ],
      ),
    );
  }

  visualizarUser(String idUser) async{
    LoginService service = Provider.of<LoginService>(context, listen: false);
    service.idUsuarioVisualizar = idUser;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => VisualizarPerfilPage()),
            (route) => false);
  }


  enviarComentario() async{
    if(_controller.text.isNotEmpty){
      LoginService service = LoginService();
      await service.comentarNoticia(widget.idNoticia, _controller.text);
      Timer(Duration(seconds: 1), () {
        atualizarListaComentario();
      });
    }
  }

  atualizarListaComentario() async{
    _controller.text = "";
    LoginService service = LoginService();
    var lista = await service.listarComentarios(widget.idNoticia);
    setState(() {
      listaComentarios = lista;
      quantidadeComentarios = quantidadeComentarios + 1;
    });
  }

  abrirComentario() async{
    LoginService service = LoginService();
    var lista = await service.listarComentarios(widget.idNoticia);
    setState(() {
      exibirComentario = !exibirComentario;
      listaComentarios = lista;
    });
  }

  realizarAvaliacao() async {
    LoginService service = LoginService();
    await service.cutirNoticia(widget.idNoticia, !widget.liked!);

    var atualizaCurtidada = 0;
    if(!curtiu){
      atualizaCurtidada = quantidadeCurtidas + 1;
    }else{
      atualizaCurtidada = quantidadeCurtidas - 1;
    }

    setState(() {
        curtiu = !widget.liked!;
        quantidadeCurtidas = atualizaCurtidada;
    });
  }


  salvarNoticia() async {
    LoginService service = LoginService();
    await service.salvarNoticia(widget.idNoticia, !widget.salvo!);

    print(123213);
    print(widget.salvo!);
    setState(() {
      salvo = !widget.salvo!;
    });
  }
}

