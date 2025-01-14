import 'package:flutter/material.dart';

import '../db_helper/database_handler.dart';
import '../model/user.dart';
import 'home_screen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late DatabaseHandler handler;


  TextEditingController nameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }


  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    ageTextController.dispose();
    countryTextController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameTextController,
                decoration: const InputDecoration(
                  labelText: 'name',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: ageTextController,
                decoration: const InputDecoration(
                  labelText: 'age',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: countryTextController,
                decoration: const InputDecoration(
                  labelText: 'country',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 100.0,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    handler.initializeDB().whenComplete(() async {
                      User secondUser = User(
                          name: nameTextController.text,
                          age: int.parse(ageTextController.text),
                          country: countryTextController.text
                      );

                      List<User> listOfUsers = [secondUser];
                      handler.insertUser(listOfUsers);
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}