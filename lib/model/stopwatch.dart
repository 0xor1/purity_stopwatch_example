/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library Stopwatch;

import 'dart:async';
import 'package:purity/purity.dart';
import '../interface/i_stopwatch.dart';

const Duration _TIMER_TICK_DURATION = const Duration(seconds:1);
const String _UP = 'up';
const String _DOWN = 'down';

class Stopwatch extends Model implements IStopwatch{

  Timer _timer;
  String _direction = _UP;
  Duration _du = new Duration();
  bool get _isRunning => _timer != null;

  StopWatch(){
    registerTranTypes();
  }

  void set _duration(Duration du){
    _du = new Duration(seconds:du.inSeconds.abs());
    emitEvent(
      new DurationChangeEvent()
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

  void setTimeLimit(Duration du){
    stop();
    _direction = du.inSeconds != 0? _DOWN: _UP;
    _duration = du;
  }

  void clearTimeLimit() => setTimeLimit(new Duration());

  void _handleTick(Timer timer){
    if(_direction == _UP){
      _duration = _du + _TIMER_TICK_DURATION;
    }else{
      _duration = _du - _TIMER_TICK_DURATION;
      if(_du.inSeconds == 0){
        stop();
      }
    }
  }

}