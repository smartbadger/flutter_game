
import 'package:flutter/material.dart' show Colors, TextPainter, runApp;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'util/game.dart';
import 'routes/homeScreen.dart';

class Main {
  static GameClass game;

}
  main() async {
    Flame.audio.disableLog();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    runApp(new MaterialApp(
        home: new Scaffold(body: new HomeScreen()),
        routes: {
//          '/start': (BuildContext ctx) => new Scaffold(body: StartGameScreen()),
        }
    ));
  }

//  Flame.audio.loop('music.ogg');
//  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
//    ..onTapDown = (TapDownDetails evt) => game.input(evt.globalPosition));

