import 'package:blog/providers/blog-details.dart';
import 'package:blog/widgets/appdrawer.dart';
import 'package:blog/widgets/blogitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  var isInit=true;
  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<Blogs>(context).fetchblogs();

    }
    isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Home",
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 8, right: 8, left: 8),
        child: BlogItem(),
      ),
    );
  }
}
