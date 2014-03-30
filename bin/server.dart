/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchServer;

import 'dart:io';
import 'package:purity/purity_server.dart';
import '../lib/model/stopwatch.dart' as SW;

void main(){
  var server = new PurityServer(InternetAddress.LOOPBACK_IP_V4, 3030, Platform.script.resolve('../build/web').toFilePath(), () => new SW.Stopwatch());
}