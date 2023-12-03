import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flappy_bird/utils/config.dart';

late Bird bird;

class FlappyBirdGame extends FlameGame with TapDetector {
  Timer interval = Timer(Config.pipeInterval, repeat: true);

  @override
  FutureOr<void> onLoad() {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      PipeGroup(),
    ]);
    interval.onTick = () => add(PipeGroup());
    return super.onLoad();
  }

  @override
  void onTap() {
    bird.fly();
    super.onTap();
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }
}
