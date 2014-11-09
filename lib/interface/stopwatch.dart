/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.interface;

import 'package:purity/purity.dart';

abstract class IStopwatch{
  void start();
  void stop();
  void reset();
}

class Start extends Transmittable{}

class Stop extends Transmittable{}

class DurationChange extends Transmittable{
  Duration get duration => get('duration');
  void set duration (Duration o) => set('duration', o);
}

final Registrar registerStopwatchTranTypes = generateRegistrar(
    'stopwatch.interface', 'si', [
    new TranRegistration.subtype(DurationChange, () => new DurationChange()),
    new TranRegistration.subtype(Start, () => new Start()),
    new TranRegistration.subtype(Stop, () => new Stop())
  ]);