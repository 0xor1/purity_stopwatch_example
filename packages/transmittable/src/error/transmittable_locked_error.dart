/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class TransmittableLockedError{
  String get message => 'The Transmittable object is locked, calling any Setter on this object is an error.';
  final String setter;
  TransmittableLockedError(this.setter);
}