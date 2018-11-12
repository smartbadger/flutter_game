
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/animation.dart';
import 'package:flame/position.dart';
import 'dart:math';

import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'dart:async';
import '../components/entity.dart';


class Creep extends PositionComponent {
  Map<String, Animation> animations;
  Position velocity = new Position(320.0, 0.0);
  double y0, yf;
  String state;
  // TODO: set initial value (player location), will also need to handle init position which will be from enemy position
  Position targetPos = new Position(300.0, 300.0);
  bool moving = false;
  Size dimensions = new Size(0.0, 0.0);
  double health = 100.0;
  double attackCoolDown = 15.0;
  double attackCool = 0.0;


  Creep() {
    //TODO: map these correctly by putting into array or something
    final sprite = 'Skeleton_Idle.png';
    animations = new Map<String, Animation>();
    animations['idle'] = new Animation.sequenced(sprite, 11, textureWidth: 24.0, textureHeight: 33.0)
      ..stepTime = 0.1;
    animations['running'] = new Animation.sequenced('Skeleton_Walk.png', 13, textureWidth: 22.0, textureHeight: 32.0)
      ..stepTime = 0.1;
    animations['attack'] = new Animation.sequenced('Skeleton_Hit.png', 11, textureWidth: 24.0, textureHeight: 32.0)
      ..stepTime = 0.1;
    animations['dead'] = new Animation.sequenced('Skeleton_Dead.png', 11, textureWidth: 24.0, textureHeight: 32.0)
      ..stepTime = 0.1;
    state = 'idle';

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
  void attack(Entity c){
    if(attackCool >= attackCoolDown){
      print("ATTACK");
      state = 'attack';
      c.health -= 50.0;
      print(c.health);
      attackCool = 0.0;
    }else {
      print('wait');
      attackCool += 0.1;
      state = 'idle';
      return;
    }
  }
  @override
  bool destroy() {
    return (this.health <= 0.0);
  }
  @override
  void render(Canvas canvas) {
    prepareCanvas(canvas);
    animations[state].getSprite().render(canvas, 80.0, 80.0);
  }

  @override
  void update(double t) {
    // TODO: needs better handling of radial movement, and doesn't turn off, also need smoother animation handling



    animations[state].update(t);
      if(targetPos.x > x ){
        x = x+0.8;
      }else if (targetPos.x < x) {
        x = x-0.8;
      }
      if(targetPos.y > y){
        y = y+0.8;
      }else if(targetPos.y < y ) {
        y = y-0.8;
      }

  }
}
