import 'package:blog/providers/blog-details.dart';
import 'package:blog/screens/blogdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  DateFormat.yMMMMEEEEd()
                      .format(
                        blogData[index].date,
                      )
                      .toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
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
