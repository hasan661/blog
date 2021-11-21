import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog/providers/blog-details.dart';

class LikeAndComment extends StatelessWidget {
  BuildContext context;
  int index; 
  List<dynamic> blogData; 
  int noofcomments;
  bool isLiked;

  // String id;
  LikeAndComment({required this.blogData, required this.context, required this.index, required this.noofcomments, required this.isLiked});
  @override
  Widget build(BuildContext context) {
    // var commentbox=false;
     return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Provider.of<Blogs>(context, listen: false).likeablog(index, );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      isLiked? Icons.thumb_up_sharp :
                      Icons.thumb_up_alt_outlined,
                    ),
                   
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.message,
                    ),
                    Text(
                      "Comments ($noofcomments)",
                    )
                  ],
                ),
              )
            ],
          );
  }
}