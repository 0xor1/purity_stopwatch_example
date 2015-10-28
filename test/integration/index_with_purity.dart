/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:purity/local.dart';
import 'package:purity/client.dart' as client;
import 'package:purity_stopwatch_example/model/stopwatch.dart' as sw;
import 'package:purity_stopwatch_example/view/stopwatch.dart';

void main(){

  initPolymer();

  var host = new Host(
    (_) => new sw.Stopwatch(),
    (_){},
    0);

  var hostView = new client.LocalHostView(host);

  initConsumerSettings(
    (stopwatch, proxyEndPoint){
      var consumer = new StopwatchConsumer(stopwatch);
      hostView.addNewClientView(proxyEndPoint, consumer.view, 300);
    },
    (){});

  document.body.append(hostView.html);
}