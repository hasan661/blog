import 'package:flutter/cupertino.dart';

class Blog {
  String id;
  String post;
  String title;
  DateTime date;
  int nooflikes;
  List<String> comments;

  Blog({
    required this.date,
    required this.id,
    required this.post,
    required this.title,
    this.nooflikes = 0,
    this.comments = const [],
  });
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
        comments: [
          "Dummy",
          "Dummy",
          
        ]),
    Blog(
        id: "B2",
        post: "Vue.js is top growing front end web development framework",
        title: "Vue.JS",
        date: DateTime.now(),
        comments: []
        ),
  ];

  List get blogs {
    return _blogs;
  }

  void addtocomment(String id, String comment) {
    final index = _blogs.indexWhere((element) => element.id == id);
    print(_blogs[index].id);

    _blogs[index].comments.insert(0, comment);

    notifyListeners();
  }
  void addblog(Blog newBlog){
    _blogs.add(newBlog);
    notifyListeners();

  }
  void likeablog(var index){
    if(_blogs[index].nooflikes==0){
    _blogs[index].nooflikes=_blogs[index].nooflikes+1;
    }
    else{
      _blogs[index].nooflikes=0;
    }
    notifyListeners();

  }
  void deleteablog(var index){
    _blogs.removeAt(index);
    notifyListeners();
    

  }

}
