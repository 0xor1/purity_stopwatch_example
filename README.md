#Purity Stopwatch Example

The simplest possible example application I could think of to demo Purity.
Run `test/integration/index_without_purity.html` to see the whole app running
on the client side with the view directly consuming the model, or run
`test/integration/index_with_purity.html` to see the whole app running on the 
client side with remote proxy objects relaying meesages through the core Purity
app server also running in the browser.

Run `pub build` and then run `build/bin/server.dart` to run the app as a full Purity
client-server app.

##Interface

The interface library contains all the events that the models will emit and the explicit interface for each model type as well as a method to wrap all of the transmittable type registrations.

The Stopwatch model interface
```dart
abstract class IStopwatch implements Model{
  void start();
  void stop();
  void reset();
}
```

The Stopwatch model events
```dart
class DurationChangeEvent extends PurityEvent implements IDurationChangeEvent{}
abstract class IDurationChangeEvent{
  Duration duration;
}

class StartEvent extends PurityEvent{}

class StopEvent extends PurityEvent{}
```

The function to wrap all transmittable type registrations
```dart
bool _stopwatchTranTypesRegistered = false;
void registerStopwatchTranTypes(){
  if(_stopwatchTranTypesRegistered){ return; }
  _stopwatchTranTypesRegistered = true;
  registerTranTypes('Stopwatch', 's', (){
    registerTranSubtype('a', DurationChangeEvent);
    registerTranSubtype('b', StartEvent);
    registerTranSubtype('c', StopEvent);
  });
}
```

##Model

The model library is where the business logic is kept and the interface library model interfaces are implemented on each model. Notice that the `registerStopwatchTranTypes()` is called in the stopwatch constructor.

The Stopwatch model
```dart
class Stopwatch extends PurityModel implements IStopwatch{

  Timer _timer;
  Duration _du = new Duration();
  bool get _isRunning => _timer != null;

  Stopwatch(){
    registerStopwatchTranTypes();
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

  void reset(){
    stop();
    _direction = new Duration();
  }

  void _handleTick(Timer timer){
    _duration = _du + _TIMER_TICK_DURATION;
  }
}
```

##View

The view library contains the Stopwatch view, it is important to note that it only references the interface library and not the model library, and so the view constructor expects an `IStopwatch`. Also notice that the view constructor calls the `registerStopwatchTranTypes()` function from the interface library also.

```dart
class StopwatchView extends PurityModelConsumer{

  dynamic get stopwatch => model;
  
  final DivElement html = new DivElement();
  final DivElement _duration =
    new DivElement()
    ..classes.add('duration');
  final ButtonElement _startButton =
    new ButtonElement()
    ..text = 'Start';
  final ButtonElement _stopButton =
    new ButtonElement()
    ..text = 'Stop';
  final ButtonElement _resetButton =
    new ButtonElement()
    ..text = 'Reset';
  final DivElement _buttons =
    new DivElement()
    ..classes.add('buttons');

  StopwatchView(stopwatch):
    super(stopwatch){
    
    registerStopwatchTranTypes();
    /**
     * setup html stuff
     */
    _hookUpEvents()
    stopwatch.reset();
    
  }

  void _hookUpEvents(){
    _startButton.onClick.listen((e) => stopwatch.start());
    _stopButton.onClick.listen((e) => stopwatch.stop());
    _resetButton.onClick.listen((e) => stopwatch.reset());
    listen(stopwatch, DurationChangeEvent, _handleDurationChangeEvent);
  }
  
  String _durationToDisplayString(Duration du){
    // duration to display string stuff
  }

  void _handleDurationChangeEvent(DurationChangeEvent e){
    _duration.text = _durationToDisplayString(e.duration);
  }

}
```
