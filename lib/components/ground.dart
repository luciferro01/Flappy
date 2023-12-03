import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/game/game_widget.dart';
import 'package:flappy_bird/utils/assets.dart';
import 'package:flappy_bird/utils/config.dart';

class Ground extends ParallaxComponent<FlappyBirdGame> {
  @override
  FutureOr<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax(
      [
        ParallaxLayer(
          ParallaxImage(ground, fill: LayerFill.none),
        ),
      ],
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}
