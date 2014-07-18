/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class InvalidTranNamespaceError{
  String get message => 'Namespace "$namespace" is invalid. Tran namespaces must not contain a "$TSD" character.';
  final String namespace;
  InvalidTranNamespaceError(this.namespace);
}