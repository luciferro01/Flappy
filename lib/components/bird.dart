import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/game_widget.dart';
import 'package:flappy_bird/utils/assets.dart';
import 'package:flappy_bird/utils/config.dart';
import 'package:flutter/widgets.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  int score = 0;
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

    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    debugPrint('Collision');
    gameOver();
  }

  void gameOver() {
    gameRef.overlays.add('gameOver');

    FlameAudio.play(Assets.collision);
    gameRef.pauseEngine();
    game.isHit = true;
  }

  void reset() {
    position = Vector2(50, (gameRef.size.y / 2 - size.y / 2));
    score = 0;
  }

  @override
  void update(double dt) {
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
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
    FlameAudio.play(Assets.flying);
  }
}
