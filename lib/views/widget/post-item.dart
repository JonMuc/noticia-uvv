import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PostItem extends StatefulWidget {
  final String username;
  final String imageUrl;
  final String url;
  final String idNoticia;
  final String description;
  final int? likes;
  final int comments;


  PostItem({Key? key, required this.username,
    required this.imageUrl,
    required this.url,
    required this.description,
    this.likes,
    required this.comments,
    required this.idNoticia}) : super(key: key);

  @override
  _PostItem createState() => _PostItem();
}

class _PostItem extends State<PostItem> {
  final List<String> values = ['assets/logo_g1.png', 'assets/logo_cnn.png', 'assets/logo_record.png'];
  bool curtiu = false;
  int quantidadeCurtidas = 0;

  @override
  void initState() {
    atualizarQuantidade();
    super.initState();
  }

  atualizarQuantidade(){
    setState(() {
      quantidadeCurtidas = widget.likes == null ? 0 : widget.likes!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          builder: (context) => PlatformWebViewWidget(
            PlatformWebViewWidgetCreationParams(controller: controller),
          ).build(context),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(getRandomValue(), width: 30, height: 30, fit: BoxFit.cover,),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            // Image.network(widget.imageUrl),
            CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: widget.imageUrl,
            ),
            SizedBox(height: 10),
            Text(widget.description),
            SizedBox(height: 10),
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
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                Text(widget.comments.toString() + ' comentários'),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  String getRandomValue() {
    final random = Random();
    int randomIndex = random.nextInt(values.length);
    return values[randomIndex];
  }

  realizarAvaliacao() async {
    LoginService service = LoginService();
    await service.cutirNoticia(widget.idNoticia, !curtiu);

    var atualizaCurtidada = 0;
    if(!curtiu){
      atualizaCurtidada = quantidadeCurtidas + 1;
    }else{
      atualizaCurtidada = quantidadeCurtidas - 1;
    }

    setState(() {
        curtiu = !curtiu;
        quantidadeCurtidas = atualizaCurtidada;
    });
  }
}