import 'package:blog/providers/blog-details.dart';
// import 'package:blog/screens/addablog.dart';
// import 'package:blog/screens/blogdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
import '../widgets/blogposts.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogData = Provider.of<Blogs>(context).blogs;
    return BlogPost(blogData, context,1);
  }
}
