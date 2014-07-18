/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class TranRegistrationOutsideOfNamespaceError{
  String get message => 'Calls to registerTranCodec and registerTranSubtype must only be made from within the second parameter of registerTranTypes.';
  final Type type;
  const TranRegistrationOutsideOfNamespaceError(this.type);
}