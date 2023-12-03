import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './game/gameWidget.dart';
import 'package:flame/game.dart';

final game = FlappyBirdGame();
void main() {
  WidgetsFlutterBinding.ensureInitialized;
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(GameWidget(
    game: game,
  ));
  // runApp(FlappyBirdGame());
}
