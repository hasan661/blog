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
  String userId;

  Blog({
    required this.date,
    required this.id,
    required this.post,
    required this.title,
    this.isLiked = false,
    required this.comments,
    required this.userId
  });
}

class Blogs with ChangeNotifier {
  String authToken;
  // var previousBlogs;
  String userID;
  List _blogs = [];
  Blogs(this.authToken, this._blogs, this.userID);

  Future<void> fetchblogs([bool filterbyuser =false]) async {
    final filterstring=filterbyuser? 'orderBy="creatorId"&equalTo="$userID"' : '';
    Uri url =
        Uri.parse("https://blog-150f0-default-rtdb.firebaseio.com/blogs.json?auth=$authToken&$filterstring");
    Uri likeurl = Uri.parse(
        "https://blog-150f0-default-rtdb.firebaseio.com/userFavorites/$userID.json?auth=$authToken");

    
        
    

    final response = await http.get(url);
    final extractedblogs = json.decode(response.body) as Map<String, dynamic>;
    final likeresponse=await http.get(likeurl);
    final extractedlike=json.decode(likeresponse.body);
    

    final List<Blog> _loadedblogs = [];

    extractedblogs.forEach((key, value) {

      _loadedblogs.add(
        
        Blog(
          date: DateTime.parse(value['date']),
          id: key,
          post: value['post'],
          title: value['title'],
          userId: value['creatorID'],
          // comments: value["comments"]['comment']
          isLiked: extractedlike == null ? false : extractedlike['isLiked'],

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
        "https://blog-150f0-default-rtdb.firebaseio.com/blogs/$id/comments.json?auth=$authToken");
    final index = _blogs.indexWhere((element) => element.id == id);
    final updatecomments = await http.get(url);
    

    List newcomment = [];
    // print(updatecomments.body);
    var nullornot = updatecomments.body.toString();

    List iteration =
        nullornot != "null" ? json.decode(updatecomments.body)['comment'] : [];
    iteration.forEach((element) {
      newcomment.add(element);
    });

    newcomment.add({"$userID":comment.toString()});
    final response =
        await http.put(url, body: json.encode({"comment": newcomment}));

    _blogs[index].comments = newcomment;

    notifyListeners();
  }

  Future<void> addblog(Blog newBlog) async {
    Uri url =
        Uri.parse("https://blog-150f0-default-rtdb.firebaseio.com/blogs.json?auth=$authToken");
    final timestamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          "post": newBlog.post,
          "title": newBlog.title,
          "date": timestamp.toIso8601String(),
          "comments": [],
          "creatorID":userID
        }));
    final newbloge = Blog(
      date: newBlog.date,
      id: json.decode(response.body)['name'],
      post: newBlog.post,
      title: newBlog.title,
      comments: newBlog.comments,
      userId: userID
    );

    _blogs.add(newbloge);
    notifyListeners();
  }

  Future<void> likeablog(var index) async {
    String id = _blogs[index].id;
    Uri url = Uri.parse(
        "https://blog-150f0-default-rtdb.firebaseio.com/userFavorites/$userID.json?auth=$authToken");
        
    final isitliked = await http.get(url);
    var test=isitliked.body.toString();
    
    
     var initialstatus =(test != "null")? json.decode(isitliked.body)['isLiked']:false;

    http.put(url, body: json.encode({"isLiked": !initialstatus}));

    _blogs[index].isLiked = !_blogs[index].isLiked;

    notifyListeners();
  }

  void deleteablog(var index) {
    var id=_blogs[index].id;
    Uri url = Uri.parse(
        "https://blog-150f0-default-rtdb.firebaseio.com/blogs/$id.json?auth=$authToken");
    http.delete(url);

    _blogs.removeAt(index);
    notifyListeners();
  }
}
