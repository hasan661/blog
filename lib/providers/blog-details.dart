import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Blog {
  String id;
  String post;
  String title;
  DateTime date;
  bool isLiked;
  List comments;

  Blog({
    required this.date,
    required this.id,
    required this.post,
    required this.title,
    this.isLiked = false,
    required this.comments,
  });
}

class Blogs with ChangeNotifier {
  List<Blog> _blogs = [];

  Future<void> fetchblogs() async {
    Uri url =
        Uri.parse("https://blog-150f0-default-rtdb.firebaseio.com/blogs.json");
    final response = await http.get(url);
    final extractedblogs = json.decode(response.body) as Map<String, dynamic>;

    final List<Blog> _loadedblogs = [];

    extractedblogs.forEach((key, value) {
      _loadedblogs.add(
        Blog(
          date: DateTime.parse(value['date']),
          id: key,
          post: value['post'],
          title: value['title'],
          // comments: value["comments"]['comment']

          comments:
              value['comments'] == null ? [] : value['comments']['comment'],
        ),
      );
    });
    _blogs = _loadedblogs;
    notifyListeners();
  }

  List get blogs {
    return [..._blogs];
  }

  Future<void> addtocomment(String id, String comment) async {
    Uri url = Uri.parse(
        "https://blog-150f0-default-rtdb.firebaseio.com/blogs/$id/comments.json");
    final index = _blogs.indexWhere((element) => element.id == id);
    final updatecomments = await http.get(url);

    List<String> newcomment = [];
    // print(updatecomments.body);
    var nullornot = updatecomments.body.toString();

    List iteration =
        nullornot != "null" ? json.decode(updatecomments.body)['comment'] : [];
    iteration.forEach((element) {
      newcomment.add(element.toString());
    });

    newcomment.add(comment);
    final response =
        await http.put(url, body: json.encode({"comment": newcomment}));

    _blogs[index].comments = newcomment;

    notifyListeners();
  }

  Future<void> addblog(Blog newBlog) async {
    Uri url =
        Uri.parse("https://blog-150f0-default-rtdb.firebaseio.com/blogs.json");
    final timestamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          "post": newBlog.post,
          "title": newBlog.title,
          "date": timestamp.toIso8601String(),
          "isLiked": newBlog.isLiked,
          "comments": []
        }));
    final newbloge = Blog(
      date: newBlog.date,
      id: json.decode(response.body)['name'],
      post: newBlog.post,
      title: newBlog.title,
      comments: newBlog.comments,
    );

    _blogs.add(newbloge);
    notifyListeners();
  }

  Future<void> likeablog(var index) async {
    String id = _blogs[index].id;
    Uri url = Uri.parse(
        "https://blog-150f0-default-rtdb.firebaseio.com/blogs/$id.json");
    final isitliked = await http.get(url);

    var initialstatus = json.decode(isitliked.body)['isLiked'];

    http.patch(url, body: json.encode({"isLiked": !initialstatus}));

    _blogs[index].isLiked = !_blogs[index].isLiked;

    notifyListeners();
  }

  void deleteablog(var index) {
    var id=_blogs[index].id;
    Uri url = Uri.parse(
        "https://blog-150f0-default-rtdb.firebaseio.com/blogs/$id.json");
    http.delete(url);

    _blogs.removeAt(index);
    notifyListeners();
  }
}
