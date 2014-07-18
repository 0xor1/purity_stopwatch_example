/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of eventable;

/**
 * Thrown when an [EventAction] attempts to add or remove [EventAction]s from
 * the action queue currently being called.
 */
class EmitTimeQueueChangeError{

  String get message => 'The emitter is currently emitting an event with data of type "$type", a call to add/removeEventAction at emit time, of that event data type, is an error.';
  final Type type;
  final EventEmitter emitter;
  final EventAction action;

  const EmitTimeQueueChangeError(EventEmitter this.emitter, Type this.type, EventAction this.action);

}