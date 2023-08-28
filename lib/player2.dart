// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

class Player2 extends StatelessWidget {
  final double x;
  final double y;
  final String direction;
  const Player2(this.x, this.y, this.direction);

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      alignment: Alignment(x, y),
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      child: direction.substring(0, 1) != 'r'
          ? Image.asset(
              'images/w' + direction + '.png',
              width: 30,
              fit: BoxFit.cover,
            )
          : Transform(
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
    );
  }
}
