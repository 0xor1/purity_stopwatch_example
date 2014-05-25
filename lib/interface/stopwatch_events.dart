/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

part of stopwatch.interface;

class DurationChange extends Transmittable implements IDurationChange{}
abstract class IDurationChange{
  Duration duration;
}

class StartEvent extends Transmittable{}

class StopEvent extends Transmittable{}