import 'package:blog/providers/blog-details.dart';
import 'package:blog/widgets/comments.dart';
import 'package:blog/widgets/likeandcomment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/blogdetail";

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool commentbox = false;

  @override
  Widget build(BuildContext context) {
    final blogData = Provider.of<Blogs>(context).blogs;
    
    final index = ModalRoute.of(context)!.settings.arguments as int;
    

    final comments = (blogData.isNotEmpty) ? blogData[index].comments as List:[];
    final isLiked = blogData[index].isLiked;
    final noofcomments = comments.length;
    String newComment = "";

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                  // radius: 1,
                  ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blogData[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor
                        // letterSpacing: letterspacing,
                        ),
                  ),
                  Text(
                    blogData[index].post,
                    textAlign: TextAlign.justify,
                    // textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
            LikeAndComment(
              blogData: blogData,
              context: context,
              index: index,
              noofcomments: noofcomments,
              isLiked: isLiked,
            ),
            Comments(
                blogData, comments, index, context, newComment, noofcomments)
          ],
        ),
      ),
    );
  }
}
