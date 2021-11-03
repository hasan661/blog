import 'package:blog/providers/blog-details.dart';
import 'package:blog/screens/blogdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogData = Provider.of<Blogs>(context, listen: false).blogs;
    return ListView.separated(
      separatorBuilder: (context, int index) => Divider(),
      itemCount: blogData.length,
      itemBuilder: (ctx, index) => ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(BlogDetailScreen.routeName, arguments: index);
        },
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
    );
  }
}
