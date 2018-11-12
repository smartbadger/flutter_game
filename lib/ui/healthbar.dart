
import 'dart:ui';
import 'package:flame/components/component.dart';
// TODO: create abstract from this or base class for all user inputs and huds

class HealthBar extends PositionComponent {
  static final Paint paint = new Paint()..color = Color.fromRGBO(255, 0, 0, 1.0);
  Map cordRange;


  HealthBar() {
    this.y = 16.0;
    this.width = 100.0;
    this.height = 25.0;
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
    // TODO: create a way of debugging
    c.drawRect(new Rect.fromLTWH(150.0, 370.0, width, height), paint);
  }

  @override
  void update(double t) {}

  @override
  bool isHud() {
    return true;
  }
}