/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Paragraph extends Control{

  static const String CLASS = 'cnp-paragraph';

  String get text => html.text;
  void set text (String text){ html.text = text; }

  Paragraph(String text){
    _paragraphStyle.insert();
    addClass(CLASS);
    this.text = text;
  }

  static final Style _paragraphStyle = new Style('''

    .$CLASS
    {
    }

  ''');
}