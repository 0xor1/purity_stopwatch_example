/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of eventable;

/**
 * Mixin to enable any object to detect custom events and manage [EventAction]s,
 * used in conjunction with [EventEmitter].
 */
class EventDetector{

  Map<EventEmitter, Map<Type, EventAction>> _typeIndexes;
  Map<Type, Map<EventEmitter, EventAction>> _emitterIndexes;

  /**
   * Adds an [action] to the [emitter]s action queue of [type].
   */
  void listen(EventEmitter emitter, Type type, EventAction action){
    _initialiseIndexes(emitter, type);
    if(_typeIndexes[emitter][type] != null){
      throw new DuplicateEventSettingError(this, emitter, type, _typeIndexes[emitter][type], action);
    }else{
      _typeIndexes[emitter][type] = _emitterIndexes[type][emitter] = action;
      emitter.addEventAction(type, action);
    }
  }

  void _initialiseIndexes(EventEmitter emitter, Type type){
    if(_typeIndexes == null){
      _typeIndexes = new Map<EventEmitter, Map<Type, EventAction>>();
    }
    if(_typeIndexes[emitter] == null){
      _typeIndexes[emitter] = new Map<Type, EventAction>();
    }
    if(_emitterIndexes == null){
      _emitterIndexes = new Map<Type, Map<EventEmitter, EventAction>>();
    }
    if(_emitterIndexes[type] == null){
      _emitterIndexes[type] = new Map<EventEmitter, EventAction>();
    }
  }

  /**
   * Removes the [EventAction] assigned to the [emitter]s action queue of [type].
   */
  void ignoreSpecificEventBinding(EventEmitter emitter, Type type){
    if(_typeIndexes != null && _typeIndexes[emitter] != null && _typeIndexes[emitter][type] != null){
      EventAction action = _typeIndexes[emitter].remove(type);
      _emitterIndexes[type].remove(emitter);
      emitter.removeEventAction(type, action);
      if(_typeIndexes[emitter].isEmpty){
        _typeIndexes.remove(emitter);
      }
      if(_emitterIndexes[type].isEmpty){
        _emitterIndexes.remove(type);
      }
    }
  }

  /**
   * Removes all [EventAction]s attached to all action queues of [type].
   */
  void ignoreAllEventsOfType(Type type){
    if(_emitterIndexes != null && _emitterIndexes[type] != null){
      var emitterIndex = _emitterIndexes[type];
      while(emitterIndex.isNotEmpty){
        ignoreSpecificEventBinding(emitterIndex.keys.first, type);
      }
    }
  }

  /**
   * Removes all [EventAction]s attached to [emitter].
   */
  void ignoreAllEventsFrom(EventEmitter emitter){
    if(_typeIndexes != null && _typeIndexes[emitter] != null){
      var typeIndex = _typeIndexes[emitter];
      while(typeIndex.isNotEmpty){
        ignoreSpecificEventBinding(emitter, typeIndex.keys.first);
      }
    }
  }

  /**
   * Removes all [EventAction]s this object has previously attached to all [EventEmitter]s and of all event types.
   */
  void ignoreAllEvents(){
    if(_typeIndexes != null)
    while(_typeIndexes.isNotEmpty){
      ignoreAllEventsFrom(_typeIndexes.keys.first);
    }
  }

}