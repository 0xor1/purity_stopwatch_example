/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library stopwatch.view;

import 'dart:html';
import 'package:purity/purity.dart';
import 'package:controls_and_panels/controls_and_panels.dart';
import '../interface/i_stopwatch.dart';

class StopwatchView extends Consumer{

  dynamic get stopwatch => source;
  
  DivElement get html => _rootContainer.html;
  
  final SizerPanel _rootContainer =
    new SizerPanel('100%', '100%');
  final StackPanel _containerStack =
    new StackPanel.vertical();
  final SizerPanel _upperButtonsSizer = new SizerPanel('230px', '35px');
  final StackPanel _upperButtonsStack =
    new StackPanel.horizontal();
  final Button _startButton = 
    new Button(new SizerPanel('100px', '22px')..add(new Label('Start')));
  final Button _stopButton = 
    new Button(new SizerPanel('100px', '22px')..add(new Label('Stop')));
  final Button _resetButton = 
    new Button(new SizerPanel('220px', '22px')..add(new Label('Reset')));
  final SizerPanel _durationSizer = new SizerPanel('230px', '35px');
  final Label _durationLabel =
    new Label('');
  final SizerPanel _resetSizer = new SizerPanel('230px', '35px');
  
  StopwatchView(stopwatch):
    super(stopwatch){

    registerStopwatchTranTypes();

    _rootContainer
    ..add(
      _containerStack
      ..add(
        _upperButtonsSizer
        ..add(
          _upperButtonsStack
          ..add(_startButton)
          ..add(new SizerPanel('10px', '0px'))
          ..add(_stopButton)))
      ..add(
        _durationSizer
        ..add(_durationLabel))
      ..add(
        _resetSizer
        ..add(_resetButton)));
    
    _hookUpEvents();
    stopwatch.reset();
  }
  
  void _hookUpEvents(){
    _startButton.onClick.listen((e) => stopwatch.start());
    _stopButton.onClick.listen((e) => stopwatch.stop());
    _resetButton.onClick.listen((e) => stopwatch.reset());
    listen(stopwatch, DurationChangeEvent, _handleDurationChangeEvent);
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
    _durationLabel.text = _durationToDisplayString(e.duration);
  }

}