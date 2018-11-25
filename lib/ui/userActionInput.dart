// Represents the button a user clicks to perform an action

import 'dart:ui';
import 'dart:math';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart';
import '../components/collision.dart';
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
    this.resize(new Size.fromWidth(dimensions));
    this.setByPosition(position);
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

  bool inBoundingBox(Offset event) {
    CollisionBox eventBox = CollisionBox(
      x: event.dx,
      y: event.dy,
      width: 10.0,
      height: 10.0
    );
    final double obstacleX = this.x;
    final double obstacleY = this.y;

    return (eventBox.x < obstacleX + this.width &&
        eventBox.y + eventBox.width > obstacleX &&
        eventBox.y < this.y + this.height &&
        eventBox.height + eventBox.y > obstacleY);
  }
  
  Offset calculateSinCosine(Offset pos) {
    // normalize the x and y based on a 0,0 center point
    Offset center = new Offset(this.x + (this.width/2), this.y + (this.height/2));
    double lenY = pos.dy - center.dy;
    double lenX = pos.dx - center.dx;
    double rad = this.width/2;
    print('LenY: $lenY, c.y: ${center.dy}, pos.y: ${pos.dy}');
    double cos = lenX/rad;
    double sin = lenY/rad;
    print('Cos: $cos, Sin: $sin}');
    return new Offset(cos, sin);
  }
}