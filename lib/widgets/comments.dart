import 'package:blog/providers/auth.dart';

import 'package:flutter/material.dart';
import 'package:blog/providers/blog-details.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  
  BuildContext context;
  List<dynamic> comments;
  int noofcomments;
  String newComment;
  List<dynamic> blogData;
  int index;
  Comments(this.blogData, this.comments, this.index, this.context,
      this.newComment, this.noofcomments);

  @override
  Widget build(BuildContext context) {
    return noofcomments == 0
        ? ListTile(
            leading: CircleAvatar(
              radius: 15,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name of creator",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    newComment = val;
                  },
                )
              ],
            ),
            trailing: Consumer<Blogs>(
              builder: (context, blog, _) => TextButton(
                  onPressed: () {
                    blog.addtocomment(blogData[index].id, newComment);
                  },
                  child: Text("Post")),
            ),
          )
        : Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              // shrinkWrap: true,
              separatorBuilder: (context, int _) => Divider(),

              itemBuilder: (ctx, indexComments) =>

                  // Card(child: Container(height: 20,child: Text())),
                  Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comments[indexComments].keys.toString().replaceAll(new RegExp(r"\p{P}", unicode: true), ""),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          comments[indexComments].values.toString().replaceAll(new RegExp(r"\p{P}", unicode: true), ""),

                          textAlign: TextAlign.justify,
                          // textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                  ),
                  if (indexComments + 1 == noofcomments)
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Provider.of<Auth>(context, listen: false).userid.toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (val) {
                              newComment = val;
                            },
                          )
                        ],
                      ),
                      trailing: Consumer<Blogs>(
                        builder: (context, blog, _) => TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Comment Added"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              blog.addtocomment(blogData[index].id, newComment);
                            },
                            child: Text("Post")),
                      ),
                    ),
                ],
              ),

              itemCount: comments.length,
            ),
          );
  }
}
