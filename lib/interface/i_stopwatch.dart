/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library IStopwatch;

import 'package:purity/purity.dart';

part 'stopwatch_events.dart';

abstract class IStopwatch{
  void start();
  void stop();
  void setTimeLimit(Duration du);
  void clearTimeLimit();
}

bool _stopwatchTranTypesRegistered = false;
void registerStopwatchTranTypes(){
  if(_stopwatchTranTypesRegistered){ return; }
  _stopwatchTranTypesRegistered = true;
  registerTranTypes('Stopwatch', 's', (){
    registerTranSubtype('a', DurationChangeEvent);
    registerTranSubtype('b', StartEvent);
    registerTranSubtype('c', StopEvent);
  });
}