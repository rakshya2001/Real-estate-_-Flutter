import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sparrow/api/api_service.dart';

class UserLists extends StatefulWidget {
  const UserLists({Key? key}) : super(key: key);

  @override
  State<UserLists> createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {
  APIService apiService = APIService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List users"),
        ),
        body: Container(
          child: FutureBuilder<List>(
            // future: apiService.getAllUsers(),
            builder: (context, snapshot) {
              
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data![i]['phone'],
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: Text(
                          snapshot.data![i]['username'],
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
            },
          ),
        ));
  }
}
