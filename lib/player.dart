// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final String direction;
  const Player(this.direction);

  @override
  Widget build(BuildContext context) {
    log(direction.substring(1));
    return Container(
      alignment: Alignment(0, 0),
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
