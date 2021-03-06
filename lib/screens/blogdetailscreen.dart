import 'package:blog/providers/blog-details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/blogdetail";

  @override
  Widget build(BuildContext context) {
    final blogData = Provider.of<Blogs>(context, listen: false).blogs;
    final index = ModalRoute.of(context)!.settings.arguments as int;
    final comments = blogData[index].comments;

    // print(comments);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                      ),
                      Text("Like")
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.message,
                      ),
                      Text("Comments")
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, int _) => Divider(),
                itemBuilder: (ctx, indexComments) =>
                
                    // Card(child: Container(height: 20,child: Text())),
                    ListTile(
              leading: CircleAvatar(
                  radius: 15,
                  ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "Name of creator", style: TextStyle(color:  Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    comments[indexComments].toString(),
                    textAlign: TextAlign.justify,
                    // textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
                itemCount: comments.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
