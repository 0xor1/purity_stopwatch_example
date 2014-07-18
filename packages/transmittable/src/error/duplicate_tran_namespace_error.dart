/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class DuplicateTranNamespaceError{
  String get message => 'Namespace "$namespace" has already been registered.';
  final String namespace;
  final String namespaceFull;
  final Map<String, String> registeredNamespaces = _namespaces;
  DuplicateTranNamespaceError(this.namespace, this.namespaceFull);
}