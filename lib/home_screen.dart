import 'package:flutter/material.dart';

import '../db_helper/database_handler.dart';
import '../model/user.dart';
import 'add_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: handler.retrieveUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: w,
                      height: 80.0,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text("Name - ${snapshot.data![index].name} "),
                                Text("age - ${snapshot.data![index].age.toString()}"),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("country - ${snapshot.data![index].country}"),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          handler.deleteUser(snapshot.data![index].id!);
                                          setState(() {
                                            snapshot.data!.remove(snapshot.data![index]);
                                          });
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()));
        },
      ),
    );
  }
}