/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class HAlign extends EnumValue{
  static const HAlign LEFT = const HAlign._internal('cnp-left');
  static const HAlign RIGHT = const HAlign._internal('cnp-right');
  static const HAlign CENTER = const HAlign._internal('cnp-center');
  static const HAlign _H_CENTER = const HAlign._internal('cnp-h-center');
  const HAlign._internal(String ali):super(ali);
  operator ==(other) => other is HAlign && value == other.value;
}