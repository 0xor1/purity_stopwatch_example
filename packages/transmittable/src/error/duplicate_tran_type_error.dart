/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class DuplicateTranTypeError{
  String get message => 'Type "$type" has already been registered.';
  final Type type;
  final Map<Type, String> mapping = getRegisteredMappingsByType();
  const DuplicateTranTypeError(this.type);
}