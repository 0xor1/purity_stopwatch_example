/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Style{
  static final StyleElement _cnpStyleElement = new StyleElement()
  ..id = 'cnp-style-element';
  bool _hasBeenInserted = false;
  final String text;

  Style(String this.text);

  void insert(){
    if(_cnpStyleElement.parent != document.head){
      document.head.children.add(_cnpStyleElement);
    }
    if(!_hasBeenInserted){
      _cnpStyleElement.text += text;
      _hasBeenInserted = true;
    }
  }
}