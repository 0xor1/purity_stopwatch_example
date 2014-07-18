/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'package:purity_stopwatch_example/model/stopwatch.dart' as SW;
import 'package:purity_stopwatch_example/view/stopwatch_view.dart';

void main(){
  var model = new SW.Stopwatch();
  var view = new StopwatchView(model);
  document.body.children.add(view.html);
}