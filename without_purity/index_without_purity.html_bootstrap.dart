library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:purity_stopwatch_example/view/purity_stopwatch.dart' as i0;
import 'package:polymer/src/build/log_injector.dart';
import 'index_without_purity.dart' as i1;
import 'package:polymer/src/build/log_injector.dart';
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'package:purity_stopwatch_example/view/purity_stopwatch.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
abstract class _M0 {} // PolymerElement & EventDetector
abstract class _M1 {} // _M0 & ChangeNotifier

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #counter: (o) => o.counter,
        #reset: (o) => o.reset,
        #start: (o) => o.start,
        #stop: (o) => o.stop,
      },
      setters: {
        #counter: (o, v) { o.counter = v; },
      },
      parents: {
        smoke_0.PurityStopwatch: _M1,
        _M0: smoke_1.PolymerElement,
        _M1: _M0,
      },
      declarations: {
        smoke_0.PurityStopwatch: {
          #counter: const Declaration(#counter, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
      },
      names: {
        #counter: r'counter',
        #reset: r'reset',
        #start: r'start',
        #stop: r'stop',
      }));
  new LogInjector().injectLogsFromUrl('index_without_purity.html._buildLogs');
  configureForDeployment([
      () => Polymer.register('purity-stopwatch', i0.PurityStopwatch),
    ]);
  i1.main();
}
