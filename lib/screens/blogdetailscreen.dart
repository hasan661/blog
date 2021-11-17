import 'package:blog/providers/blog-details.dart';
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
    final blogData = Provider.of<Blogs>(context, listen: true).blogs;
    final index = ModalRoute.of(context)!.settings.arguments as int;
    final comments = blogData[index].comments as List;
    final noofcomments = comments.length;
    String newComment = "";
   

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
                  onPressed: () {
                    Provider.of<Blogs>(context, listen: false).likeablog(index);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                      ),
                      Text("Like (${blogData[index].nooflikes.toString()})"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      commentbox = true;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.message,
                      ),
                      Text(
                        "Comments ($noofcomments)",
                      )
                    ],
                  ),
                )
              ],
            ),
            if (noofcomments == 0)
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
                        blog.addtocomment(blogData[index].id, newComment);
                      },
                      child: Text("Post")),
                ),
              ),
            Flexible(
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
                                blog.addtocomment(
                                    blogData[index].id, newComment);
                              },
                              child: Text("Post")),
                        ),
                      ),
                  ],
                ),

                itemCount: comments.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
