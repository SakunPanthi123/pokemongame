// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemongame/gamescreen.dart';
import 'package:pokemongame/player.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.orange,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double playerX = 0;
  double playerY = 0;
  String playerDirection = 'u1';

  void moveUp() {
    List<String> playerDirections = ['u1', 'u2', 'u3', 'u4', 'u5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerY -= .01;
      setState(() {});

      if (i == 5) {
        timer.cancel();
      }
    });
  }

  void moveDown() {
    List<String> playerDirections = ['d1', 'd2', 'd3', 'd4', 'd5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerY += .01;
      setState(() {});

      if (i == 5) {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    List<String> playerDirections = ['l1', 'l2', 'l3', 'l4', 'l5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerX -= .01;
      setState(() {});

      if (i == 5) {
        timer.cancel();
      }
    });
  }

  void moveRight() {
    List<String> playerDirections = ['r1', 'r2', 'r3', 'r4', 'r5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerX += .01;
      setState(() {});

      if (i == 5) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      body: Column(
        children: [
          // game screen
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  //map
                  GameScreen(
                    playerX,
                    playerY,
                  ),

                  //player
                  Player(playerDirection),
                ],
              ),
            ),
          ),

          // controls
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      moveUp();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text('Up'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          moveLeft();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text('Left'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          moveRight();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text('Right'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      moveDown();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text('Down'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
