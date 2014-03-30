/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchClient;

import 'dart:html';
import 'package:purity/purity_client.dart';
import '../lib/view/stopwatch_view.dart';

void main(){
  initPurityAppView((stopwatch){
    var view = new StopwatchView(stopwatch);
    document.body.children.add(view.html);
  });
}