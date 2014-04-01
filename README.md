#Purity Stopwatch Example

The simplest possible example application I could think of to demo Purity.
Run `test/integration/index.html` to see the whole app running on the client side.
Run `bin/server.dart` file after running `pub build` to run the app as a Purity
client-server app.

##Interface

The interface library contains all the events that the models will emit and the explicit interface for each model type as well as a method to wrap all of the transmittable type registrations.

The Stopwatch model interface
```dart
abstract class IStopwatch implements Model{
  void start();
  void stop();
  void setTimeLimit(Duration du);
  void clearTimeLimit();
}
```

The Stopwatch model events
```dart
class DurationChangeEvent extends Event implements IDurationChangeEvent{}
abstract class IDurationChangeEvent{
  Duration duration;
}

class StartEvent extends Event{}

class StopEvent extends Event{}
```

The function to wrap all transmittable type registrations
```dart
bool _tranTypesRegistered = false;
void registerTranTypes(){
  if(_tranTypesRegistered){ return; }
  _tranTypesRegistered = true;
  registerTranSubtype('sw_dce', DurationChangeEvent);
  registerTranSubtype('sw_se', StartEvent);
  registerTranSubtype('sw_ste', StopEvent);
}
```

##Model

The model library is where the business logic is kept and the interface library model interfaces are implemented on each model. Notice that the `registerTranTypes()` is called in the stopwatch constructor.

The Stopwatch model
```dart
class Stopwatch extends Model implements IStopwatch{

  Timer _timer;
  String _direction = _UP;
  Duration _du = new Duration();
  bool get _isRunning => _timer != null;

  Stopwatch(){
    registerTranTypes();
  }

  void set _duration(Duration du){
    _du = new Duration(seconds:du.inSeconds.abs());
    emitEvent(
      new DurationChangeEvent()
      ..duration = _du);
  }

  void start(){
    if(!_isRunning){
      _timer = new Timer.periodic(_TIMER_TICK_DURATION, _handleTick);
      emitEvent(new StartEvent());
    }
  }

  void stop(){
    if(_isRunning){
      _timer.cancel();
      _timer = null;
      emitEvent(new StopEvent());
    }
  }

  void setTimeLimit(Duration du){
    stop();
    _direction = du.inSeconds != 0? _DOWN: _UP;
    _duration = du;
  }

  void clearTimeLimit() => setTimeLimit(new Duration());

  void _handleTick(Timer timer){
    if(_direction == _UP){
      _duration = _du + _TIMER_TICK_DURATION;
    }else{
      _duration = _du - _TIMER_TICK_DURATION;
      if(_du.inSeconds == 0){
        stop();
      }
    }
  }
}
```

##View

The view library contains the Stopwatch view, it is important to note that it only references the interface library and not the model library, and so the view constructor expects an `IStopwatch`. Also notice that the view constructor calls the `registerTranTypes()` function from the interface library also.

```dart
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
```
