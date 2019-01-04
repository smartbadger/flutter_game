
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/animation.dart';
import 'package:flame/position.dart';
import '../components/creep.dart';
import 'package:flame/components/debug_component.dart';

import 'dart:math';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'dart:async';

class Entity extends PositionComponent {

  Map<String, Animation> animations;
  String state;
  double baseSpeed = 1.0;
  Offset targetPos;
  bool moving = false;
  Size dimensions = new Size(0.0, 0.0);
  double health = 100.0;
  // TODO: might need separate debug for collision vs sprite
  Color debugColor = const Color(0xFFFF00FF);
  bool inDebugMode = true;

  Paint get paint => new Paint()
    ..color = debugColor
    ..style = PaintingStyle.stroke;


  // TODO: build a datasheet with all the sprite values, animations and states to be called anytime
  Entity(this.animations);

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
    animations[state].getSprite().render(canvas, width, height);
    if(this.inDebugMode){
      canvas.drawRect(new Rect.fromLTWH(x, y, width, height), paint);
    }
  }

  @override
  void update(double t) {
    // TODO: needs better handling of radial movement, and doesn't turn off
    animations[state].update(t);
    if(this.moving == true){
      x = (x + (this.baseSpeed * targetPos.dx));
      y = (y + (this.baseSpeed * targetPos.dy));
    }
  }


//  Map<String, Animation> animations;
//  Position velocity = new Position(320.0, 0.0);
//  double y0, yf;
//  String state;
//  // TODO: set initial value (player location), will also need to handle init position which will be from enemy position
//  Position targetPos = new Position(300.0, 300.0);
//  bool moving = false;
//  Size dimensions = new Size(0.0, 0.0);
//  double health = 100.0;
//  double attackCoolDown = 15.0;
//  double attackCool = 0.0;
//
//  Entity() {
//    //TODO: map these correctly by putting into array or something
//    final sprite = 'knight__idle.png';
//    animations = new Map<String, Animation>();
//    animations['idle'] = new Animation.sequenced(sprite, 4, textureWidth: 42.0, textureHeight: 42.0)
//      ..stepTime = 0.1;
//    animations['running'] = new Animation.sequenced('knight_walk_animation.png', 8, textureWidth: 42.0, textureHeight: 42.0)
//      ..stepTime = 0.1;
//    animations['attack'] = new Animation.sequenced('night__improved_slash_animation.png', 10, textureWidth: 42.0, textureHeight: 42.0)
//      ..stepTime = 0.1;
//    animations['dead'] = new Animation.sequenced('knight_death_animation.png', 11, textureWidth: 24.0, textureHeight: 32.0)
//      ..stepTime = 0.1;
//    state = 'idle';
//
//
//  }
//  // TODO: trim to one function?
//  bool checkBoundsX() {
//    if(this.dimensions.width < x){
//      x = x-1;
//      return false;
//    }
//    if(x < 0){
//      x = x+1;
//      return false;
//    }
//    return true;
//  }
//
//  // TODO: trim to one function?
//  bool checkBoundsY() {
//    if(this.dimensions.height < y){
//      y = y-1;
//      return false;
//    }
//    if(y < 0) {
//      y = y+1;
//      return false;
//    }
//    return true;
//  }
//
//  void attack(Creep c){
//    if(attackCool >= attackCoolDown){
//      print("ATTACK");
//      state = 'attack';
//      c.health -= 50.0;
//      print(c.health);
//      attackCool = 0.0;
//    }else {
//      print('wait');
//      attackCool += 0.1;
//      state = 'idle';
//      return;
//    }
//  }
//
//  @override
//  void render(Canvas canvas) {
//    prepareCanvas(canvas);
//    animations[state].getSprite().render(canvas, 80.0, 80.0);
//  }
//
//  @override
//  bool destroy() {
//    return (this.health <= 0.0);
//  }
//
//  @override
//  void update(double t) {
//    // TODO: needs better handling of radial movement, and doesn't turn off, also need smoother animation handling
//
//    animations[state].update(t);
//    if(targetPos.x > x ){
//      x = x+0.8;
//    }else if (targetPos.x < x) {
//      x = x-0.8;
//    }
//    if(targetPos.y > y){
//      y = y+0.8;
//    }else if(targetPos.y < y ) {
//      y = y-0.8;
//    }
//
//  }
}
