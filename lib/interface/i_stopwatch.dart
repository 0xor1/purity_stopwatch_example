/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.interface;

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
    registerTranSubtype('a', DurationChange);
    registerTranSubtype('b', StartEvent);
    registerTranSubtype('c', StopEvent);
  });
}