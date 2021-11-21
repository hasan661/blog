import 'package:blog/providers/blog-details.dart';
import 'package:blog/screens/addablog.dart';
import 'package:blog/screens/blogdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlogPost extends StatefulWidget {
  final List<dynamic> blogData;
  final BuildContext context;
  final int screen;
  BlogPost(this.blogData, this.context, this.screen);

  @override
  _BlogPostState createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.separated(
          separatorBuilder: (context, int index) => Divider(),
          itemCount: widget.blogData.length,
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
                widget.screen == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.blogData[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor
                                // letterSpacing: letterspacing,
                                ),
                          ),
                          IconButton(
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              setState(() {
                                Provider.of<Blogs>(context, listen: false)
                                    .deleteablog(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          )
                        ],
                      )
                    : Text(
                        widget.blogData[index].title,
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
                        widget.blogData[index].date,
                      )
                      .toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  widget.blogData[index].post,
                  textAlign: TextAlign.justify,
                  // textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddBlogScreen.routeName);
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
