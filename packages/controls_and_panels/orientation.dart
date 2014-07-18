/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Orientation extends EnumValue{
  static const Orientation HORIZONTAL = const Orientation._internal('cnp-horizontal');
  static const Orientation VERTICAL = const Orientation._internal('cnp-vertical');
  const Orientation._internal(String ori):super(ori);
  operator ==(other) => other is Orientation && value == other.value;
}