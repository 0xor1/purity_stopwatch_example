/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchClient;

import 'dart:html';
import 'package:purity/purity_client.dart';
import 'package:purity_stopwatch_example/view/stopwatch_view.dart';

void main(){
  initPurityAppView(
    'ws',
    (stopwatch){
      var view = new StopwatchView(stopwatch);
      document.body.children.add(view.html);
   },
   (){
     //No shutdown code required for this app
   });
}