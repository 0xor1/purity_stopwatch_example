/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

part of stopwatch.interface;

class DurationChange extends Transmittable implements IDurationChange{}
abstract class IDurationChange{
  Duration duration;
}

class Start extends Transmittable{}

class Stop extends Transmittable{}