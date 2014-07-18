/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */


part of controls_and_panels;

class Label extends Control{

  static const String CLASS = 'cnp-label';
  String get text => html.text;
  void set text (String text){html.text = text;}

  Label(String text){
    _labelStyle.insert();
    addClass(CLASS);
    this.text = text;
  }

  static final Style _labelStyle = new Style('''

    .$CLASS 
    {
      white-space: nowrap;
    }

  ''');
}