import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/game_widget.dart';
import 'package:flame/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  final game = FlappyBirdGame();
  runApp(GameWidget(
    game: game,
  ));
}
