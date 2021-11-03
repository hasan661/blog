import 'package:blog/widgets/blogitem.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Home"),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          child: BlogItem()),
    );
  }
}
