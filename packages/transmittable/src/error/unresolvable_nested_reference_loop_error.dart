/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

class UnresolvableNestedReferenceLoopError{
  String get message => 'transmittable.toTranString() method called in an illegal nested location';
  final Transmittable transmittable;
  const UnresolvableNestedReferenceLoopError(this.transmittable);
}