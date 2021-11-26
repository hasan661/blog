import 'package:blog/providers/blog-details.dart';
import '../widgets/blogposts.dart';
import 'package:blog/widgets/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const routeName = "/user-profile";

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var isInit=true;
  
  @override
  Widget build(BuildContext context) {
    
    final blogData = Provider.of<Blogs>(context).blogs;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("User"),
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
              child: BlogPost(blogData, context, 0),
            )
            
          ],
        ),
      ),
    );
  }
}
