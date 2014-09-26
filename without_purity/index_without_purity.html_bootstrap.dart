library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_meta.dart' as i0;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset.dart' as i1;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon.dart' as i2;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_focusable.dart' as i3;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_ripple.dart' as i4;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_shadow.dart' as i5;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_button.dart' as i6;
import 'package:polymer/src/build/log_injector.dart';
import 'package:purity_stopwatch_example/view/purity_stopwatch.dart' as i7;
import 'package:polymer/src/build/log_injector.dart';
import 'index_without_purity.dart' as i8;
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
        #blurAction: (o) => o.blurAction,
        #contextMenuAction: (o) => o.contextMenuAction,
        #counter: (o) => o.counter,
        #downAction: (o) => o.downAction,
        #focusAction: (o) => o.focusAction,
        #icon: (o) => o.icon,
        #iconSrc: (o) => o.iconSrc,
        #label: (o) => o.label,
        #raisedButton: (o) => o.raisedButton,
        #reset: (o) => o.reset,
        #start: (o) => o.start,
        #stop: (o) => o.stop,
        #upAction: (o) => o.upAction,
        #z: (o) => o.z,
      },
      setters: {
        #counter: (o, v) { o.counter = v; },
        #icon: (o, v) { o.icon = v; },
        #iconSrc: (o, v) { o.iconSrc = v; },
        #z: (o, v) { o.z = v; },
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
        #blurAction: r'blurAction',
        #contextMenuAction: r'contextMenuAction',
        #counter: r'counter',
        #downAction: r'downAction',
        #focusAction: r'focusAction',
        #icon: r'icon',
        #iconSrc: r'iconSrc',
        #label: r'label',
        #raisedButton: r'raisedButton',
        #reset: r'reset',
        #start: r'start',
        #stop: r'stop',
        #upAction: r'upAction',
        #z: r'z',
      }));
  new LogInjector().injectLogsFromUrl('index_without_purity.html._buildLogs');
  configureForDeployment([
      i0.upgradeCoreMeta,
      i1.upgradeCoreIconset,
      i2.upgradeCoreIcon,
      i3.upgradePaperFocusable,
      i4.upgradePaperRipple,
      i5.upgradePaperShadow,
      i6.upgradePaperButton,
      () => Polymer.register('purity-stopwatch', i7.PurityStopwatch),
    ]);
  i8.main();
}
