/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class EnumValue{
  final dynamic value;
  const EnumValue(this.value);
  operator ==(other) => other is EnumValue && value == other.value;
  int get hashCode => value.hashCode;
  String toString() => value.toString();
}