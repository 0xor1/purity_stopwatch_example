/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

part of IStopwatch;

class DurationChangeEvent extends PurityEvent implements IDurationChangeEvent{}
abstract class IDurationChangeEvent{
  Duration duration;
}

class StartEvent extends PurityEvent{}

class StopEvent extends PurityEvent{}