/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:purity_stopwatch_example/model/stopwatch.dart' as SW;
import 'package:purity_stopwatch_example/view/purity_stopwatch.dart';

void main(){
  initPolymer();
  var model = new SW.Stopwatch();
  var consumer = new StopwatchConsumer(model);
  document.body.children.add(consumer.view);
}