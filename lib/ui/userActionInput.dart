// Represents the button a user clicks to perform an action

import 'dart:ui';
import 'dart:math';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart';
// TODO: create abstract from this or base class for all user inputs and huds

class UserActionInput extends SpriteComponent {
  Sprite active;
  Sprite inactive;
  String state = 'active';
  double coolDownLimit, coolDown;
  Map cordRange;

  // constructor
  UserActionInput(this.active, this.inactive, double dimensions, Position position) : super() {
    this.sprite = this.active;
    this.width = dimensions;
    this.height = dimensions;
    this.x = position.x;
    this.y = position.y;
    }

  @override
  void update(double t) {
    if(state == 'active'){
      sprite = active;
      coolDown = 0.0;
      return;
    }
    if(coolDown >= coolDownLimit){
      coolDown = 0.0;
      state = 'active';
      return;
    }
    coolDown += .1;
    sprite = inactive;
  }

  @override
  render(Canvas canvas) {
    if (sprite != null && sprite.loaded() && x != null && y != null) {
      prepareCanvas(canvas);
      sprite.render(canvas, width, height);
    }
  }

  @override
  bool isHud() {
    return true;
  }

  bool inBoundingBox(Position p) {
    //TODO: vet this or look for an already built funtion, could use as interface for any entity
    double v1 = sqrt(pow(this.y - p.y, 2) + pow(this.x - p.x, 2));
    double v2 = sqrt(pow((this.y + this.height) - p.y, 2) + pow((this.x + this.width) - p.x, 2));
    if(v1 < 75.0 && v2 < 75.0){
      return true;
    }
    return false;
  }
}