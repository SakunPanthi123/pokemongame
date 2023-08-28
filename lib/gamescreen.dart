// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  double playerX;
  double playerY;
  GameScreen(this.playerX, this.playerY);

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      alignment: Alignment(playerX, playerY),
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      child: Image.asset(
        'images/map2.png',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 7,
        filterQuality: FilterQuality.none,
      ),
    );
  }
}
