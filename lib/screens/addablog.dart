import 'package:blog/providers/blog-details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBlogScreen extends StatelessWidget {
  static const routeName = "/addblog";
  var newpost = Blog(
    date: DateTime.now(),
    id: "",
    post: "",
    title: "",
    comments: [],
    isLiked: false,
  );
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> _saveform() async {
      final isValid = _formkey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formkey.currentState!.save();
      Provider.of<Blogs>(context, listen: false).addblog(newpost);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Blog Added"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Add Blog"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _saveform();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                onSaved: (val) => {
                  newpost = Blog(
                    date: DateTime.now(),
                    id: "",
                    post: newpost.post,
                    title: val.toString(),
                    comments: []
                  )
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Blog",
                ),
                onSaved: (val) {
                  newpost = Blog(
                    date: DateTime.now(),
                    id: "",
                    post: val.toString(),
                    title: newpost.title,
                    comments: []
                  );
                },
                keyboardType: TextInputType.multiline,
                maxLines: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
