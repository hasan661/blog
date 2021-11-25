import 'package:blog/providers/auth.dart';
import 'package:blog/providers/blog-details.dart';
import 'package:blog/screens/addablog.dart';
import 'package:blog/screens/auth_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Blogs?>(
          update: (ctx, auth, previousblogs) => Blogs(
            auth.token.toString(),
            previousblogs == null ? [] : previousblogs.blogs,
            auth.userid.toString(),
          ),
          create: (ctx) => null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: auth.isAuth ? BlogScreen() : AuthScreen(),
          routes: {
            BlogDetailScreen.routeName: (ctx) => BlogDetailScreen(),
            AddBlogScreen.routeName: (ctx) => AddBlogScreen(),
            UserProfile.routeName: (ctx) => UserProfile()
          },
        ),
      ),
    );
  }
}
