import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog/providers/blog-details.dart';

class LikeAndComment extends StatefulWidget {
  BuildContext context;
  int index; 
  List<dynamic> blogData; 
  int noofcomments;
  // String id;
  LikeAndComment({required this.blogData, required this.context, required this.index, required this.noofcomments});

  @override
  _LikeAndCommentState createState() => _LikeAndCommentState();
}

class _LikeAndCommentState extends State<LikeAndComment> {
  @override
  Widget build(BuildContext context) {
    var commentbox=false;
     return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Provider.of<Blogs>(context, listen: false).likeablog(widget.index, );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                    ),
                    Text("Like (${widget.blogData[widget.index].nooflikes.toString()})"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    commentbox = true;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.message,
                    ),
                    Text(
                      "Comments (${widget.noofcomments})",
                    )
                  ],
                ),
              )
            ],
          );
  }
}