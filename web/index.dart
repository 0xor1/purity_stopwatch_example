/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchClient;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:purity/client.dart';
import 'package:purity_stopwatch_example/view/stopwatch.dart';

void main(){
  initPolymer();
  initConsumerSettings(
    (stopwatch, proxyEndPoint){
      var consumer = new StopwatchConsumer(stopwatch);
      document.body.children.add(consumer.view);
    },
    (){
      //No shutdown code required for this app
    },
    'ws');
}