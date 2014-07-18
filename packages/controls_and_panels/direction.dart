/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Direction extends EnumValue{
  static const Direction UP = const Direction._internal('cnp-up');
  static const Direction DOWN = const Direction._internal('cnp-down');
  static const Direction LEFT = const Direction._internal('cnp-left');
  static const Direction RIGHT = const Direction._internal('cnp-right');
  const Direction._internal(String dir):super(dir);
  operator ==(other) => other is Direction && value == other.value;
}