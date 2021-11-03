import 'package:flutter/cupertino.dart';

class Blog {
  String id;
  String post;
  String title;
  DateTime date;
  int nooflikes;
  List<String> comments;

  Blog(
      {required this.date,
      required this.id,
      required this.post,
      required this.title,
      this.nooflikes = 0,
      this.comments = const []});
}

class Blogs with ChangeNotifier {
  final _blogs = [
    Blog(
        id: "B1",
        post:
            "Flutter Is The Growing Mobile App Development System Developed By Google",
        title: "Flutter",
        date: DateTime.now(),
        // postimageurl: "https://www.freecodecamp.org/news/content/images/2021/08/Flutter-logo.png"
        comments: ["Dummy"]),
    Blog(
      id: "B2",
      post: "Vue.js is top growing front end web development framework",
      title: "Vue.JS",
      date: DateTime.now(),
      // postimageurl: "https://3lhowb48prep40031529g5yj-wpengine.netdna-ssl.com/wp-content/uploads/2019/10/logo-vuejs-min.png"
    ),
  ];

  List get blogs {
    return _blogs;
  }
}
