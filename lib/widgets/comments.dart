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
    return Flexible(
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
                    "Name of creator",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    comments[indexComments].toString(),

                    textAlign: TextAlign.justify,
                    // textDirection: TextDirection.ltr,
                  ),
                  IconButton(onPressed: (){print(comments[indexComments].values);}, icon: Icon(Icons.textsms_sharp))
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
