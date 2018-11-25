import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as material;

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/debug_component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

import '../components/player.dart';
import '../components/creep.dart';
import '../components/entity.dart';
import 'package:flutter_game/ui/userActionInput.dart';
import '../util/background.dart';
import '../ui/healthbar.dart';




// TODO: What are these and why are they here?
const double BAR_SIZE = 16.0;
const double SECTOR_LENGTH = 1000.0;

final tenth = (Size size) => (size.height - 2 * BAR_SIZE) / 8;
math.Random random = new math.Random();
// SET THE DIFFERENT STATE OPTIONS
enum GameState {
  RUNNING, DEAD, AD, STOPPED
}

class GameClass extends BaseGame {
  Size dimensions;
  Future<AudioPlayer> music;
  GameState _state;
  GameState get state => _state;
  double gameSpeed = 50.0;
  Player player = new Player();

  UserActionInput controlPad = new UserActionInput(
      new Sprite('raise_sprite.png', width : 150.0),
      new Sprite('raise_sprite.png', x : 150.0, width : 150.0),
      75.0,
      new Position(10.0, 200.0)
  )
    ..coolDownLimit = 0.1;

  // TODO: create HUD builder that adds components on
  UserActionInput summon = new UserActionInput(
    new Sprite('raise_sprite.png', width : 150.0),
    new Sprite('raise_sprite.png', x : 150.0, width : 150.0),
    75.0,
      new Position(600.0, 335.0)
  )
    ..coolDownLimit = 10.5;
  UserActionInput attack = new UserActionInput(
      new Sprite('ember_sprite.png', width : 150.0),
      new Sprite('ember_sprite.png', x : 150.0, width : 150.0),
      75.0,
      new Position(520.0, 335.0)
  )
    ..coolDownLimit = 3.5;
  StaticBackground bg = new StaticBackground();

  List<Creep> creepArray = new List();
  List<Entity> entityArray = new List();
  Position playerPos = new Position(0.0, 0.0);
  HealthBar healthBar = new HealthBar();

  // TODO: create a dataStructure to manage info?




  set state(GameState state) {
    if (state == GameState.STOPPED) {
      if (music != null) {
        music.then((p) => p.release());
      }
    }
    _state = state;
  }
  GameClass(this.dimensions) {
    _start();
    print(this.dimensions);
    this.player.dimensions = this.dimensions;
    this.bg.load(['grass.png']);
    this.bg.resize(this.dimensions);
    this.controlPad.setBySize(new Position(150.0, 150.0));
    this.controlPad.setByPosition(new Position(this.dimensions.width * 0.025, (this.dimensions.height * 0.9725) - controlPad.height));
    print(this.controlPad.x);
  }
  handleDrag(Offset offset) {
    // TODO: this needs to be lighter weight consider having some mapping for any hud controls managed by a separate object

    if(this.controlPad.inBoundingBox(offset)){
      this.player.targetPos = this.controlPad.calculateSinCosine(offset);
      this.player.moving = true;
    }
  }
  void _start() {
    Flame.util.addGestureRecognizer(createDragRecognizer());
    Flame.util.addGestureRecognizer(createTapRecognizer());

    add(this.bg);
    add(this.player);
    add(this.controlPad);
    add(this.summon);
    add(this.attack);
    add(this.healthBar);


    state = GameState.RUNNING;

  }
  // TODO: create separate function that delegates action based on an array of components and distance from evt
  void generateCreep(Offset offset) {

    if(this.summon.inBoundingBox(offset)){
      this.summon.state = 'inactive';
      Creep newCreep = new Creep();
      this.creepArray.add(newCreep);
      add(newCreep);
    }
    if(this.attack.inBoundingBox(offset)){
      this.attack.state = 'inactive';
      Entity newEntity = new Entity();
      this.entityArray.add(newEntity);
      add(newEntity);
    }
  }


  @override
  void render(Canvas c) {
    if (state == GameState.RUNNING || state == GameState.DEAD) {
      super.render(c);
    } else {
      c.drawRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height), new Paint()..color = material.Colors.black);
    }
  }


  GestureRecognizer createDragRecognizer() {
    PanGestureRecognizer recognizer = new PanGestureRecognizer();
      recognizer.onStart = (DragStartDetails details) => this.handleDrag(details.globalPosition);
      recognizer.onUpdate = (DragUpdateDetails details) => this.handleDrag(details.globalPosition);
      recognizer.onEnd = (DragEndDetails details) => this.player.moving = false;

    return recognizer;
  }

  GestureRecognizer createTapRecognizer() {
    TapGestureRecognizer recognizer = new TapGestureRecognizer();
    recognizer..onTapDown = (TapDownDetails details) => this.handleDrag(details.globalPosition);
    return recognizer;
  }
  // Game loops here
  @override
  void update(double dt) {
    this.playerPos.x = this.player.x;
    this.playerPos.y = this.player.y;
    if (this.creepArray.length > 0) {
      this.creepArray.forEach((creep) {
        // TODO: needs better handling of radial movement, and doesn't turn off, also need smoother animation handling
        if(creep.distance(this.player) > (this.player.width)){
          creep.state = 'running';
          creep.targetPos = this.playerPos;
        }else {
          creep.state = 'idle';
        }
        // TODO: flawed logic here, its just to get it working
        if(entityArray.length > 0 ){
          if(creep.distance(entityArray[0]) > (entityArray[0].width)){
            creep.attack(entityArray[0]);
            entityArray[0].attack(creep);
          }
        }

      });

      this.entityArray.forEach((entity) {

        // TODO: needs better handling of radial movement, and doesn't turn off, also need smoother animation handling
        if (entity.distance(this.player) > (this.player.width + 30.0)) {
          entity.state = 'running';
          entity.targetPos = this.playerPos;
        } else {
          entity.state = 'idle';
        }
      });
    }
    // update needs to call itself to work
    super.update(dt);
  }
}

