
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/gestures.dart';
// TODO: create abstract from this or base class for all user inputs and huds

class UserControlPad extends PositionComponent {
  static final Paint paint = new Paint()..color = Color.fromRGBO(218, 128, 255, 0.4);
  Paint get debugPaint => new Paint()
    ..color = Color.fromRGBO(255, 0, 0, 1.0)
    ..style = PaintingStyle.stroke;

  Offset offset = new Offset(75.0, 325.0);
  Map cordRange;


  UserControlPad() {
    this.y = 16.0;
    this.width = 150.0;
    this.height = 150.0;
    this.cordRange = {
      'xMin': 0.0,
      'xMax': this.width,
      'yMin': 275.0,
      'yMax': 400.0
    };
  }


  @override
  void render(Canvas c) {
    prepareCanvas(c);
    c.drawCircle(offset, 75.0, paint);
    // TODO: create a way of debugging
    //c.drawRect(new Rect.fromLTWH(0.0, 300.0, width, height), debugPaint);
  }

  @override
  void update(double t) {}

  @override
  bool isHud() {
    return true;
  }
}