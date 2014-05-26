/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.interface;

@MirrorsUsed(targets: const[
  DurationChange,
  Start,
  Stop
  ], override: '*')
import 'dart:mirrors';
import 'package:purity/purity.dart';

part 'stopwatch_events.dart';

abstract class IStopwatch{
  void start();
  void stop();
  void reset();
}

bool _stopwatchTranTypesRegistered = false;
void registerStopwatchTranTypes(){
  if(_stopwatchTranTypesRegistered){ return; }
  _stopwatchTranTypesRegistered = true;
  registerTranTypes('stopwatch.interface', 'si', (){
    registerTranSubtype('a', DurationChange, () => new DurationChange());
    registerTranSubtype('b', Start, () => new Start());
    registerTranSubtype('c', Stop, () => new Stop());
  });
}