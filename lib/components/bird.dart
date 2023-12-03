import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/game_widget.dart';
import 'package:flappy_bird/utils/assets.dart';
import 'package:flappy_bird/utils/config.dart';
import 'package:flutter/widgets.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame> {
  @override
  FutureOr<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    position = Vector2(50, (gameRef.size.y / 2 - size.y / 2));

    current = BirdMovement.middle;
    size = Vector2(50, 40);
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += Config.birdVelocity * dt;
    super.update(dt);
  }

  void fly() {
    add(
      MoveByEffect(
          Vector2(0, Config.gravity),
          EffectController(
            duration: 0.2,
            curve: Curves.decelerate,
          ), onComplete: () {
        current = BirdMovement.down;
      }),
    );
    current = BirdMovement.up;
  }
}
