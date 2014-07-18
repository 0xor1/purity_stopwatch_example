/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class UnregisteredTypeError{
  String get message => 'Type "$type" has not been registered with registerTranType().';
  final Type type;
  const UnregisteredTypeError(this.type);
}