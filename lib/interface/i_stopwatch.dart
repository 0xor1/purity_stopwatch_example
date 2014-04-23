/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.interface;

import 'package:purity/purity.dart';

part 'stopwatch_events.dart';

abstract class IStopwatch implements PurityModel{
  void start();
  void stop();
  void reset();
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