// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokemongame/app.dart';

late double playerX;
late double playerY;
late double gridX = 45;
late double gridY = 45;

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final nameController = TextEditingController();
  final name2Controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
        focusNode2.unfocus();
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Welcome to Village stories'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'First time?',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                width: 1,
                color: Colors.green,
              )),
              child: TextField(
                focusNode: focusNode,
                style: TextStyle(color: Colors.yellow),
                decoration: InputDecoration(
                  hintText:
                      ' Create a username to login into the village with others,',
                  hintStyle: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
                controller: nameController,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  final documentName =
                      firestore.collection('player2').doc(nameController.text);
                  documentName.set({
                    'X': '45',
                    'Y': '45',
                    'direction': 'r1',
                    'name': nameController.text,
                    'PX': '0.9100',
                    'PY': '0.8990',
                  });

                  Future<List<String>> getLatestLocation() async {
                    DocumentSnapshot snapshot = await firestore
                        .collection('player2')
                        .doc(nameController.text)
                        .get();
                    if (snapshot.exists) {
                      var data = snapshot.data() as Map<String, dynamic>;
                      String pX = data['PX'];
                      String pY = data['PY'];
                      String x = data['X'];
                      String y = data['Y'];
                      return Future<List<String>>.value([pX, pY, x, y]);
                    } else {
                      return Future<List<String>>.value(['0.9100', '0.8990']);
                    }
                  }

                  playerX = double.parse((await getLatestLocation())[0]);
                  playerY = double.parse((await getLatestLocation())[1]);
                  gridX = double.parse((await getLatestLocation())[2]);
                  gridY = double.parse((await getLatestLocation())[3]);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyApp(
                            userName: nameController.text,
                          )));
                },
                child: Text('Start!')),
            Text(
              'Past player?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                width: 1,
                color: Colors.green,
              )),
              child: TextField(
                focusNode: focusNode2,
                style: TextStyle(color: Colors.yellow),
                decoration: InputDecoration(
                  hintText:
                      ' Enter your past village name to go straight to game',
                  hintStyle: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
                controller: name2Controller,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  Future<List<String>> getLatestLocation() async {
                    DocumentSnapshot snapshot = await firestore
                        .collection('player2')
                        .doc(name2Controller.text)
                        .get();
                    if (snapshot.exists) {
                      var data = snapshot.data() as Map<String, dynamic>;
                      String pX = data['PX'];
                      String pY = data['PY'];
                      String x = data['X'];
                      String y = data['Y'];
                      return Future<List<String>>.value([pX, pY, x, y]);
                    } else {
                      return Future<List<String>>.value(['0.9100', '0.8990']);
                    }
                  }

                  playerX = double.parse((await getLatestLocation())[0]);
                  playerY = double.parse((await getLatestLocation())[1]);
                  gridX = double.parse((await getLatestLocation())[2]);
                  gridY = double.parse((await getLatestLocation())[3]);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyApp(
                            userName: name2Controller.text,
                          )));
                },
                child: Text('Go!'))
          ],
        ),
      ),
    );
  }
}
