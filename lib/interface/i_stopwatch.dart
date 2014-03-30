/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library IStopwatch;

import 'package:purity/purity.dart';

part 'stopwatch_events.dart';

abstract class IStopwatch implements Model{
  void start();
  void stop();
  void setTimeLimit(Duration du);
  void clearTimeLimit();
}

bool _tranTypesRegistered = false;
void registerTranTypes(){
  if(_tranTypesRegistered){ return; }
  _tranTypesRegistered = true;
  registerTranSubtype('sw_dce', DurationChangeEvent);
  registerTranSubtype('sw_se', StartEvent);
  registerTranSubtype('sw_ste', StopEvent);
}