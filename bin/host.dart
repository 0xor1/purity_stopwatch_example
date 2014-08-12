/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.host;

import 'dart:io';
import 'dart:async';
import 'package:purity/host.dart';
import 'package:purity_stopwatch_example/model/stopwatch.dart' as sw;

void main(){
  new Host(
    InternetAddress.LOOPBACK_IP_V4,
    4346,
    Platform.script.resolve('../web').toFilePath(),
    (_) => new Future.delayed(new Duration(),() => new sw.Stopwatch()),
    (stopwatch) => new Future.delayed(new Duration(), (){}),
    0)
  ..start();
}