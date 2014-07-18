/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of eventable;

/**
 * Thrown when [detector] attempts to add [newAction] to [emitter]s action queue
 * of [type] and an [existingAction] is already assigned.
 */
class DuplicateEventSettingError{

  String get message => 'The detector is already listening for the "$type" event data type from the given emitter';
  final Type type;
  final EventEmitter emitter;
  final EventDetector detector;
  final EventAction existingAction;
  final EventAction newAction;

  const DuplicateEventSettingError(EventDetector this.detector, EventEmitter this.emitter, Type this.type, EventAction this.existingAction, EventAction this.newAction);

}