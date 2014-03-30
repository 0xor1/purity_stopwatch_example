/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchView;

import 'package:purity/purity_client.dart';
import 'package:eventable/eventable.dart';
import 'package:controls_and_panels/controls_and_panels.dart';
import '../interface/i_stopwatch.dart';

class StopwatchView extends Base with EventDetector{

  final IStopwatch _stopwatch;
  final DivElement _duration =
    new DivElement()
    ..classes.add('duration');
  final ButtonElement _startButton =
    new ButtonElement()
    ..text = 'Start';
  final ButtonElement _stopButton =
    new ButtonElement()
    ..text = 'Stop';
  final DivElement _buttons =
    new DivElement()
    ..classes.add('buttons');

  StopwatchView(IStopwatch this._stopwatch){

    registerTranTypes();

    html
    ..classes.add('stopwatch')
    ..children.addAll([
      _buttons
      ..children.addAll([
        _startButton,
        _stopButton
      ]),
      _duration,
    ]);

    _startButton.onClick.listen((e) => _stopwatch.start());
    _stopButton.onClick.listen((e) => _stopwatch.stop());

    listen(_stopwatch, DurationChangeEvent, _handleDurationChangeEvent);

    _stopwatch.setTimeLimit(new Duration());

  }

  String _durationToDisplayString(Duration du){
    var seconds = du.inSeconds % 60;
    seconds = seconds < 10? '0$seconds':'$seconds';
    var minutes = du.inMinutes % 60;
    minutes = minutes < 10? '0$minutes':'$minutes';
    var hours = du.inHours;
    hours = hours < 10? '0$hours':'$hours';
    return '$hours : $minutes : $seconds';
  }

  void _handleDurationChangeEvent(DurationChangeEvent e){
    _duration.text = _durationToDisplayString(e.duration);
  }

}