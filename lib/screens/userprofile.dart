import 'package:blog/providers/blog-details.dart';
import 'package:blog/screens/addablog.dart';
import 'package:blog/widgets/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'blogdetailscreen.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const routeName = "/user-profile";
  @override
  Widget build(BuildContext context) {
    final blogData = Provider.of<Blogs>(context).blogs;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("User-Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
      
          children: [
            CircleAvatar(
              radius: 70,
            ),
            Text("UserName"),
            
            Expanded(
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView.separated(
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
                      DateFormat.yMMMMEEEEd()
                          .format(
                            blogData[index].date,
                          )
                          .toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                    ),
                    FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddBlogScreen.routeName);
              },
              child: Icon(Icons.add),
                    ),
                  ],
                ),
            )
            
          ],
        ),
      ),
    );
  }
}
