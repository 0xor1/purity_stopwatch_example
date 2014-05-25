/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.model;

import 'dart:async';
import 'package:purity/purity.dart';
import '../interface/i_stopwatch.dart';

const Duration _TIMER_TICK_DURATION = const Duration(seconds:1);

class Stopwatch extends Source implements IStopwatch{

  Timer _timer;
  Duration _du = new Duration();
  bool get _isRunning => _timer != null;

  Stopwatch(){
    registerStopwatchTranTypes();
  }

  void set _duration(Duration du){
    _du = new Duration(seconds:du.inSeconds.abs());
    emitEvent(
      new DurationChange()
      ..duration = _du);
  }

  void start(){
    if(!_isRunning){
      _timer = new Timer.periodic(_TIMER_TICK_DURATION, _handleTick);
      emitEvent(new StartEvent());
    }
  }

  void stop(){
    if(_isRunning){
      _timer.cancel();
      _timer = null;
      emitEvent(new StopEvent());
    }
  }

  void reset(){
    stop();
    _duration = new Duration();
  }

  void _handleTick(Timer timer){
    _duration = _du + _TIMER_TICK_DURATION;
  }

}