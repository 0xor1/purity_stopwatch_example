/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */


part of controls_and_panels;



class TextBox extends Control{

  static const String CLASS = 'cnp-text-box';
  InputElement _inputElement = new InputElement(type:'text');
  String get value => _inputElement.value;
  void set value (String str){
    _inputElement.value = str == null? '': str;
  }

  String get placeholder => _inputElement.placeholder;
  void set placeholder (String str){
    _inputElement.placeholder = str == null? '': str;
  }

  TextBox({String value: null, String placeholder: null}){
    _textBoxStyle.insert();
    addClass(CLASS);
    html.children.add(_inputElement);
    _inputElement
      ..onBlur.listen((_) => blur())
      ..onFocus.listen((_) => focus());
    this.placeholder = placeholder;
    this.value = value;
  }

  static final Style _textBoxStyle = new Style('''

    .$CLASS
    {
      background: #fff;
      border: 1px solid #888;
    }

    .$CLASS.${Control.FOCUS}
    {
      outline: 1px solid #fa3;
    }

    .$CLASS > input
    {
      width: calc(100% - 10px);
      padding: 5px;
      border: none;
    }

    .$CLASS > input:focus
    {
      outline: none;
    }

  ''');
}