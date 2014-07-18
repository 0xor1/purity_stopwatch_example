/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'dart:async';
import 'package:purity/local.dart';
import 'package:purity/client.dart' as client;
import 'package:purity_stopwatch_example/model/stopwatch.dart' as sw;
import 'package:purity_stopwatch_example/view/stopwatch_view.dart';

void main(){

  var host = new Host(
    (_) => new Future.delayed(new Duration(), () => new sw.Stopwatch()),
    (_) => new Future.delayed(new Duration(), (){}),
    0);

  var hostView = new client.LocalHostView(host);

  initConsumerSettings(
    (stopwatch, proxyEndPoint){
      var view = new StopwatchView(stopwatch);
      hostView.addNewClientView(proxyEndPoint, view.html, 300);
    },
    (){});

  document.body.append(hostView.html);
}