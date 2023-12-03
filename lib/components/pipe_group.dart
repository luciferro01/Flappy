import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/game_widget.dart';
import 'package:flappy_bird/game/pipe_position.dart';
import 'package:flappy_bird/utils/assets.dart';
import 'package:flappy_bird/utils/config.dart';
import 'package:flutter/foundation.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  final _random = Random();

  @override
  FutureOr<void> onLoad() {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2)),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      updateScore();
      FlameAudio.play(Assets.collision);
      removeFromParent();
      debugPrint('Removed');
    }
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }

    super.update(dt);
  }

  void updateScore() {
    gameRef.bird.score += 1;

    FlameAudio.play(Assets.point);
  }
}
