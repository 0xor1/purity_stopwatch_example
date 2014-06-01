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
    registerTranSubtype(DurationChange, () => new DurationChange());
    registerTranSubtype(Start, () => new Start());
    registerTranSubtype(Stop, () => new Stop());
  });
}