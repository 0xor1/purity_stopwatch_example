/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.interface;

@MirrorsUsed(targets: const[
  IDurationChange
  ], override: '*')
import 'dart:mirrors';
import 'package:purity/purity.dart';

part 'stopwatch_events.dart';

abstract class IStopwatch{
  void start();
  void stop();
  void reset();
}

final Registrar registerStopwatchTranTypes = generateRegistrar(
    'stopwatch.interface', 'si', [
    new TranRegistration.subtype(DurationChange, () => new DurationChange()),
    new TranRegistration.subtype(Start, () => new Start()),
    new TranRegistration.subtype(Stop, () => new Stop())
  ]);