import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

import '../util/game.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  // CONSTRUCTOR THAT LOADS IN ALL IMAGES FOR HOME SCREEN
  _HomeScreenState() {
    // TODO: implement thi correctly
    var ps = <Future>[
    Flame.images.loadAll([
      'ember_sprite.png',
      'raise_sprite.png',
      'grass.png',
      'Skeleton_Attack.png',
      'Skeleton_Dead.png',
      'Skeleton_Hit.png',
      'Skeleton_Idle.png',
      'Skeleton_React.png',
      'Skeleton_Walk.png',
      'wizard_attack.png',
      'wizard_death.png',
      'wizard_forward.png',
      'wizard_forward_transition.png',
      'wizard_idle.png',
      'knight__block.png',
      'knight__idle.png',
      'knight__improved_slash_animation.png',
      'knight_death_animation.png',
      'knight_walk_animation.png',
      'gamepad.png'
    ]).then((images) =>
          print('Done loading ' + images.length.toString() + ' images.')),
      //  Data.loadAll(),
    ];
    //TODO: understand this more
    Future.wait(ps).then((rs) => this.setState(() => loading = false));

  }
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: Text('Loading...'));
    }
    if (Main.game != null) {
      if (Main.game.state != GameState.STOPPED) {
        return Main.game.widget;
      } else {
        Main.game = null;
        setState(() {});
      }
    }
    final child = Center(
      child: Row(
        children: <Widget>[
          // TODO: determine what pushNamed is...
          FlatButton(onPressed: () => startGame(), child: Text('Play')),
        ],
      ),
    );
    return Container(
      child: child,
    );
  }
  startGame() async {
    print('start');
    var dimensions = await Flame.util.initialDimensions();
    Main.game = new BoundGame(this, dimensions);
    setState(() {});
  }
  redraw() {
    this.setState(() => {});
  }
}

class BoundGame extends GameClass {
  _HomeScreenState screen;
  BoundGame(this.screen, dimensions): super(dimensions);

  @override
  set state(GameState state) {
    super.state = state;
    if (this.screen != null) {
      (() async {
        // TODO: add pause and options
        if (state == GameState.STOPPED) {
//          Data.buy.save();
//          await this.screen.addToScore(score());

          print('Stopped');
        }
        this.screen.redraw();
      })();
    }
  }
}