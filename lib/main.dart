import 'package:blog/providers/blog-details.dart';
import 'package:blog/screens/addablog.dart';
import 'package:blog/screens/blogdetailscreen.dart';
import 'package:blog/screens/blogscreen.dart';
import 'package:blog/screens/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>Blogs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: BlogScreen(),
        routes: {
          BlogDetailScreen.routeName:(ctx)=>BlogDetailScreen(),
          AddBlogScreen.routeName:(ctx)=>AddBlogScreen(),
          UserProfile.routeName:(ctx)=>UserProfile()
        },
      ),
    );
  }
}


