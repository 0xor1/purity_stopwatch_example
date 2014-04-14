/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'package:purity/purity.dart';
import 'package:purity_stopwatch_example/model/stopwatch.dart' as SW;
import 'package:purity_stopwatch_example/view/stopwatch_view.dart';

void main(){
  
  var purityTestServer = new PurityTestServer(() => new SW.Stopwatch(), (stopwatch){});
  
  initPurityTestAppView(
    (stopwatch){
      var view = new StopwatchView(stopwatch);
      document.body.children.add(view.html);
    },
    (){});

  purityTestServer.simulateNewClient();
  purityTestServer.simulateNewClient();
  purityTestServer.simulateNewClient();
  purityTestServer.simulateNewClient();
}