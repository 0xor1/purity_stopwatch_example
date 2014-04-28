/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchLocalTest;

import 'dart:html';
import 'package:purity/purity.dart';
import 'package:purity/purity_client.dart';
import 'package:purity_stopwatch_example/model/stopwatch.dart' as sw;
import 'package:purity_stopwatch_example/view/stopwatch_view.dart';

void main(){
  
  var purityTestServer = new PurityTestServer(() => new sw.Stopwatch(), (stopwatch){}, 0);
  var purityTestServerView = new PurityTestServerView(purityTestServer);
  
  initPurityTestAppView(
    (stopwatch){
      var view = new StopwatchView(stopwatch);
      purityTestServerView.addNewClientView(view.html);
    },
    (){});
  
  document.body.append(purityTestServerView.html);
}