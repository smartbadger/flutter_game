import 'package:flame/components/parallax_component.dart';

class StaticBackground extends ParallaxComponent{
  StaticBackground() :super();
  @override
  void update(double t) {

  }
}

//import 'dart:io';
//import 'dart:math';
//import 'dart:ui';
//
//import 'package:flame/flame.dart';
//
//const MIN_SIZE = 45;
//const MAX_SIZE = 100;
//final Random random = new Random();
//
//const FILL = const Color(0xFFBABFC3);
//const LIGHT = const Color(0xFFC1C1C1);
//const DARK = const Color(0xFF9DA2A6);
//// TODO: if needed
//class ImageBuilder {
//  int width, height;
//  List<List<Color>> pixels;
//  Map<Color, List<Offset>> pixelMap = new Map();
//
//  ImageBuilder(this.width, this.height) {
//    this.pixels = new List(this.width);
//    for (int i = 0; i < width; i++) {
//      this.pixels[i] = new List(this.height);
//    }
//  }
//
//  void set(int x, int y, Color c) {
//    if (pixels.length <= x || pixels[x].length <= y) {
//      // don't draw out of range
//      return;
//    }
//    pixels[x][y] = c;
//    pixelMap.putIfAbsent(c, () => new List());
//    pixelMap[c].add(new Offset(x.toDouble(), y.toDouble()));
//  }
//
//  Color get(int x, int y) {
//    return pixels[x][y];
//  }
//
//  Image toImage() {
//    PictureRecorder recorder = new PictureRecorder();
//    Rect everything =
//    new Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble());
//    Canvas c = new Canvas(recorder, everything);
//    c.drawRect(everything, new Paint()..color = FILL);
//    pixelMap.forEach((color, points) => c.drawPoints(
//        PointMode.points,
//        points,
//        new Paint()
//          ..color = color
//          ..strokeWidth = 1.0
//          ..strokeCap = StrokeCap.square));
//    return recorder.endRecording().toImage(width, height);
//  }
//}
//
//Point findFirstEmpty(ImageBuilder b) {
//  for (int i = 0; i < b.width; i++) {
//    for (int j = 0; j < b.height; j++) {
//      if (b.get(i, j) == null) {
//        return new Point(i, j);
//      }
//    }
//  }
//  return null;
//}
//
//int nextInWidth(ImageBuilder image, Point start) {
//  for (int i = start.x + 1; i < image.width; i++) {
//    if (image.get(i, start.y) != null) {
//      return i - 1;
//    }
//  }
//  return image.width;
//}
//
//int nextInHeight(ImageBuilder image, Point start) {
//  for (int j = start.y + 1; j < image.height; j++) {
//    if (image.get(start.x, j) != null) {
//      return j - 1;
//    }
//  }
//  return image.height;
//}
//
//int randomInt(int min, int max) {
//  return random.nextInt(max - min) + min;
//}
//
//void drawSquare(ImageBuilder image, Point p, int w, int h) {
//  for (int j = 0; j < h; j++) {
//    image.set(p.x, p.y + j, DARK);
//  }
//  for (int i = 0; i < w; i++) {
//    image.set(p.x + i, p.y + h - 1, DARK);
//  }
//
//  for (int i = 0; i < w; i++) {
//    image.set(p.x + i, p.y, LIGHT);
//  }
//  for (int j = 0; j < h; j++) {
//    image.set(p.x + w - 1, p.y + j, LIGHT);
//  }
//
//  for (int i = 1; i < w - 1; i++) {
//    for (int j = 1; j < h - 1; j++) {
//      image.set(p.x + i, p.y + j, FILL);
//    }
//  }
//
//  drawScrew(image, p.x + 4, p.y + 4);
//  drawScrew(image, p.x + w - 5, p.y + 4);
//  drawScrew(image, p.x + w - 5, p.y + h - 5);
//  drawScrew(image, p.x + 4, p.y + h - 5);
//}
//
//void drawScrew(ImageBuilder image, int x, int y) {
//  image.set(x, y, DARK);
//  image.set(x, y + 1, DARK);
//  image.set(x + 1, y + 1, DARK);
//}
//
//Image generate(int width, int height) {
//  try {
//    ImageBuilder image = drawOnBuilder(width, height);
//    return image.toImage();
//  } on Error {
//    Image image;
//    Flame.images.load('grass.png').then((img) => image = img);
//    while (image == null) {
//      sleep(new Duration(milliseconds: 50));
//    }
//    return image;
//  }
//}
//
//ImageBuilder drawOnBuilder(int width, int height) {
//  ImageBuilder image = new ImageBuilder(width, height);
//
//  int count = 0;
//  while (count < 40) {
//    Point next = findFirstEmpty(image);
//    if (next == null) {
//      break;
//    }
//
//    int nextWidth = randomInt(MIN_SIZE, MAX_SIZE);
//    int nextX = nextInWidth(image, next);
//    if (next.x + nextWidth > nextX) {
//      nextWidth = nextX - next.x;
//    } else if (nextX - (next.x + nextWidth) < MIN_SIZE) {
//      nextWidth = nextX - next.x - MIN_SIZE;
//    }
//    if (next.x + nextWidth > width) {
//      nextWidth = width - next.x;
//    }
//
//    int nextHeight = randomInt(MIN_SIZE, MAX_SIZE);
//    int nextY = nextInHeight(image, next);
//    if (next.y + nextHeight > nextY) {
//      nextHeight = nextY - next.y;
//    } else if (nextY - (next.y + nextHeight) < MIN_SIZE) {
//      nextHeight = nextY - next.y - MIN_SIZE;
//    }
//    if (next.y + nextHeight > height) {
//      nextHeight = height - next.y;
//    }
//
//    drawSquare(image, next, nextWidth, nextHeight);
//    count++;
//  }
//  return image;
//}
