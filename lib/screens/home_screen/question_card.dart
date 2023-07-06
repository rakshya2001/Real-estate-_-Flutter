import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:sparrow/api/PropertyAPI.dart';
import 'package:sparrow/helpers/shared_pref.dart';
import 'package:sparrow/models/answers_model.dart';
import 'package:get/get.dart';
import 'package:sparrow/utils/config.dart';

class QuestionCard extends StatefulWidget {
  QuestionCard(
      {Key? key,
      required this.id,
      required this.question,
      // required this.answer,
      // required this.answerCount,
      required this.fname,
      required this.postedOn,
      required this.postedById,
      required this.likes,
      required this.qsnImage,
      required this.profile,
      required this.username,
      required this.onPressed})
      : super(key: key);

  final String id;
  final String profile;
  final String question;
  final String qsnImage;
  final String fname;
  final String postedOn;
  final String username;
  final String postedById;
  // List<Answers> answer;
  List<String> likes;
  // final int answerCount;
  final Function() onPressed;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  _increaseLikes() {
    PropertyAPI().like(widget.id).then((value) => print("Succss"));
  }

  @override
  Widget build(BuildContext context) {
    // var firstAns = widget.answer[0].text!;
    
    // var ansLength = widget.answer.length;

    RxInt likes = widget.likes.length.obs;

    // get id from shared pref
    String? id;
    sharedPref().getUserDetails().then((value) => 
      id = value['id']
    );

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/other', arguments: {
                  'id': widget.postedById,
                });
              },
              child: Config.apiURL.contains("10.0.2.2") ?
                CachedNetworkImage(
                  imageUrl: widget.profile.replaceAll('localhost', '10.0.2.2'),
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ) :
                CachedNetworkImage(
                  imageUrl: "http://i.pravatar.cc/300",
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
            ),
            title: Text('${widget.fname}'),
            subtitle: Text(
              'posted on ${widget.postedOn}',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          // answer
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/question', arguments: {
                'id': widget.id,
                'fname': widget.fname,
                'question': widget.question,
                // 'answer': widget.answer,
                // 'answerCount': widget.answerCount,
                'postedOn': widget.postedOn,
                'postedById':widget.postedById,
                'username': widget.username,
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${widget.question}',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
               
              
                widget.qsnImage == null ?
                Image.asset(
                  'assets/images/ans-def.png',
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.cover,
                ) 
                
                :
                CachedNetworkImage(
                  imageUrl: "${widget.qsnImage}",
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          ),

          ButtonBar(
            // buttonbar with like add answers and share
            alignment: MainAxisAlignment.end,
            children: [
              // love button without fill and text
              Obx(() {
                return Text("${likes.value} likes");
              }),

              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Color.fromARGB(255, 203, 34, 34).withOpacity(0.6),
                ),
                onPressed: () {
                  _increaseLikes();
                  likes.value++;
                },
              ),

              // badge with answer count
         
            ],
          ),
        ],
      ),
    );
  }
}
