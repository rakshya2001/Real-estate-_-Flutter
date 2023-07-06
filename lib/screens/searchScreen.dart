import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sparrow/Repository/PropertyRepo.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/models/question_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // controller
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),

        title: Text(
          // icon
          "Search any property",
          style: const TextStyle(
            color: Color.fromARGB(255, 32, 81, 165),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // floating: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: CupertinoSearchTextField(
                  key: Key('search_text_field'),
                  padding: EdgeInsets.all(15),
                  controller: _searchController
                    ..addListener(() {
                      setState(() {
                        _searchText = _searchController.text;
                      });
                    }),
                )),
            Container(
                // results
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text(
                  "Showing results",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Expanded(
              child: FutureBuilder<QuestionResponse?>(
                future: PropertyRepo().searchQuestions(_searchText),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // Text
                      List<Questions> lstQuestion = snapshot.data!.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(lstQuestion[index].questionName!),
                            subtitle: Text(
                                'Posted by ${lstQuestion[index].postedBy!.fname!} on ${lstQuestion[index].createdAt!.toString()}'),
                            onTap: () {
                              Navigator.pushNamed(context, '/question',
                                  arguments: {
                                    'id': lstQuestion[index].id,
                                    'fname': lstQuestion[index].postedBy!.fname,
                                    'question': lstQuestion[index].questionName,
                                    'answer': lstQuestion[index].answers,
                                    'answerCount': 12,
                                    'fname': lstQuestion[index].postedBy!.fname,
                                    'postedOn': lstQuestion[index].createdAt,
                                  });
                            },
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("No data"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
