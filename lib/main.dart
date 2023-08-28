// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemongame/collisionSolver.dart';
import 'package:pokemongame/gamescreen.dart';
import 'package:pokemongame/player.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
  // collision developer code
  String dir = 'l';

  double step = 0.0467;
  double playerX = 0.91;
  double playerY = 0.899;
  String playerDirection = 'd1';

  // movement disable check
  bool disabled = false;

  // avoidance list
  bool up = true;
  bool down = true;
  bool right = true;
  bool left = true;

  List<List<double>> lDT = [
    [1.0501, 0.8523]
  ];
  List<List<double>> rDT = [];
  List<List<double>> uDT = [];
  List<List<double>> dDT = [];
  List<List<double>> lrDT = [
    [1.0034, 0.9924],
    [0.8633, 0.8990],
    [0.8633, 0.8523],
    [-0.1641, 0.4787],
    [-0.1641, 0.4320],
    [-0.1641, 0.3853],
    [-0.1641, 0.3386],
    [-0.1641, 0.2919],
    [-0.2108, 0.1985],
    [-0.2108, 0.1518],
    [-0.2108, 0.1051],
    [-0.2108, 0.0584],
    [-0.2108, 0.0117],
    [-0.2108, -0.0350],
    [-0.2108, -0.0817],
    [-0.2108, -0.1284],
    [-0.2108, -0.1751],
    [-0.2108, -0.2218],
    [-0.2575, -0.3152],
  ];
  List<List<double>> udDT = [
    [1.1435, 1.0858],
    [1.0501, 1.0391],
    [0.9567, 0.9457],
    [0.9100, 0.9457],
    [0.8166, 0.8056],
    [0.7232, 0.7589],
  ];
  List<List<double>> ldDT = [
    [1.0968, 1.0858],
    [1.0034, 1.0391],
    [0.8633, 0.9457],
    [0.7699, 0.8056],
    [-0.2108, 0.2452],
    [-0.2575, -0.2685],
  ];
  List<List<double>> luDT = [];
  List<List<double>> ruDT = [
    [1.0968, 1.0391],
    [1.0034, 0.9457],
    [0.8633, 0.8056],
    [0.7699, 0.7589],
    [-0.1641, 0.2452],
    [-0.2108, -0.2685],
  ];
  List<List<double>> rdDT = [];

  void avoider() {
    // lDT checker
    for (var innerPair in lDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        left = false;
      }
    }

    // rDT checker
    for (var innerPair in rDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        right = false;
      }
    }
    // uDT checker
    for (var innerPair in uDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        up = false;
      }
    }
    // dDT checker
    for (var innerPair in dDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        down = false;
      }
    }
    // lrDT checker
    for (var innerPair in lrDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        left = false;
        right = false;
      }
    }
    // udDT checker
    for (var innerPair in udDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        up = false;
        down = false;
      }
    }
    // ldDT checker
    for (var innerPair in ldDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        left = false;
        down = false;
      }
    }
    // luDT checker
    for (var innerPair in luDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        left = false;
        up = false;
      }
    }
    // ruDT checker
    for (var innerPair in ruDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        right = false;
        up = false;
      }
    }
    // rdDT checker
    for (var innerPair in rdDT) {
      if (innerPair[0] == double.parse(playerX.toStringAsFixed(4)) &&
          innerPair[1] == double.parse(playerY.toStringAsFixed(4))) {
        right = false;
        down = false;
      }
    }
  }

  void moveUp() {
    disabled = true;
    down = true;
    left = true;
    right = true;
    List<String> playerDirections = ['u1', 'u2', 'u3', 'u4', 'u5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerY -= step / 5;
      setState(() {});

      if (i == 5) {
        timer.cancel();
        disabled = false;
        // call the developer collision function
        solver(dir, playerX.toStringAsFixed(4), playerY.toStringAsFixed(4));
      }
    });
  }

  void moveDown() {
    disabled = true;
    left = true;
    right = true;
    up = true;
    List<String> playerDirections = ['d1', 'd2', 'd3', 'd4', 'd5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerY += step / 5;
      setState(() {});

      if (i == 5) {
        timer.cancel();
        disabled = false;
        // call the developer collision function
        solver(dir, playerX.toStringAsFixed(4), playerY.toStringAsFixed(4));
      }
    });
  }

  void moveLeft() {
    disabled = true;
    up = true;
    down = true;
    right = true;
    List<String> playerDirections = ['l1', 'l2', 'l3', 'l4', 'l5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerX -= step / 5;
      setState(() {});

      if (i == 5) {
        timer.cancel();
        disabled = false;

        // call the developer collision function
        solver(dir, playerX.toStringAsFixed(4), playerY.toStringAsFixed(4));
      }
    });
  }

  void moveRight() {
    disabled = true;
    up = true;
    down = true;
    left = true;
    List<String> playerDirections = ['r1', 'r2', 'r3', 'r4', 'r5'];
    var i = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      playerDirection = playerDirections[i];
      i++;
      playerX += step / 5;
      setState(() {});

      if (i == 5) {
        timer.cancel();
        disabled = false;
        // call the developer collision function
        solver(dir, playerX.toStringAsFixed(4), playerY.toStringAsFixed(4));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                dir = 'l';
                              },
                              child: Row(
                                children: [Icon(Icons.arrow_left)],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'u';
                              },
                              child: Row(
                                children: [Icon(Icons.arrow_drop_up)],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'r';
                              },
                              child: Row(
                                children: [Icon(Icons.arrow_right)],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'd';
                              },
                              child: Row(
                                children: [Icon(Icons.arrow_drop_down)],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'lr';
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_left),
                                  Icon(Icons.arrow_right)
                                ],
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                dir = 'ud';
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_drop_up),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'ld';
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_left),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'lu';
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_left),
                                  Icon(Icons.arrow_drop_up)
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'ru';
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_right),
                                  Icon(Icons.arrow_drop_up)
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                dir = 'rd';
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_right,
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!disabled) {
                        avoider();
                        if (up) {
                          moveUp();
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text('Up'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!disabled) {
                            avoider();
                            if (left) {
                              moveLeft();
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text('Left'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!disabled) {
                            avoider();
                            if (right) {
                              moveRight();
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text('Right'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!disabled) {
                        avoider();
                        if (down) {
                          moveDown();
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text('Down'),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                        onPressed: () {
                          clear();
                        },
                        child: Text('X')),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
