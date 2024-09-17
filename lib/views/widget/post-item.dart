import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String description;
  final int likes;
  final int comments;

  PostItem({
    required this.username,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.comments,
  });

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
                child: Image.asset(imageUrl, width: 30, height: 30, fit: BoxFit.cover,),
              ),
              SizedBox(width: 10),
              Text(
                username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Image.asset(imageUrl),
          SizedBox(height: 10),
          Text(description),
          SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              Text('$likes curtidas'),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {},
              ),
              Text('$comments comentários'),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}