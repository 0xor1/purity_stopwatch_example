/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of eventable;

/**
 * A mixin class to enable any object to emit custom events.
 */
class EventEmitter{

  Map<Type, List<EventAction>> _actionQueues;
  /// Describes whether the object is currently emitting an event.
  bool get isEmitting => _emittingType != null;
  Type _emittingType;
  /// Specifies which event type is currently being emitted by the object.
  Type get emittingType => _emittingType;

  /**
   * Adds the [action] to the action queue of [type].
   */
  void addEventAction(Type type, EventAction action){
    if(_emittingType == type){
      _emittingType = null;
      throw new EmitTimeQueueChangeError(this, type, action);
    }
    if(_actionQueues == null){
      _actionQueues = new Map<Type, List<EventAction>>();
    }
    if(_actionQueues[type] == null){
      _actionQueues[type] = new List<EventAction>();
    }
    _actionQueues[type].add(action);
  }

  /**
   * Removes the [action] from the action queue of [type].
   */
  void removeEventAction(Type type, EventAction action){
    if(_emittingType == type){
      _emittingType = null;
      throw new EmitTimeQueueChangeError(this, type, action);
    }
    if(_actionQueues != null && _actionQueues[type] != null){
      _actionQueues[type].remove(action);
      if(_actionQueues[type].isEmpty){
        _actionQueues.remove(type);
        if(_actionQueues.isEmpty){
          _actionQueues = null;
        }
      }
    }
  }

  /**
   * Calls all the actions in the queue of type [data] with an [Event] containing [data]
   * asynchronously, returning a [Future] that completes with the [Event] when all of the
   * [EventAction]s have been called.
   */
  Future<Event> emitEvent(dynamic data){
    var event = new Event._internal(this, data);
    var finished;
    //make eventQueues execute async so only one event queue is ever executing at a time.
    finished = new Future<Event>.delayed(new Duration(), (){
      event._finished = finished;
      _emittingType = reflect(data).type.reflectedType;
      if(_actionQueues != null && _actionQueues[_emittingType] != null){
        _actionQueues[_emittingType].forEach((EventAction action){ action(event); });
      }

      if(_actionQueues != null && _actionQueues[Omni] != null){
        _actionQueues[Omni].forEach((EventAction action){ action(event); });
      }
      _emittingType = null;
      return event;
    });

    return finished;
  }

}