// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

class Player2 extends StatelessWidget {
  final String name;
  final String message;
  final double x;
  final double y;
  final String direction;
  const Player2(this.x, this.y, this.direction, this.name, this.message);

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      alignment: Alignment(x, y),
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      child: Container(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            direction[0] != 'r'
                ? Align(
                    alignment: Alignment(0, 0),
                    child: Image.asset(
                      'images/w' + direction + '.png',
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  )
                : Align(
                    alignment: Alignment(0.23, 0),
                    child: Transform(
                      transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                      alignment: Alignment.center,
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
              alignment: Alignment(0.2, 0.8),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.amber[100],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.2, -0.8),
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.amber[100],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
