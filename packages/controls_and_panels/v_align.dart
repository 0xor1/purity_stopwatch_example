/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class VAlign extends EnumValue{
  static const VAlign TOP = const VAlign._internal('cnp-top');
  static const VAlign BOTTOM = const VAlign._internal('cnp-bottom');
  static const VAlign CENTER = const VAlign._internal('cnp-center');
  static const VAlign _V_CENTER = const VAlign._internal('cnp-v-center');
  const VAlign._internal(String ali):super(ali);
  operator ==(other) => other is VAlign && value == other.value;
}