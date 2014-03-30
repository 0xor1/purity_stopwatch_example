/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'package:controls_and_panels/controls_and_panels.dart';
import 'package:purity_stopwatch_example/model/stopwatch.dart' as SW;
import 'package:purity_stopwatch_example/view/stopwatch_view.dart';

void main(){
  var model = new SW.Stopwatch();
  var view1 = new StopwatchView(model);
  var view2 = new StopwatchView(model);
  var panel = new StackPanel.vertical([view1, view2]);
  document.body.children.add(panel.html);
}