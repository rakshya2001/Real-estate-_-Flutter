
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sparrow/Repository/PropertyRepo.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/models/question_model.dart';
import 'package:sparrow/screens/registration/activateScreen.dart';
import 'package:sparrow/screens/home_screen/question_card.dart';
import 'package:sparrow/screens/loginScreen.dart';

import '../../helpers/DarkMode/dark_provider.dart';

// color
Color primaryColor = Color(0xFF00796B);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> lstWidget = [
    const HomeScreen(),
    LoginScreen(),
    const ActivateScreen()
  ];

  Color bgBlack = Color.fromARGB(255, 0, 34, 224);
  Color mainBlack = Colors.transparent;
  Color fbBlue = Color.fromARGB(255, 14, 14, 158);
  Color mainGrey = Color.fromARGB(255, 6, 1, 1);

  // question model
  List<Questions>? questions = [];
  String? firstAns;

  _reloadData() async {
    try {
      PropertyRepo().getQuestions();
    } catch (e) {
      print(e);
    }
  }

  // load from hive
  final box = Hive.box('test').get('qsn');
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,

        title: const Text(
          // icon
          "Gharjagga Bazar",
          style: TextStyle(
            color: Color.fromARGB(255, 32, 81, 165),
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        centerTitle: true,
        // floating: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _reloadData();
        },
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuestionResponse?>(
                future: PropertyRepo().getQuestions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // Text
                      List<Questions> lstQuestion = snapshot.data!.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                QuestionCard(
                                  key: Key(lstQuestion[index].id!),
                                  id: lstQuestion[index].id!,
                                  fname: lstQuestion[index].postedBy!.fname!,
                                  postedById: lstQuestion[index].postedBy!.id!,
                                  profile:
                                      lstQuestion[index].postedBy!.profile!,
                                  postedOn: lstQuestion[index].createdAt!,
                                 
                                  question: lstQuestion[index].questionName!,
                                  qsnImage: lstQuestion[index].questionImage!,
                                  onPressed: () {
                                    print("Hello");
                                  },
                                  // answer: lstQuestion[index].answers!,
                                  likes: lstQuestion[index].likes!,
                                  username: lstQuestion[index].postedBy!.username!,
                                  // answerCount: 12,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No Data"),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    );
                  } else {
                    return const Text("Error");
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
