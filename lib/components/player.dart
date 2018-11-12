import 'package:flame/components/component.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'dart:ui';
import 'dart:async';


class Player extends PositionComponent {
  Map<String, Animation> animations;
  Position velocity = new Position(320.0, 0.0);
  double y0, yf;
  String state;
  Position targetPos;
  bool moving = false;
  Size dimensions = new Size(0.0, 0.0);
  double health = 100.0;



  Player() {

    final sprite = 'wizard_idle.png';

    animations = new Map<String, Animation>();
    animations['running'] = new Animation.sequenced(sprite, 10, textureWidth: 80.0)
      ..stepTime = 0.1;
    animations['dead'] = new Animation.sequenced(sprite, 3, textureWidth: 16.0, textureX: 16.0 * 8)
      ..stepTime = 0.075;
    state = 'running';

  }
  // TODO: trim to one function?
  bool checkBoundsX() {
    if(this.dimensions.width < x){
      x = x-1;
      return false;
    }
    if(x < 0){
      x = x+1;
      return false;
    }
    return true;
  }

  // TODO: trim to one function?
  bool checkBoundsY() {
    if(this.dimensions.height < y){
      y = y-1;
      return false;
    }
    if(y < 0) {
      y = y+1;
      return false;
    }
    return true;
  }

  @override
  void render(Canvas canvas) {
    prepareCanvas(canvas);
    animations[state].getSprite().render(canvas, 80.0, 80.0);
  }

  @override
  void update(double t) {
    // TODO: needs better handling of radial movement, and doesn't turn off
    animations[state].update(t);
    if(this.moving == true){
      if(targetPos.x > 75.0 && this.checkBoundsX()){
        x = x+1;
      }else if (this.checkBoundsX()) {
        x = x-1;
      }
      if(targetPos.y > 325.00 && this.checkBoundsY()){
        y = y+1;
      }else if(this.checkBoundsY()) {
        y = y-1;
      }
    }
  }
}
