// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final String direction;
  final String name;
  const Player(this.direction, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      child: Stack(
        children: [
          direction.substring(0, 1) != 'r'
              ? Align(
                  alignment: Alignment(0, 0),
                  child: Image.asset(
                    'images/w' + direction + '.png',
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                )
              : Align(
                  alignment: Alignment(0.2, 0),
                  child: Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    child: Image.asset(
                      direction[1] == '1'
                          ? 'images/wl1.png'
                          : direction[1] == '2'
                              ? 'images/wl2.png'
                              : direction[1] == '3'
                                  ? 'images/wl3.png'
                                  : direction[1] == '4'
                                      ? 'images/wl4.png'
                                      : 'images/wl5.png',
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Align(
            alignment: Alignment(0, 0.15),
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.amber[200]),
            ),
          ),
        ],
      ),
    );
  }
}
